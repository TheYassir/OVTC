import 'package:flutter/material.dart';
import 'package:ovtc_app/utils/string_casing_extension.dart';

class OVTCTitle extends StatelessWidget {
  const OVTCTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toTitleCase(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline),
    );
  }
}
