import 'package:flutter/material.dart';

class TermsProvider extends ChangeNotifier {
  bool _isAgreed = false;

  bool get isAgreed => _isAgreed;

  void toggleAgreement(bool value) {
    _isAgreed = value;
    notifyListeners();
  }
}
