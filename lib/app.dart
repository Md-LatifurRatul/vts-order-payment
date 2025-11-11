import 'package:flutter/material.dart';
import 'package:vts_price/package_list/ui/package_list.dart';

class CheckOutBillingApp extends StatelessWidget {
  const CheckOutBillingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CheckoutBillingScreen(),
      // home: CartScreen(),
      home: PackageListScreen(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
      ),
    );
  }
}
