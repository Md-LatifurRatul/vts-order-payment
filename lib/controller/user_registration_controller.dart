import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vts_price/controller/device_api_controller.dart';
import 'package:vts_price/services/storage/order_storage.dart';
import 'package:vts_price/utils/logger.dart';
import 'package:vts_price/utils/network_constants.dart';

class UserRegistrationController {
  static Future<bool> createUser({
    required BuildContext context,
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String vtsDeliveryAddress,
    required String vtsInstallationAddress, // Will store for later
  }) async {
    try {
      // Validate password match before calling API
      if (password != confirmPassword) {
        Logger.log("Password mismatch");
        _showDialog(
          context,
          "Password Mismatch",
          "Password and confirm password do not match.",
        );
        return false;
      }

      final Map<String, dynamic> requestBody = {
        "name": fullName,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": confirmPassword,
        "user_address": vtsDeliveryAddress,
      };

      Logger.log("UserRegistrationController → REQUEST BODY: $requestBody");

      final response = await http.post(
        Uri.parse("${NetworkConstants.baseUrl}/api/auth/user/register"),
        headers: DeviceApiController.headers,
        body: jsonEncode(requestBody),
      );

      Logger.log(
        "UserRegistrationController → RESPONSE [${response.statusCode}]: ${response.body}",
      );
      // --- SAFE DECODE ---
      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (e) {
        decoded = {};
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded["status"] == "success") {
          final userId = decoded["user"]["id"].toString();
          Logger.log("UserRegistrationController → USER CREATED: ID=$userId");

          // Save the userId for later order creation
          await OrderStorage.saveUserId(userId);

          // Save both addresses for later use
          await OrderStorage.saveDeliveryAddress(vtsDeliveryAddress);
          await OrderStorage.saveInstallationAddress(vtsInstallationAddress);
          Logger.log("USER CREATED SUCCESSFULLY → $userId");
          return true;
        } else {
          _showDialog(
            context,
            "Registration Failed",
            decoded["message"] ?? "Unknown error",
          );
          return false;
        }
      } else {
        _showDialog(
          context,
          "Server Error",
          "Code: ${response.statusCode}\n${decoded["message"] ?? ""}",
        );
        return false;
      }
    } catch (e) {
      Logger.log("UserRegistrationController → ERROR: $e");
      _showDialog(
        context,
        "Unexpected Error",
        "Something went wrong. Please try again.",
      );
      return false;
    }
  }

  static void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
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
