import 'package:flutter/material.dart';

class OVTCTitle extends StatelessWidget {
  const OVTCTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline),
    );
  }
}
