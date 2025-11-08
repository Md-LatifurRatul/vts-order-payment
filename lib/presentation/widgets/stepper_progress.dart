import 'package:flutter/material.dart';

/// ---------------------------------------------------------------
/// CheckoutStepper
/// ---------------------------------------------------------------
/// A reusable stepper that visually shows checkout progress.
/// - step = 1 → highlights "Cart"
/// - step = 2 → highlights "Checkout"
///
/// Example:
/// ```dart
/// CheckoutStepper(currentStep: 1) // On Cart screen
/// CheckoutStepper(currentStep: 2) // On Checkout screen
/// ```
class CheckoutStepper extends StatelessWidget {
  final int currentStep; // 1 = Cart, 2 = Checkout

  const CheckoutStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final isCartActive = currentStep >= 1;
    final isCheckoutActive = currentStep >= 2;

    return Row(
      children: [
        // Step 1: Your Cart
        _buildStep('1', 'Your Cart', isCartActive),

        // Line between steps
        Expanded(
          child: Container(
            height: 3,
            color: isCheckoutActive ? Colors.orange : Colors.grey[300],
          ),
        ),

        // Step 2: Checkout
        _buildStep('2', 'Checkout', isCheckoutActive),
      ],
    );
  }

  Widget _buildStep(String number, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? Colors.orange : Colors.grey[300],
          child: Text(
            number,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.orange : Colors.grey,
          ),
        ),
      ],
    );
  }
}
