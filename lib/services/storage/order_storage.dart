import 'package:shared_preferences/shared_preferences.dart';

class OrderStorage {
  // ✅ Save User ID (from registration API)
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", userId);
  }

  // ✅ Get User ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_id");
  }

  // ✅ Save Delivery Address
  static Future<void> saveDeliveryAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("delivery_address", address);
  }

  // ✅ Get Delivery Address
  static Future<String?> getDeliveryAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("delivery_address");
  }

  // ✅ Save Installation Address
  static Future<void> saveInstallationAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("installation_address", address);
  }

  // ✅ Get Installation Address
  static Future<String?> getInstallationAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("installation_address");
  }

  // ✅ Save Unique Order ID (after order creation)
  static Future<void> saveUniqueId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("unique_id", id);
  }

  // ✅ Get Unique Order ID
  static Future<String?> getUniqueId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("unique_id");
  }

  // ✅ Save Total Payable
  static Future<void> saveTotalPayable(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("total_payable_amount", amount);
  }

  // ✅ Get Total Payable
  static Future<String?> getTotalPayable() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("total_payable_amount");
  }

  // ✅ Save Total Original Price
  static Future<void> saveTotalOriginal(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("total_original_amount", amount);
  }

  // ✅ Get Total Original Price
  static Future<String?> getTotalOriginal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("total_original_amount");
  }

  // ✅ Clear All Order Storage (optional)
  static Future<void> clearAllOrderData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_id");
    await prefs.remove("delivery_address");
    await prefs.remove("installation_address");
    await prefs.remove("unique_id");
    await prefs.remove("total_payable_amount");
    await prefs.remove("total_original_amount");
  }
}
