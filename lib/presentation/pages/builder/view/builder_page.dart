import 'package:audioTourBuilder/presentation/pages/builder/widgets/tab_view.dart';
import 'package:flutter/material.dart';

import '../widgets/details_tab.dart';
import '../widgets/map_tab.dart';

class BuilderPage extends StatefulWidget {
  static const String route = 'builder';

  const BuilderPage({Key? key}) : super(key: key);

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 'save',
          onPressed: () {
            if (titleController.text.isEmpty | descController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Empty text fields!')),
              );
            } else {}
          },
          label: const Text('Save Tour'),
        ),
        body: _buildView(),
      ),
    );
  }

  Widget _buildView() {
    return TabBarView(
      children: [
        DetailsTab(
          titleController: titleController,
          descController: descController,
        ),
        MapTab(),
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
