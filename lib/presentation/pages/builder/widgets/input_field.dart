import 'package:flutter/material.dart';

import '../../../../theme/theme_constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final int lines;

  const InputField({
    Key? key,
    this.controller,
    this.lines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      minLines: lines,
      maxLines: lines,
      cursorColor: primaryColor,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
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
