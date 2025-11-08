import 'package:flutter/material.dart';

class BillingFormProvider extends ChangeNotifier {
  bool _sameAsDelivery = false;

  bool get sameAsDelivery => _sameAsDelivery;

  void toggleSameAsDelivery(bool value) {
    _sameAsDelivery = value;
    notifyListeners();
  }
}
