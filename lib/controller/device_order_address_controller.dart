import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vts_price/controller/device_api_controller.dart';
import 'package:vts_price/presentation/widgets/custom_controller_alert_dialog.dart';
import 'package:vts_price/services/storage/order_storage.dart';
import 'package:vts_price/utils/logger.dart';
import 'package:vts_price/utils/network_constants.dart';

class DeviceOrderAddressController {
  static Future<bool> updateOrderAddresses({
    required BuildContext context,
    required String vtsDeliveryAddress,
    required String vtsInstallationAddress,
  }) async {
    try {
      // Get unique_id from local storage
      final uniqueId = await OrderStorage.getUniqueId();

      if (uniqueId == null || uniqueId.isEmpty) {
        Logger.log(" No unique_id found in storage");
        CustomControllerAlertDialog.show(
          context,
          title: "Missing Order ID",
          message: "No order found. Please create an order first.",
        );
        return false;
      }

      final Map<String, dynamic> requestBody = {
        "unique_id": uniqueId,
        "vts_delivery_address": vtsDeliveryAddress,
        "vts_installation_address": vtsInstallationAddress,
      };

      Logger.log("📦 PUT /device-orders/addresses BODY → $requestBody");

      final response = await http.put(
        Uri.parse(
          "${NetworkConstants.baseUrl}/api/auth/device-orders/addresses",
        ),
        headers: DeviceApiController.headers,
        body: jsonEncode(requestBody),
      );

      Logger.log(
        "DeviceOrderAddressController → RESPONSE [${response.statusCode}]: ${response.body}",
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded["status"] == "success") {
          Logger.log("✅ Device order addresses updated successfully");
          return true;
        } else {
          CustomControllerAlertDialog.show(
            context,
            title: "Address Update Failed",
            message: decoded["message"] ?? "Unknown error occurred.",
          );
          return false;
        }
      } else {
        // Handle validation or not found
        if (decoded["errors"] != null &&
            decoded["errors"]["unique_id"] != null) {
          CustomControllerAlertDialog.show(
            context,
            title: "Order Not Found",
            message: decoded["errors"]["unique_id"].join(", "),
          );
        } else {
          CustomControllerAlertDialog.show(
            context,
            title: "Server Error",
            message:
                "Error ${response.statusCode}: ${decoded["message"] ?? "Unexpected error"}",
          );
        }
        return false;
      }
    } catch (e) {
      Logger.log("DeviceOrderAddressController → ERROR: $e");
      CustomControllerAlertDialog.show(
        context,
        title: "Unexpected Error",
        message: "Something went wrong while updating the address.",
      );
      return false;
    }
  }
}
