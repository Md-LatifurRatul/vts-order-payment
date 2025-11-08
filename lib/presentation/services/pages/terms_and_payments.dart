import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/terms_provider.dart';

class TermsAndPayments extends StatefulWidget {
  const TermsAndPayments({super.key});

  @override
  State<TermsAndPayments> createState() => _TermsAndPaymentsState();
}

class _TermsAndPaymentsState extends State<TermsAndPayments> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TermsProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Expandable Section
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          child: ExpansionTile(
            title: const Text(
              'বিল পরিশোধ করবেন যেভাবে:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            leading: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.orange,
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• কনফার্ম অর্ডারে ক্লিক করুন।'),
                    SizedBox(height: 4),
                    Text('• সাথে সাথে আপনার অর্ডার প্লেস হয়ে যাবে।'),
                    SizedBox(height: 4),
                    Text('• ডিভাইস বিল পরিশোধ করুন।'),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// Terms Checkbox
        Row(
          children: [
            Checkbox(
              value: provider.isAgreed,
              onChanged: (v) => provider.toggleAgreement(v!),
              activeColor: Colors.orange,
            ),
            const Expanded(
              child: Text(
                'I agree to the Terms and Conditions.',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Payment Methods
        const Text(
          'We Accept',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [_paymentIcon('Shurjopay', 'SRP')],
        ),
      ],
    );
  }

  Widget _paymentIcon(String name, String short) {
    return Tooltip(
      message: name,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[200],
        child: const Icon(Icons.payment),
      ),
    );
  }
}
