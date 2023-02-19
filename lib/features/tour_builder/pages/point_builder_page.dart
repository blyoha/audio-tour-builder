import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tour_builder_bloc.dart';
import '../bloc/tour_builder_event.dart';

class PointBuilderPage extends StatelessWidget {
  const PointBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TourBuilderBloc bloc = context.read();
    final titleController = TextEditingController();
    final descController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Point builder')),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        label: const Text('Save'),
        onPressed: () {
          if (titleController.text.isEmpty | descController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Empty text fields!'),
                duration: Duration(milliseconds: 500),
              ),
            );
          } else {
            bloc.add(TourBuilderAddPlace(
              title: titleController.text,
              description: descController.text,
            ));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Point saved.'),
                duration: Duration(milliseconds: 500),
              ),
            );
            Navigator.of(context).pop();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
          ],
        ),
      ),
    );
  }
}
