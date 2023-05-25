import 'package:flutter/material.dart';

import '../../../../theme/theme_constants.dart';
import '../widgets/tours_list.dart';

class MyToursPage extends StatefulWidget {
  static const String route = 'myTours';

  const MyToursPage({Key? key}) : super(key: key);

  @override
  State<MyToursPage> createState() => _MyToursPageState();
}

class _MyToursPageState extends State<MyToursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("My Tours")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("create new tour");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Center(child: Text("CREATOR PAGE"))));
        },
        label: const Text("Create"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  print("refreshed");
                },
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                color: primaryColor,
                child: const ToursList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
