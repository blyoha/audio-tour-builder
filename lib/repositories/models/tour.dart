import 'place.dart';

class Tour {
  final String? key;
  final String title;
  final String description;
  final double distance;
  final double time;
  final List<Place> places;
  final String? imageUrl;

  Tour({
    this.key,
    required this.title,
    required this.description,
    required this.distance,
    required this.time,
    required this.places,
    this.imageUrl,
  });

  factory Tour.fromJson(Map<dynamic, dynamic> json) {
    return Tour(
      key: json['key'],
      title: json['title'],
      description: json['description'],
      places: json['places'],
      time: json['time'] ?? 0.0,
      distance: json['distance'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'description': description,
      'time': time,
      'distance': distance,
    };
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

  @override
  String toString() {
    return "$title. ${places.length} places";
  }
}
