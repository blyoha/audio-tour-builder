import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;

  const AppButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(label),
      onPressed: () {},
    );
  }
}
