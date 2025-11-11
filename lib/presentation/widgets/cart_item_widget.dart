import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/package_list/model/package_model.dart';

class CartItemWidget extends StatelessWidget {
  final DevicePackage package;
  const CartItemWidget({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final qty = cart.quantity[package.id!] ?? 1;
    final price = package.payableAmount ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ PRODUCT ICON (restored)
            CircleAvatar(
              radius: 24,
              backgroundImage:
                  (package.iconPath != null && package.iconPath!.isNotEmpty)
                  ? NetworkImage(package.iconPath!)
                  : const AssetImage("assets/images/default_icon.png")
                        as ImageProvider,
              backgroundColor: Colors.grey[200],
            ),

            const SizedBox(width: 12),

            // ✅ LEFT SIDE — NAME + PRICE (Expanded gives max space)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '৳ ${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ RIGHT-SIDE CONTROLS — tightly packed
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: () => cart.decreaseQuantity(package),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    qty.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => cart.increaseQuantity(package),
                ),

                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(40, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => cart.removeFromCart(package),
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
