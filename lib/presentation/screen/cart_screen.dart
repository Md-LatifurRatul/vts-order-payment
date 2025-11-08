// lib/presentation/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:vts_price/presentation/widgets/cart_faq_item.dart';

import '../widgets/cart_item.dart';
import '../widgets/summary_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildStepper(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cart Header
            Container(
              width: double.infinity,
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'My Cart (6 Items)     Total: ৳ 34,994.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Cart Items
            CartItem(
              id: '01',
              title: 'প্রিমিয়াম প্যাকেজ',
              subtitle: 'লাইট প্যাকেজ × 1',
              price: 9999.00,
              quantity: quantity,
              onRemove: () {},
              onQuantityChanged: (newQty) => setState(() => quantity = newQty),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text(
                        'Add More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Summary Card
            SummaryCard(itemCount: 1, subtotal: 9999.00, total: 9999.00),

            const SizedBox(height: 24),

            // FAQ Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'সাধারণ জিজ্ঞাসা',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            CartFaqItem(
              question: 'প্রহরী ব্যবহার করতে কী কী লাগবে?',
              answer:
                  'প্রহরী ডিভাইস ইনস্টল করতে আপনার গাড়ির ব্যাটারি কানেকশন, সিম কার্ড এবং ইন্টারনেট সংযোগ প্রয়োজন।',
            ),
            CartFaqItem(
              question: 'প্রহরী ট্র্যাকার কেন ব্যবহার করবেন?',
              answer:
                  'প্রহরী ডিভাইস আপনার গাড়ির নিরাপত্তা, লাইভ ট্র্যাকিং, এবং AC অন/অফ নোটিফিকেশন প্রদান করে।',
            ),

            // Add more FAQs...
            const SizedBox(height: 24),

            // Contact Footer
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Do you have Questions about your Order?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        '+8801708 166 166',
                        style: TextStyle(color: Colors.orange[700]),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.email, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'info@prohori.com',
                        style: TextStyle(color: Colors.orange[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _step('1', 'Your Cart', true),
        Expanded(child: Container(height: 2, color: Colors.orange)),
        _step('2', 'Checkout', false),
      ],
    );
  }

  Widget _step(String num, String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? Colors.orange : Colors.grey[300],
          child: Text(
            num,
            style: TextStyle(color: active ? Colors.white : Colors.black),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? Colors.orange : Colors.grey,
          ),
        ),
      ],
    );
  }
}
