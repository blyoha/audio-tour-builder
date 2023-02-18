import 'package:flutter/material.dart';

import '../utils/styles.dart';


class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
              color: AppColors.black.withOpacity(.25),
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.black.withOpacity(.25),
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
