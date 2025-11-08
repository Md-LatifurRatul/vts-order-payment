import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:vts_price/model/check_out_user_model.dart';

class CheckOutUserStorage {
  static const String _key = 'checkout_data';

  // Save checkout data
  static Future<void> save(CheckOutUserModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(model.toMap());
    await prefs.setString(_key, jsonString);
  }

  // Load saved data
  static Future<CheckOutUserModel?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return null;
    return CheckOutUserModel.fromMap(json.decode(jsonString));
  }

  // Clear data
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
