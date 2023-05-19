import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6.0,
              spreadRadius: -3,
              color: AppColors.primary.withOpacity(.25),
            ),
          ],
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primary.withOpacity(.25),
            width: 1,
          ),
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  List<String>? filterSearchTerms({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return null;
    }
    return [];
  }
}
