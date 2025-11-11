import 'package:flutter/material.dart';
import 'package:vts_price/package_list/model/package_model.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.package,
    required this.onDetailsTap,
    required this.onBuyTap,
  });

  final DevicePackage package;
  final VoidCallback? onDetailsTap;
  final VoidCallback? onBuyTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    String discount = "10.00";

    if (package.discountPercent.toString().endsWith(".00")) {
      discount = discount.replaceAll(".00", "");
    }
    double scale = width < 400
        ? 0.68
        : width < 600
        ? 0.8
        : 1.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 3,
        color: Colors.white,
        shadowColor: Colors.blueAccent.withOpacity(0.25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔷 Header Section
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 22 * scale),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1F81D1), Color(0xFF85C4FC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        package.discountActive!
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10 * scale,
                                  vertical: 5 * scale,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "$discount% Discount",
                                    style: TextStyle(
                                      fontSize: 18 * scale,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10 * scale,
                                  vertical: 5 * scale,
                                ),
                                decoration: BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 18 * scale,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: 5 * scale),
                        Icon(
                          Icons.verified_user,
                          size: 40 * scale,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10 * scale),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              package.iconPath ?? "",
                              height: 40 * scale,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 5 * scale),
                            Text(
                              package.name ?? "Empty",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5 * scale),

              // 🌟 Feature Count
              Container(
                margin: EdgeInsets.only(top: 5 * scale, bottom: scale * 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 18 * scale,
                  vertical: 6 * scale,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB300), Color(0xFFFFEE58)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '${package.features!.length.toString()}+ ফিচার',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              SizedBox(height: 10 * scale),

              // 💰 Price Info
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18 * scale),
                child: Column(
                  children: [
                    _priceRow(
                      Icons.devices_other,
                      'ডিভাইস',
                      package.regularPrice.toString(),
                      (package.discountActive ?? false)
                          ? package.formattedPayableAmount
                          : null, // no discount for devices
                      scale,
                    ),
                    SizedBox(height: 8 * scale),
                    _priceRow(
                      Icons.payments_rounded,
                      'মাসিক চার্জ',
                      package.subscriptionPackage!.price.toString(),
                      null, // discounted price
                      scale,
                    ),
                  ],
                ),
              ),

              const Divider(height: 10, color: Colors.black12),

              // 🔘 Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18 * scale),
                child: Column(
                  children: [
                    _buildButton(
                      onDetailsTap,
                      Icons.info_outline,
                      "বিস্তারিত দেখুন",
                      Colors.orangeAccent,
                      Colors.white,
                      scale,
                      outlined: true,
                    ),
                    SizedBox(height: 10 * scale),
                    _buildButton(
                      onBuyTap,
                      Icons.shopping_cart_outlined,
                      "এখনই কিনুন",
                      Colors.white,
                      Colors.orangeAccent,
                      scale,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 253, 40, 40),
                          Color.fromARGB(255, 255, 232, 132),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20 * scale),
            ],
          ),
        ),
      ),
    );
  }

  // 💰 Price Row
  Widget _priceRow(
    IconData icon,
    String label,
    String regularPrice,
    String? discountPrice, // nullable
    double scale,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22 * scale, color: Colors.blueAccent),
        SizedBox(width: 6 * scale),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16 * scale, fontWeight: FontWeight.w500),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (discountPrice != null)
              Text(
                "৳$regularPrice",
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough, // strike-through
                ),
              ),
            Text(
              discountPrice ?? "৳$regularPrice",
              style: TextStyle(
                fontSize: 15 * scale,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (discountPrice == null)
              Text(
                "",
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey,
                  // strike-through
                ),
              ),
          ],
        ),
      ],
    );
  }

  // 🟢 Reusable Button
  Widget _buildButton(
    VoidCallback? onTap,
    IconData icon,
    String text,
    Color textColor,
    Color borderColor,
    double scale, {
    bool outlined = false,
    Gradient? gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42 * scale,
        decoration: BoxDecoration(
          color: outlined ? Colors.white : null,
          gradient: outlined ? null : gradient,
          border: outlined ? Border.all(color: borderColor, width: 1.2) : null,
          borderRadius: BorderRadius.circular(30),
          boxShadow: outlined
              ? []
              : [
                  BoxShadow(
                    color: borderColor.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 18 * scale),
            SizedBox(width: 6 * scale),
            Text(
              text,
              style: TextStyle(
                fontSize: 16 * scale,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
