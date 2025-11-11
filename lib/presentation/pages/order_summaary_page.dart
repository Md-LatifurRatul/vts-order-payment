import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/presentation/widgets/summary_row.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    if (cart.cartItems.isEmpty) {
      return const Text(
        'Your cart is empty',
        style: TextStyle(color: Colors.orange, fontSize: 14),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You have ${cart.totalItemsCount} item${cart.totalItemsCount > 1 ? 's' : ''} in cart',
          style: const TextStyle(color: Colors.orange, fontSize: 14),
        ),
        const SizedBox(height: 16),

        // List all items with quantity and price
        ...cart.cartItems.map((item) {
          final qty = cart.quantity[item.id] ?? 1;
          final totalPrice = (item.payableAmount ?? 0) * qty;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.name} × $qty',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  '৳ ${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }),

        const Divider(height: 32),

        // Subtotal
        SummaryRow(
          label: 'Subtotal',
          amount: '৳ ${cart.subtotal.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),

        // Total
        SummaryRow(
          label: 'Total',
          amount: '৳ ${cart.total.toStringAsFixed(2)}',
          isTotal: true,
        ),
      ],
    );
  }
}
