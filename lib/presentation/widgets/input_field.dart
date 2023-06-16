import 'package:flutter/material.dart';

import '../../../../theme/theme_constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final int lines;
  final bool obscure;

  const InputField({
    Key? key,
    this.controller,
    this.hint,
    this.lines = 1,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: lines,
      maxLines: lines,
      cursorColor: primaryColor,
      obscureText: obscure,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
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
