import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  String? uniqueId;
  String? totalPayable;
  String? totalOriginal;

  void setOrderData({
    required String savedUniqueId,
    required String savedTotalPayable,
    required String savedTotalOriginal,
  }) {
    uniqueId = savedUniqueId;
    totalPayable = savedTotalPayable;
    totalOriginal = savedTotalOriginal;
    notifyListeners();
  }

  void clearOrderData() {
    uniqueId = null;
    totalPayable = null;
    totalOriginal = null;
    notifyListeners();
  }
}
