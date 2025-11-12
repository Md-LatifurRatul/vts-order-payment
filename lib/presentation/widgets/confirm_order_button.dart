import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/device_order_address_controller.dart';
import 'package:vts_price/controller/terms_provider.dart';
import 'package:vts_price/controller/user_registration_controller.dart';
import 'package:vts_price/presentation/screen/payment_screen.dart';
import 'package:vts_price/presentation/widgets/custom_app_snackbar.dart';
import 'package:vts_price/presentation/widgets/order_confirm_dialog.dart';

import '../../utils/logger.dart';

class ConfirmOrderButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController vehicleModelController;
  final TextEditingController vtsDeliveryAddressController;
  final TextEditingController vtsInstallationAddressController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const ConfirmOrderButton({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.mobileController,
    required this.emailController,
    required this.vehicleModelController,
    required this.vtsDeliveryAddressController,
    required this.vtsInstallationAddressController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final termsProvider = context.watch<TermsProvider>();

    return ElevatedButton(
      onPressed: termsProvider.isAgreed
          ? () async {
              if (formKey.currentState!.validate()) {
                final confirm = await showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => OrderConfirmDialog(),
                );

                if (confirm == false) return;

                final addressUpdated =
                    await DeviceOrderAddressController.updateOrderAddresses(
                      context: context,
                      vtsDeliveryAddress: vtsDeliveryAddressController.text
                          .trim(),
                      vtsInstallationAddress:
                          vtsInstallationAddressController.text,
                    );

                if (!addressUpdated) return; // Stop if failed

                // User pressed YES → continue registration
                final success = await UserRegistrationController.createUser(
                  context: context,
                  fullName: fullNameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: mobileController.text.trim(),
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  vtsDeliveryAddress: vtsDeliveryAddressController.text,
                  vtsInstallationAddress: vtsInstallationAddressController.text,
                );

                if (success) {
                  Logger.log("User creation completed → moving to next step");

                  CustomAppSnackbar.show(
                    context,
                    message: 'Order Confirmed!',
                    type: SnackBarType.success,
                    duration: const Duration(seconds: 2),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                }
              }
            }
          : null, // 🔒 Disabled until terms agreed
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Confirm Order',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
