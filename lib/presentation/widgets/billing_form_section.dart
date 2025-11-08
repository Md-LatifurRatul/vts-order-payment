import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/billing_form_provider.dart';
import 'package:vts_price/presentation/pages/terms_and_payments.dart';
import 'package:vts_price/presentation/widgets/confirm_order_button.dart';
import 'package:vts_price/presentation/widgets/cutom_text_field.dart';
import 'package:vts_price/presentation/widgets/section_title.dart';

class BillingFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController vehicleModelController;
  final TextEditingController vtsDeliveryAddressController;
  final TextEditingController vtsInstallationAddressController;

  const BillingFormSection({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.mobileController,
    required this.emailController,
    required this.vehicleModelController,
    required this.vtsDeliveryAddressController,
    required this.vtsInstallationAddressController,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BillingFormProvider>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Billing Details'),
            const SizedBox(height: 16),

            /// Full Name
            CutomTextField(
              controller: fullNameController,
              label: 'Your Full Name',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your full name' : null,
            ),

            /// Mobile
            CutomTextField(
              controller: mobileController,
              label: 'Your Mobile Number',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter mobile number';
                if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(value)) {
                  return 'Enter valid BD mobile number';
                }
                return null;
              },
            ),

            /// Email
            CutomTextField(
              controller: emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter email';
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Enter valid email';
                }
                return null;
              },
            ),

            /// Vehicle Model
            CutomTextField(
              controller: vehicleModelController,
              label: 'Vehicle Model',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter vehicle model' : null,
            ),

            /// Delivery Address
            CutomTextField(
              controller: vtsDeliveryAddressController,
              label: 'VTS Delivery Address',
              maxLines: 2,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter delivery address' : null,
              onChanged: (value) {
                if (provider.sameAsDelivery) {
                  vtsInstallationAddressController.text = value;
                }
              },
            ),

            /// Checkbox - Same as delivery
            Row(
              children: [
                Checkbox(
                  value: provider.sameAsDelivery,
                  activeColor: Colors.orange,
                  onChanged: (value) {
                    provider.toggleSameAsDelivery(value!);
                    if (value) {
                      vtsInstallationAddressController.text =
                          vtsDeliveryAddressController.text;
                    }
                  },
                ),
                const Text('Same as Delivery Address'),
              ],
            ),

            /// Installation Address
            CutomTextField(
              controller: vtsInstallationAddressController,
              label: 'VTS Installation Address',
              maxLines: 2,
              enabled: !provider.sameAsDelivery,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter installation address' : null,
            ),

            const SizedBox(height: 32),
            const TermsAndPayments(),
            const SizedBox(height: 24),

            Center(
              child: ConfirmOrderButton(
                formKey: formKey,
                fullNameController: fullNameController,
                mobileController: mobileController,
                emailController: emailController,
                vehicleModelController: vehicleModelController,
                vtsDeliveryAddressController: vtsDeliveryAddressController,
                vtsInstallationAddressController:
                    vtsInstallationAddressController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
