import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/app.dart';
import 'package:vts_price/controller/billing_form_provider.dart';
import 'package:vts_price/controller/cart_provider.dart';
import 'package:vts_price/controller/order_provider.dart';
import 'package:vts_price/controller/terms_provider.dart';
import 'package:vts_price/package_list/provider/package_list_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BillingFormProvider()),
        ChangeNotifierProvider(create: (_) => TermsProvider()),
        ChangeNotifierProvider(create: (_) => PackageProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const CheckOutBillingApp(),
    ),
  );
}
