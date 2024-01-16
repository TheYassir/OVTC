import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color? backgroundColor = Colors.teal,
    Color? color = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Center(
          child: Text(
        message,
        style: TextStyle(fontSize: 18, color: color),
      )),
      backgroundColor: backgroundColor,
      showCloseIcon: true,
    ));
  }

  /// Displays a red snackbar indicating error
  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red[900]);
  }

  void showValidSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.green[900]);
  }
}
