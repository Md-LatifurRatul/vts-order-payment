import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vts_price/utils/network_constants.dart';

class DeviceApiController {
  static Map<String, String> get headers => {
    'x-api-key': NetworkConstants.xApiKey,
    'Content-Type': 'application/json',
  };

  ///  Fetch single device package details
  static Future<Map<String, dynamic>?> fetchDevicePackage(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${NetworkConstants.baseUrl}/api/auth/device-packages/$id"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  /// ✅ Create device order
  static Future<Map<String, dynamic>?> createOrder(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("${NetworkConstants.baseUrl}/api/auth/device-orders"),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
