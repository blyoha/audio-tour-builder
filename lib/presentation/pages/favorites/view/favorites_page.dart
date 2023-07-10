import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/models/tour.dart';
import '../../../../repositories/tours_repository.dart';
import '../../../../theme/theme_constants.dart';
import '../widgets/tours_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final ToursRepository repo;
  List<Tour> tours = [];
  List<Tour> visibleList = [];

  @override
  void initState() {
    super.initState();
    repo = context.read<ToursRepository>();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Favorite tours')),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: tours.isEmpty ? _showEmptyList() : _showList(),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _showEmptyList() {
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
    return ToursList(tours: visibleList);
  }

  Future<void> _refresh() async {
    final fetched = await repo.getFavorites();
    tours = fetched;
    visibleList = tours;

    setState(() {});
  }
}
