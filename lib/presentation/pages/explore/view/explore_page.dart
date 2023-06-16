import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../repositories/models/tour.dart';
import '../../../../theme/theme_constants.dart';
import '../widgets/tours_list.dart';

class ExplorePage extends StatefulWidget {
  static const String route = "explore";

  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late final ToursRepository repo;
  List<Tour> tours = [];
  List<Tour> visibleList = [];

  @override
  void initState() {
    super.initState();
    repo = context.read();
    _refresh();
  }

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
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBar(
              leading: Icon(
                Icons.search,
                color: primaryTextColor.withOpacity(0.5),
              ),
              hintText: "Search for tours",
              onChanged: _search,
            ),
            const Gap(12.0),
            Expanded(child: tours.isEmpty ? _showEmptySpace() : _showList()),
          ],
        ),
      ),
    );
  }

  Widget _showEmptySpace() {
    return Center(
      child: Text(
        "No tours here :(",
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: secondaryTextColor),
      ),
    );
  }

  Widget _showList() {
    return RefreshIndicator(
      onRefresh: _refresh,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      color: primaryColor,
      child: ToursList(tours: visibleList),
    );
  }

  Future<void> _refresh() async {
    final fetched = await repo.getAllTours();
    tours = fetched;
    visibleList = tours;
    setState(() {});
  }

  void _search(String value) {
    setState(() {
      visibleList = tours
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
