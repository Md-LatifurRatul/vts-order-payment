import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/presentation/screen/cart_screen.dart';
import 'package:vts_price/utils/logger.dart';

class CartFloatingActionButton extends StatelessWidget {
  const CartFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () async {
            Logger.log("Refreshing cart prices...");
            await cart.refreshCartPrices(context); // ✅ Auto refresh prices
            Logger.log("Cart refreshed, navigating to CartScreen");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart),
              if (cart.totalItemsCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.totalItemsCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          label: const Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
