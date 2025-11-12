import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/controller/package_list_provider.dart';
import 'package:vts_price/presentation/package_list/widget/cart_floating_action_button.dart';
import 'package:vts_price/presentation/package_list/widget/package_details_dialog.dart';
import 'package:vts_price/presentation/package_list/widget/package_list_widget.dart';
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
                    onDetailsTap: () {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            PackageDetailsDialog(package: packages[index]),
                      );
                    },
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
}
