import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vts_price/controller/device_api_controller.dart';
import 'package:vts_price/presentation/widgets/custom_controller_alert_dialog.dart';
import 'package:vts_price/utils/logger.dart';
import 'package:vts_price/utils/network_constants.dart';

class PaymentVerifyController {
  static Future<bool> verifyPayment(
    BuildContext context,
    String orderId,
  ) async {
    try {
      // ✅ Get the saved order_id

      final body = {"order_id": orderId};

      Logger.log("PaymentVerifyController → REQUEST BODY: $body");

      final response = await http.post(
        Uri.parse(
          "${NetworkConstants.baseUrl}/api/auth/device-package-payments/verify",
        ),
        headers: DeviceApiController.headers,
        body: jsonEncode(body),
      );

      Logger.log(
        "PaymentVerifyController → RESPONSE [${response.statusCode}]: ${response.body}",
      );

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (e) {
        decoded = {};
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded["status"] == "success") {
          Logger.log("Payment verified successfully for Order ID: $orderId");
          return true;
        } else {
          CustomControllerAlertDialog.show(
            context,
            title: "Payment Verification Failed",
            message: "Payment Verification unsuccessful",
          );

          return false;
        }
      } else {
        CustomControllerAlertDialog.show(
          context,
          title: "Server Error",
          message: "Internal Server Error",
        );

        return false;
      }
    } catch (e) {
      Logger.log("PaymentVerifyController → ERROR: $e");

      CustomControllerAlertDialog.show(
        context,
        title: "Unexpected Error",
        message: "Something went wrong during payment verification.",
      );

      return false;
    }
  }
}
