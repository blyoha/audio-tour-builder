class Tour {
  final String title;
  final String description;
  final double distance;
  final double time;
  final List<Place> places;

  Tour({
    required this.title,
    required this.description,
    required this.distance,
    required this.time,
    required this.places,
  });

  Tour copyWith({
    String? title,
    String? description,
    double? distance,
    double? time,
    List<Place>? places,
  }) {
    return Tour(
      title: title ?? this.title,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      places: places ?? this.places,
    );
  }
}

class Place {
  final String title;
  final String description;
  final Object? location;
  final Object? audio;

  Place({
    required this.title,
    required this.description,
    this.location,
    this.audio,
  });
}
