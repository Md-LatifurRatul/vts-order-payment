import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_price/controller/terms_provider.dart';
import 'package:vts_price/model/check_out_user_model.dart';
import 'package:vts_price/presentation/widgets/custom_app_snackbar.dart';

class ConfirmOrderButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController vehicleModelController;
  final TextEditingController vtsDeliveryAddressController;
  final TextEditingController vtsInstallationAddressController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const ConfirmOrderButton({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.mobileController,
    required this.emailController,
    required this.vehicleModelController,
    required this.vtsDeliveryAddressController,
    required this.vtsInstallationAddressController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final termsProvider = context.watch<TermsProvider>();

    return ElevatedButton(
      onPressed: termsProvider.isAgreed
          ? () async {
              if (formKey.currentState!.validate()) {
                final checkoutData = CheckOutUserModel(
                  fullName: fullNameController.text,
                  mobile: mobileController.text,
                  email: emailController.text,
                  vehicleModel: vehicleModelController.text,
                  vtsDeliveryAddress: vtsDeliveryAddressController.text,
                  vtsInstallationAddress: vtsInstallationAddressController.text,
                );

                CustomAppSnackbar.show(
                  context,
                  message: 'Order Confirmed!',
                  type: SnackBarType.success,
                  duration: const Duration(seconds: 2),
                );
              }
            }
          : null, // 🔒 Disabled until terms agreed
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Confirm Order',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
