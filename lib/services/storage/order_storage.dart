import 'package:shared_preferences/shared_preferences.dart';

class OrderStorage {
  static Future<void> saveUniqueId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("unique_id", id);
  }

  static Future<void> saveTotalPayable(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("total_payable_amount", amount);
  }

  static Future<void> saveTotalOriginal(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("total_original_amount", amount);
  }

  static Future<String?> getUniqueId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("unique_id");
  }

  static Future<String?> getTotalPayable() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("total_payable_amount");
  }

  static Future<String?> getTotalOriginal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("total_original_amount");
  }
}
