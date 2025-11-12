import 'package:flutter/material.dart';

class OrderConfirmDialog extends StatelessWidget {
  const OrderConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Order"),
      content: const Text("Are you sure you want to confirm the order?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No", style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Yes", style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
