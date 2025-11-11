import 'package:flutter/material.dart';

class BillingFormProvider extends ChangeNotifier {
  bool _sameAsDelivery = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _passwordsMatch = true;

  bool get sameAsDelivery => _sameAsDelivery;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get passwordsMatch => _passwordsMatch;

  void toggleSameAsDelivery(bool value) {
    _sameAsDelivery = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void checkPasswordsMatch(String password, String confirmPassword) {
    _passwordsMatch = password == confirmPassword;
    notifyListeners();
  }

  // Optional: Password validation for confirm password
  String? validateConfirmPassword(String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm password';
    }
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}
