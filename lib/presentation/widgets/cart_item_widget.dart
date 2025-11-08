import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/model/cart_item_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product ID
            Container(
              width: 24,
              alignment: Alignment.center,
              child: Text(
                item.id,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),

            // Logo
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(item.logoUrl),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 12),

            // Title & Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item.subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    '৳ ${(item.price * item.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: () => cart.decreaseQuantity(item.id),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => cart.increaseQuantity(item.id),
                ),
              ],
            ),

            // Remove Button
            TextButton(
              onPressed: () => cart.removeItem(item.id),
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
