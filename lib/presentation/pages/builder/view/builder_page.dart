import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/builder/builder_bloc.dart';
import '../../../../repositories/location_repository.dart';
import '../../../../repositories/models/tour.dart';
import '../../../../repositories/tours_repository.dart';
import '../widgets/details_tab/details_tab.dart';
import '../widgets/map_tab/map_tab.dart';
import '../widgets/tab_view.dart';

class BuilderPage extends StatefulWidget {
  static const String route = 'builder';

  final Tour tour;

  const BuilderPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final coverController = TextEditingController();

  late final BuilderBloc bloc;

  @override
  void initState() {
    super.initState();

    Tour tour = widget.tour;
    bloc = BuilderBloc(
      toursRepo: ToursRepository(),
      locationRepo: LocationRepository(),
    );
    bloc.add(BuilderLoad(tour: tour));

    titleController.text = tour.title;
    descController.text = tour.description;

    if (tour.imageUrl != null) {
      coverController.text = tour.imageUrl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuilderBloc>.value(
      value: bloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(),
          floatingActionButton: BlocBuilder<BuilderBloc, BuilderState>(
            bloc: bloc,
            builder: (context, state) {
              final label = (state is BuilderEditing)
                  ? const Text('Save')
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );

              return FloatingActionButton.extended(
                heroTag: 'save',
                onPressed: () async {
                  final title = titleController.text;
                  final desc = descController.text;

                  if (state is BuilderEditing) {
                    if (title.isEmpty | desc.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Empty text fields!')),
                      );
                    } else {
                      // Rename cover file
                      var file = File(coverController.text);
                      if (coverController.text.isNotEmpty) {
                        var lastSeparator =
                            file.path.lastIndexOf(Platform.pathSeparator);
                        var lastDot = file.path.lastIndexOf('.');
                        var path = file.path.substring(0, lastSeparator + 1);
                        var type = file.path.substring(lastDot);
                        var newPath = '${path}cover$type';

                        file = await file.rename(newPath);
                      }
                      final tour = state.tour.copyWith(
                        title: title,
                        description: desc,
                        imageUrl: file.path,
                      );

                      bloc.add(BuilderSave(tour: tour));
                    }
                  }
                },
                label: label,
              );
            },
          ),
          body: _buildView(),
        ),
      ),
    );
  }

  Widget _buildView() {
    return TabBarView(
      children: [
        DetailsTab(
          titleController: titleController,
          descController: descController,
          coverController: coverController,
        ),
        const MapTab(),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Create tour'),
      bottom: const TabView(tabs: [
        Tab(height: 35, child: Text('Details')),
        Tab(height: 35, child: Text('Map')),
      ]),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
