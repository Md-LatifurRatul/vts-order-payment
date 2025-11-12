import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/model/package_model.dart';
import 'package:vts_price/presentation/screen/cart_screen.dart';
import 'package:vts_price/presentation/widgets/custom_app_snackbar.dart';

class PackageDetailsDialog extends StatelessWidget {
  final DevicePackage package;

  const PackageDetailsDialog({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final features = package.features ?? [];
    final subscription = package.subscriptionPackage;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔶 Header Section
            Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                children: [
                  if (package.iconPath != null && package.iconPath!.isNotEmpty)
                    Image.network(package.iconPath!, width: 60, height: 60),
                  const SizedBox(height: 8),
                  Text(
                    package.name ?? '',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "ডিভাইসঃ ${package.formattedPrice}\nমাসিক চার্জঃ ${subscription?.formattedPrice ?? ''}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // 🟨 Feature List
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "ফিচারলিস্ট",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Features
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: features
                        .map(
                          (f) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 6),
                                Expanded(child: Text(f)),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "বিস্তারিত জানতে যোগাযোগ করুন",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "+8801700786848",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 🔘 Bottom Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        final cartProvider = context.read<CartProvider>();
                        cartProvider.addToCart(package);
                        Navigator.pop(context);

                        CustomAppSnackbar.show(
                          context,
                          message: "${package.name} added to cart",
                          type: SnackBarType.success,
                        );

                        Future.microtask(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "এখনই কিনুন",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.redAccent,
                  //       padding: const EdgeInsets.symmetric(vertical: 12),
                  //     ),
                  //     onPressed: () => Navigator.pop(context),
                  //     child: const Text(
                  //       "প্যাকেজের তথ্য চাইন",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
