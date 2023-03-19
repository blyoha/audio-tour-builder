import 'place.dart';

class Tour {
  final String? id;
  final String title;
  final String description;
  final double distance;
  final double time;
  final List<Place> places;

  Tour({
    this.id,
    required this.title,
    required this.description,
    required this.distance,
    required this.time,
    required this.places,
  });

  factory Tour.fromJson(Map<dynamic, dynamic> json) {
    List<Place> places = [];

    if (json['places'] != null) {
      json['places'].forEach((value) => places.add(Place.fromJson(value)));
    }

    return Tour(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      places: places,
      time: json['time'].toDouble(),
      distance: json['distance'].toDouble(),
    );
  }

  factory Tour.empty() {
    return Tour(
      title: "",
      description: "",
      distance: 0.0,
      time: 0.0,
      places: [],
    );
  }

  Tour copyWith({
    String? id,
    String? title,
    String? description,
    double? distance,
    double? time,
    List<Place>? places,
  }) {
    return Tour(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      places: places ?? this.places,
    );
  }
}
