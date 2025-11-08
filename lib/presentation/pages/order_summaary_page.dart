import 'package:flutter/material.dart';
import 'package:vts_price/presentation/widgets/summary_row.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You have 5 items in cart',
          style: TextStyle(color: Colors.orange, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('লাইট প্যাকেজ × 5', style: TextStyle(color: Colors.grey[600])),
            const Text(
              '৳ 24,995.00',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 32),
        SummaryRow(label: 'Subtotal', amount: '৳ 24,995.00'),
        const SizedBox(height: 8),
        SummaryRow(label: 'Total', amount: '৳ 24,995.00', isTotal: true),
      ],
    );
  }
}
