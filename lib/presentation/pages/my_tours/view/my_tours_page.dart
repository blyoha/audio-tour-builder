import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/models/tour.dart';
import '../../../../repositories/tours_repository.dart';
import '../../../../theme/theme_constants.dart';
import '../widgets/tours_list.dart';

class MyToursPage extends StatefulWidget {
  static const String route = 'myTours';

  const MyToursPage({Key? key}) : super(key: key);

  @override
  State<MyToursPage> createState() => _MyToursPageState();
}

class _MyToursPageState extends State<MyToursPage> {
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
      appBar: AppBar(title: const Text("My Tours")),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "create",
        onPressed: () =>
            Navigator.of(context).pushNamed("builder", arguments: Tour.empty()),
        label: const Text("Create"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: tours.isEmpty ? _showEmptySpace() : _showList(),
        ),
      ),
    );
  }

  Widget _showEmptySpace() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Text(
          "No tours here :(",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: secondaryTextColor),
        )
      ],
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
}
