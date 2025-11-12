import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vts_price/controller/device_api_controller.dart';
import 'package:vts_price/model/package_model.dart';

import '../utils/logger.dart';

class CartProvider extends ChangeNotifier {
  final List<DevicePackage> _cartItems = [];
  final Map<int, int> _quantity = {}; // deviceId -> quantity

  List<DevicePackage> get cartItems => _cartItems;
  Map<int, int> get quantity => _quantity;

  int get totalItemsCount => _quantity.values.fold(0, (a, b) => a + b);

  double get subtotal {
    double total = 0;
    for (var item in _cartItems) {
      final qty = _quantity[item.id!] ?? 1;
      total += (item.payableAmount ?? 0) * qty;
    }
    return total;
  }

  double get total => subtotal;

  /// Add item
  void addToCart(DevicePackage package) {
    final existingIndex = _cartItems.indexWhere((p) => p.id == package.id);

    if (existingIndex == -1) {
      _cartItems.add(package);
      _quantity[package.id!] = 1;
    } else {
      _quantity[package.id!] = (_quantity[package.id!] ?? 1) + 1;
    }

    saveCartToCache();
    notifyListeners();
  }

  /// Remove item
  void removeFromCart(DevicePackage package) {
    _cartItems.remove(package);
    _quantity.remove(package.id);
    saveCartToCache();
    notifyListeners();
  }

  /// Increase quantity
  void increaseQuantity(DevicePackage package) {
    final existingIndex = _cartItems.indexWhere((p) => p.id == package.id);
    if (existingIndex != -1) {
      _quantity[package.id!] = (_quantity[package.id!] ?? 1) + 1;
      saveCartToCache();
      notifyListeners();
    }
  }

  /// Decrease quantity
  void decreaseQuantity(DevicePackage package) {
    if (_cartItems.contains(package)) {
      if ((_quantity[package.id!] ?? 1) > 1) {
        _quantity[package.id!] = (_quantity[package.id!] ?? 1) - 1;
        saveCartToCache();
        notifyListeners();
      }
    }
  }

  /// Clear cart
  void clearCart() {
    _cartItems.clear();
    _quantity.clear();
    saveCartToCache();
    notifyListeners();
  }

  /// Remove by ID (expired discount)
  void removeById(int id) {
    _cartItems.removeWhere((i) => i.id == id);
    _quantity.remove(id);
    saveCartToCache();
    notifyListeners();
  }

  /// Build payment items for API
  List<Map<String, dynamic>> buildPaymentItems() {
    return _cartItems.map((item) {
      return {
        "device_package_id": item.id!,
        "subscription_package_id": item.subscriptionPackage?.id ?? 1,
        "quantity": _quantity[item.id] ?? 1,
      };
    }).toList();
  }

  /// Refresh cart prices from API
  Future<void> refreshCartPrices() async {
    final updatedItems = <DevicePackage>[];

    for (var item in _cartItems) {
      try {
        final response = await DeviceApiController.fetchDevicePackage(item.id!);

        if (response != null && response["status"] == "success") {
          final freshData = response["data"];
          final latestPrice =
              double.tryParse(freshData["payable_amount"].toString()) ?? 0.0;

          updatedItems.add(
            item.copyWith(
              payableAmount: latestPrice,
              discountActive: freshData["discount_active"] ?? false,
              hasActiveDiscount: freshData["has_active_discount"] ?? false,
              discountPercent: freshData["discount_percent"] ?? 0,
            ),
          );
          Logger.log("CartProvider - refreshCartPrices: $response");
        }
      } catch (e) {
        Logger.log("Error refreshing item ${item.id}: $e");
        updatedItems.add(item); // fallback to old price
      }
    }

    _cartItems
      ..clear()
      ..addAll(updatedItems);
    saveCartToCache();
    notifyListeners();
  }

  /// Save cart to SharedPreferences
  Future<void> saveCartToCache() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = _cartItems.map((e) => e.toJson()).toList();
    final qtyJson = _quantity.map((k, v) => MapEntry(k.toString(), v));
    await prefs.setString("cart_items", jsonEncode(itemsJson));
    await prefs.setString("cart_quantity", jsonEncode(qtyJson));
  }

  /// Load cart from SharedPreferences
  Future<void> loadCartFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsString = prefs.getString("cart_items");
    final qtyString = prefs.getString("cart_quantity");

    if (itemsString != null) {
      final List<dynamic> itemsJson = jsonDecode(itemsString);
      _cartItems.clear();
      _cartItems.addAll(itemsJson.map((e) => DevicePackage.fromJson(e)));
    }

    if (qtyString != null) {
      final Map<String, dynamic> qtyJson = Map<String, dynamic>.from(
        jsonDecode(qtyString),
      );
      _quantity.clear();
      qtyJson.forEach((key, value) {
        _quantity[int.parse(key)] = value;
      });
    }
    notifyListeners();
  }
}
