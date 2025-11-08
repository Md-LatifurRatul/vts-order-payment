import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/app.dart';
import 'package:vts_price/controller/billing_form_provider.dart';
import 'package:vts_price/controller/terms_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BillingFormProvider()),
        ChangeNotifierProvider(create: (_) => TermsProvider()),
      ],
      child: const CheckOutBillingApp(),
    ),
  );
}
