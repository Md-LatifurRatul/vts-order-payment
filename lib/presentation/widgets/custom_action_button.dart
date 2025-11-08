import 'package:flutter/material.dart';

/// ---------------------------------------------------------------
/// CustomActionButton
/// ---------------------------------------------------------------
/// A reusable, responsive button widget with consistent styling.
/// Can be used for Add More, Confirm Order, Submit, etc.
///
/// Example usage:
/// CustomActionButton(
///   label: 'Add More',
///   color: Colors.orange,
///   onPressed: () {},
/// )
///
class CustomActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final double verticalPadding;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomActionButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 30,
    this.verticalPadding = 16,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            disabledBackgroundColor: Colors.grey,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
