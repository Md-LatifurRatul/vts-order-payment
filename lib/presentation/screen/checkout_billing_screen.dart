import 'package:flutter/material.dart';
import 'package:vts_price/presentation/services/pages/order_summaary_page.dart';
import 'package:vts_price/presentation/widgets/billing_form_section.dart';
import 'package:vts_price/presentation/widgets/stepper_progress.dart';

class CheckoutBillingScreen extends StatefulWidget {
  const CheckoutBillingScreen({super.key});

  @override
  State<CheckoutBillingScreen> createState() => _CheckoutBillingScreenState();
}

class _CheckoutBillingScreenState extends State<CheckoutBillingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vtsDeliveryAddressController =
      TextEditingController();
  final TextEditingController _vtsInstallationAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const StepperProgress(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BillingFormSection(
                        formKey: _formKey,
                        fullNameController: _fullNameController,
                        mobileController: _mobileController,
                        emailController: _emailController,
                        vehicleModelController: _vehicleModelController,
                        vtsDeliveryAddressController:
                            _vtsDeliveryAddressController,
                        vtsInstallationAddressController:
                            _vtsInstallationAddressController,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: const OrderSummary(),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: BillingFormSection(
                          formKey: _formKey,
                          fullNameController: _fullNameController,
                          mobileController: _mobileController,
                          emailController: _emailController,
                          vehicleModelController: _vehicleModelController,
                          vtsDeliveryAddressController:
                              _vtsDeliveryAddressController,
                          vtsInstallationAddressController:
                              _vtsInstallationAddressController,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(24),
                          child: const OrderSummary(),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _vehicleModelController.dispose();
    _vtsDeliveryAddressController.dispose();
    _vtsInstallationAddressController.dispose();
    super.dispose();
  }
}
