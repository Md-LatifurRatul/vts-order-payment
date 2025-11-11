import 'package:flutter/material.dart';

/// ---------------------------------------------------------------
/// Custom SnackBar
/// ---------------------------------------------------------------

enum SnackBarType { success, error, warning, info }

class CustomAppSnackbar {
  const CustomAppSnackbar._();

  /// message –> Text to show
  ///  type    –> Pre-defined style (success, error, warning, info)
  /// duration –> How long it stays (default 3 sec)
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _colorFor(type),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(12),
      ),
    );
  }

  /// Map type → color
  static Color _colorFor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }
}
