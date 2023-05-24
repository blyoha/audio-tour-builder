import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../theme/theme_constants.dart';
import '../widgets/tours_list.dart';

class ExplorePage extends StatelessWidget {
  static const String route = "explore";

  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Explore Tours")),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBar(
              leading: Icon(
                Icons.search,
                color: primaryTextColor.withOpacity(0.5),
              ),
              hintText: "Search for tours",
            ),
            const Gap(12.0),
            RefreshIndicator(
              onRefresh: () async {
                print("refreshed");
              },
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: primaryColor,
              child: const ToursList(),
            ),
          ],
        ),
      ),
    );
  }
}
