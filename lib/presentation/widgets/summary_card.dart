import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/controller/check_out_controller.dart';
import 'package:vts_price/presentation/widgets/custom_action_button.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    // final promoController = TextEditingController();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have ${cart.totalItemsCount} item${cart.totalItemsCount > 1 ? 's' : ''} in cart',
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            _buildRow('Subtotal', cart.subtotal),
            // if (cart.discountPercent > 0)
            //   _buildRow(
            //     'Discount (${cart.discountPercent.toStringAsFixed(0)}%)',
            //     -cart.subtotal * cart.discountPercent / 100,
            //   ),
            const SizedBox(height: 8),
            _buildRow('Total', cart.total, isTotal: true),
            // const SizedBox(height: 16),

            // Promo Code Input
            // PromoCodeInput(
            //   controller: promoController,
            //   onApply: () {
            //     // future promo code logic
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(
            //           'Promo code applied: ${promoController.text}',
            //         ),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 24),

            CustomActionButton(
              label: 'Checkout',
              color: Colors.green,
              onPressed: cart.cartItems.isNotEmpty
                  ? () {
                      CheckoutController.handleCheckout(context);
                    }
                  : null, // disables button if cart is empty
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        Text(
          '৳ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isTotal ? Colors.red : Colors.black87,
          ),
        ),
      ],
    );
  }
}
