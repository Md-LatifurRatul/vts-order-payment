import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/presentation/widgets/custom_action_button.dart';
import 'package:vts_price/presentation/widgets/stepper_progress.dart';

import '../../controller/cart_provider.dart';
import '../widgets/cart_faq_item.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/summary_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cart = context.read<CartProvider>();
      await cart.refreshCartPrices(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const CheckoutStepper(currentStep: 1),
      ),
      body: cart.cartItems.isEmpty
          ? const Center(child: Text('No products added yet!'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  ...cart.cartItems.map(
                    (item) => CartItemWidget(package: item),
                  ),
                  SummaryCard(),

                  const SizedBox(height: 16),

                  // Add More Button
                  CustomActionButton(
                    label: 'Add More',
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 24),

                  // FAQ Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'সাধারণ জিজ্ঞাসা',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CartFaqItem(
                    question: 'ডিভাইস ব্যবহার করতে কী কী লাগবে?',
                    answer:
                        'ডিভাইস ইনস্টল করতে আপনার গাড়ির ব্যাটারি কানেকশন, সিম কার্ড এবং ইন্টারনেট সংযোগ প্রয়োজন।',
                  ),
                  const CartFaqItem(
                    question: 'ডিভাইস ট্র্যাকার কেন ব্যবহার করবেন?',
                    answer:
                        'ডিভাইস আপনার গাড়ির নিরাপত্তা, লাইভ ট্র্যাকিং, এবং AC অন/অফ নোটিফিকেশন প্রদান করে।',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
