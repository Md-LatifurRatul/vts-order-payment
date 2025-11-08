import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> _items = [];
  double _subtotal = 0.0;
  double _total = 0.0;
  double _discountPercent = 0.0;

  List<CartItemModel> get items => _items;
  double get subtotal => _subtotal;
  double get total => _total;
  double get discountPercent => _discountPercent;

  CartProvider() {
    _loadCart();
    if (_items.isEmpty) _addTestProducts(); // Add static data for testing
  }

  int get totalItemsCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void _addTestProducts() {
    addItem(
      CartItemModel(
        id: '01',
        title: 'প্রিমিয়াম প্যাকেজ',
        subtitle: 'লাইট প্যাকেজ × 1',
        price: 9999,
        logoUrl:
            'https://scontent.fdac166-1.fna.fbcdn.net/v/t39.30808-6/220201900_4030753443690194_7815241126078314660_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Et3Vx7BA9RQQ7kNvwHEVibe&_nc_oc=AdkZwCNzwwLNAQVQd2Y2w31UrKAWxmLbKD8OdErh7v1NeiX_TQn3AoqVIFc4_-NFccQ&_nc_zt=23&_nc_ht=scontent.fdac166-1.fna&_nc_gid=myk_vSV1IIWygJDRLBBLUw&oh=00_AfgZAvlFRNaXI9PXkdm50GgqzntuBB9KCt0dQeb3vf88dA&oe=6914DE1F',
      ),
    );
    addItem(
      CartItemModel(
        id: '02',
        title: 'স্ট্যান্ডার্ড প্যাকেজ',
        subtitle: 'লাইট প্যাকেজ × 1',
        price: 4999,
        logoUrl:
            'https://scontent.fdac166-1.fna.fbcdn.net/v/t39.30808-6/220201900_4030753443690194_7815241126078314660_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Et3Vx7BA9RQQ7kNvwHEVibe&_nc_oc=AdkZwCNzwwLNAQVQd2Y2w31UrKAWxmLbKD8OdErh7v1NeiX_TQn3AoqVIFc4_-NFccQ&_nc_zt=23&_nc_ht=scontent.fdac166-1.fna&_nc_gid=myk_vSV1IIWygJDRLBBLUw&oh=00_AfgZAvlFRNaXI9PXkdm50GgqzntuBB9KCt0dQeb3vf88dA&oe=6914DE1F',
      ),
    );
  }

  void _calculateTotals() {
    _subtotal = _items.fold(0, (sum, item) => sum + item.price * item.quantity);
    _total = _subtotal - (_subtotal * _discountPercent / 100);
    notifyListeners();
    _saveCart();
  }

  void addItem(CartItemModel item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    _calculateTotals();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _calculateTotals();
  }

  void increaseQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity += 1;
      _calculateTotals();
    }
  }

  void decreaseQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity -= 1;
      if (_items[index].quantity <= 0) _items.removeAt(index);
      _calculateTotals();
    }
  }

  void applyDiscount(double percent) {
    _discountPercent = percent;
    _calculateTotals();
  }

  void clearCart() {
    _items.clear();
    _discountPercent = 0;
    _calculateTotals();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(_items.map((e) => e.toMap()).toList());
    await prefs.setString('cart_cache', jsonString);
    await prefs.setDouble('cart_discount', _discountPercent);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cart_cache');
    if (jsonString != null) {
      final List decoded = json.decode(jsonString);
      _items = decoded.map((e) => CartItemModel.fromMap(e)).toList();
      _discountPercent = prefs.getDouble('cart_discount') ?? 0.0;
      _calculateTotals();
    }
  }
}
