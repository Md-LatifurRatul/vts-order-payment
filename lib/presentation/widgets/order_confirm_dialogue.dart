import 'package:flutter/material.dart';

class OrderConfirmDialogue extends StatelessWidget {
  const OrderConfirmDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Order"),
      content: const Text("Are you sure you want to confirm the order?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
