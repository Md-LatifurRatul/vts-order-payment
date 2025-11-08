import 'package:flutter/material.dart';
import 'package:vts_price/presentation/widgets/promo_code_input.dart';

class SummaryCard extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final double total;

  const SummaryCard({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have $itemCount item${itemCount > 1 ? 's' : ''} in cart',
              style: const TextStyle(color: Colors.orange),
            ),
            const Divider(),
            _buildRow('Subtotal', subtotal),
            const SizedBox(height: 8),
            _buildRow('Total', total, isTotal: true),
            const SizedBox(height: 16),
            const PromoCodeInput(),
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
          ),
        ),
        Text(
          '৳ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }
}
