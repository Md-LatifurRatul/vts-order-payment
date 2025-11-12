import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/controller/device_api_controller.dart';
import 'package:vts_price/presentation/package_list/screen/package_list.dart';
import 'package:vts_price/presentation/screen/checkout_billing_screen.dart';
import 'package:vts_price/presentation/widgets/custom_app_snackbar.dart';
import 'package:vts_price/services/storage/order_storage.dart';
import 'package:vts_price/utils/logger.dart';

class CheckoutController {
  static Future<void> handleCheckout(BuildContext context) async {
    final cart = Provider.of<CartProvider>(context, listen: false);

    if (cart.cartItems.isEmpty) {
      CustomAppSnackbar.show(context, message: "Your cart is empty");
      return;
    }

    try {
      /// Step 1: Price validation
      for (final item in cart.cartItems) {
        final response = await DeviceApiController.fetchDevicePackage(item.id!);
        // Logger.log("CheckoutController - Price check: $response");

        if (response == null || response["status"] != "success") {
          await showErrorDialog(context, "Unable to verify price. Try again.");
          return;
        }

        final freshData = response["data"];
        final freshPrice =
            double.tryParse(freshData["payable_amount"].toString()) ?? 0.0;
        final localPrice = item.payableAmount ?? 0.0;

        if ((freshPrice - localPrice).abs() > 0.01) {
          await showDiscountExpiredDialog(context, item.name ?? "");
          cart.removeById(item.id!);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const PackageListScreen(autoRefresh: true),
            ),
            (route) => false,
          );
          return;
        }
      }

      /// Step 2: Build order
      final orderBody = {"payment_items": cart.buildPaymentItems()};
      // Logger.log("CheckoutController - Order body: $orderBody");

      /// Step 3: Create order
      final orderResponse = await DeviceApiController.createOrder(orderBody);
      Logger.log("CheckoutController - Order response: $orderResponse");

      if (orderResponse == null || orderResponse["status"] != "success") {
        await showErrorDialog(context, "Order creation failed. Try again.");
        return;
      }

      final uniqueId = orderResponse["unique_id"];
      final totalPayable = orderResponse["total_payable_amount"];
      final totalOriginal = orderResponse["total_original_amount"];
      Logger.log("Checkout Success - Unique ID: $uniqueId");

      /// Step 4: Save order info
      await OrderStorage.saveUniqueId(uniqueId);
      await OrderStorage.saveTotalPayable(totalPayable.toString());
      await OrderStorage.saveTotalOriginal(totalOriginal.toString());

      /// Step 5: Navigate to Checkout Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CheckoutBillingScreen()),
      );
    } catch (e) {
      Logger.log("CheckoutController Error: $e");
      await showErrorDialog(context, "Something went wrong. Try again.");
    }
  }

  static Future<void> showDiscountExpiredDialog(
    BuildContext context,
    String name,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Price Updated"),
        content: Text(
          "The discount for $name has expired.\nPlease check the updated price.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  static Future<void> showErrorDialog(
    BuildContext context,
    String message,
  ) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
