import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/package_list/model/package_model.dart';
import 'package:vts_price/package_list/provider/package_list_provider.dart';
import 'package:vts_price/package_list/widget/cart_floating_action_button.dart';
import 'package:vts_price/package_list/widget/package_list_widget.dart';
import 'package:vts_price/presentation/screen/cart_screen.dart';
import 'package:vts_price/presentation/widgets/custom_app_snackbar.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key, this.autoRefresh = false});
  final bool autoRefresh;

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PackageProvider>();
      if (provider.packageResponse == null && !provider.isLoading) {
        provider.fetchPackages();
      }
    });

    final provider = context.watch<PackageProvider>();
    final packages = provider.packageResponse?.data ?? [];

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Subscriptions'),
        backgroundColor: Colors.blueAccent,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive aspect ratio based on available height/width
            final isSmallScreen = constraints.maxWidth < 320;

            return GridView.builder(
              itemCount: packages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmallScreen ? 1 : 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: isSmallScreen
                    ? 0.85
                    : 0.5, //  taller cards for mobile
              ),
              itemBuilder: (context, index) {
                final currentPackage = packages[index];
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: PackageCard(
                    onDetailsTap: () =>
                        _showPackageDialog(context, packages[index]),
                    onBuyTap: () {
                      final cartProvider = context.read<CartProvider>();

                      cartProvider.addToCart(packages[index]);

                      CustomAppSnackbar.show(
                        context,
                        message: "${currentPackage.name} added to cart",
                        type: SnackBarType.success,
                      );
                      Future.microtask(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      });
                    },
                    package: currentPackage,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: CartFloatingActionButton(),
    );
  }

  void _showPackageDialog(BuildContext context, DevicePackage package) {
    final features = package.features ?? [];
    final subscription = package.subscriptionPackage;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🔶 Header Section
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      if (package.iconPath != null &&
                          package.iconPath!.isNotEmpty)
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
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
                      //       "প্যাকেজের পাথ্য চাইন",
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
      },
    );
  }
}

class FeatureText extends StatelessWidget {
  final String text;
  const FeatureText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green, size: 16),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
