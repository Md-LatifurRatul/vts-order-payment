import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vts_price/controller/device_api_controller.dart';
import 'package:vts_price/services/storage/order_storage.dart';
import 'package:vts_price/utils/logger.dart';
import 'package:vts_price/utils/network_constants.dart';

class DeviceOrderAddressUpdateController {
  static Future<bool> updateAddresses(BuildContext context) async {
    try {
      final uniqueId = await OrderStorage.getUniqueId();
      final deliveryAddress = await OrderStorage.getDeliveryAddress();
      final installationAddress = await OrderStorage.getInstallationAddress();

      if (uniqueId == null ||
          deliveryAddress == null ||
          installationAddress == null) {
        _showDialog(
          context,
          "Missing Data",
          "Order ID or addresses not found in stored memory.",
        );
        return false;
      }

      final requestBody = {
        "unique_id": uniqueId,
        "vts_delivery_address": deliveryAddress,
        "vts_installation_address": installationAddress,
      };

      Logger.log("DeviceOrderAddressUpdate → REQUEST BODY: $requestBody");

      final response = await http.put(
        Uri.parse(
          "${NetworkConstants.baseUrl}/api/auth/device-orders/addresses",
        ),
        headers: DeviceApiController.headers,
        body: jsonEncode(requestBody),
      );

      Logger.log(
        "DeviceOrderAddressUpdate → RESPONSE [${response.statusCode}]: ${response.body}",
      );

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (e) {
        decoded = {};
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded["status"] == "success") {
          Logger.log("DeviceOrderAddressUpdate → UPDATED SUCCESSFULLY");
          return true;
        } else {
          _showDialog(
            context,
            "Update Failed",
            decoded["message"] ?? "Unknown error",
          );
          return false;
        }
      } else {
        if (decoded["errors"] != null &&
            decoded["errors"]["unique_id"] != null) {
          _showDialog(
            context,
            "Invalid Unique ID",
            decoded["errors"]["unique_id"].first,
          );
        } else {
          _showDialog(
            context,
            "Server Error",
            "Code: ${response.statusCode}\n${decoded["message"] ?? ""}",
          );
        }
        return false;
      }
    } catch (e) {
      Logger.log("DeviceOrderAddressUpdate → ERROR: $e");
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
