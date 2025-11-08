import 'package:flutter/material.dart';
import 'package:vts_price/presentation/screen/cart_screen.dart';

class CheckOutBillingApp extends StatelessWidget {
  const CheckOutBillingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CheckoutBillingScreen(),
      home: CartScreen(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
      ),
    );
  }
}
