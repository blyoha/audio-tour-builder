import 'package:flutter/material.dart';

import '../../../../theme/theme_constants.dart';

class TabView extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;

  const TabView({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(45),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: TabBar(
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45.0);
}
