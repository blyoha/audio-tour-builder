import 'package:flutter/material.dart';

import 'tour_card_widget.dart';

class TourListWidget extends StatefulWidget {
  final List tourList;

  const TourListWidget({Key? key, required this.tourList}) : super(key: key);

  @override
  State<TourListWidget> createState() => _TourListWidgetState();
}

class _TourListWidgetState extends State<TourListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.tourList.isEmpty
        ? const Center(child: Text('No tours yet!'))
        : Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.tourList.length,
                itemBuilder: (context, index) =>
                    TourCardWidget(tour: widget.tourList[index]),
              ),
          ],
        );
  }
}
