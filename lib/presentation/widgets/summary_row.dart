import 'package:flutter/material.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.red : Colors.black87,
            fontSize: 14,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.red : Colors.black87,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
