import 'package:flutter/material.dart';

class PromoCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onApply;

  const PromoCodeInput({
    super.key,
    required this.controller,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter Promo Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Apply', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
