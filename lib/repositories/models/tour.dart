import 'place.dart';

class Tour {
  final String? key;
  final String title;
  final String description;
  final double distance;
  final double time;
  final List<Place> places;

  Tour({
    this.key,
    required this.title,
    required this.description,
    required this.distance,
    required this.time,
    required this.places,
  });

  factory Tour.fromJson(Map<dynamic, dynamic> json) {
    List<Place> places = [];

    if (json['places'] != null) {
      json['places'].forEach((value) {
      places.add(Place(
        title: value['title'],
        description: value['description'],
      ));
    });
    }

    return Tour(
      key: json['key'],
      title: json['title'],
      description: json['description'],
      places: places,
      time: json['time'].toDouble(),
      distance: json['distance'].toDouble(),
    );
  }

  Tour copyWith({
    String? key,
    String? title,
    String? description,
    double? distance,
    double? time,
    List<Place>? places,
  }) {
    return Tour(
      key: key ?? this.key,
      title: title ?? this.title,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      places: places ?? this.places,
    );
  }
}
