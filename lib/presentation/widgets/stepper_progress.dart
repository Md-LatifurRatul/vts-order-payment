import 'package:flutter/material.dart';

class StepperProgress extends StatelessWidget {
  const StepperProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep('1', 'Your Cart', isActive: true),
        Expanded(child: Container(height: 2, color: Colors.red)),
        _buildStep('2', 'Checkout', isActive: true),
      ],
    );
  }

  Widget _buildStep(String number, String label, {required bool isActive}) {
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
