import 'package:flutter/material.dart';

class CartFaqItem extends StatefulWidget {
  final String question;
  final String answer;
  final bool initiallyExpanded;

  const CartFaqItem({
    super.key,
    required this.question,
    required this.answer,
    this.initiallyExpanded = false,
  });

  @override
  State<CartFaqItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<CartFaqItem> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        leading: Icon(_expanded ? Icons.remove : Icons.add, color: Colors.blue),
        title: Text(
          widget.question,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.answer,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
        onExpansionChanged: (value) => setState(() => _expanded = value),
      ),
    );
  }
}
