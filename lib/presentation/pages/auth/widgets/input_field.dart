import 'package:flutter/material.dart';

import '../../../../theme/theme_constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  // final String? label;
  final String hint;
  final IconData icon;
  final bool obscure;

  const InputField({
    Key? key,
    required this.controller,
    // required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      maxLines: 1,
      obscureText: obscure,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: primaryTextColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: secondaryTextColor, width: 0.0),
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 20.0,
          color: primaryTextColor,
        ),
      ),
    );
  }
}
