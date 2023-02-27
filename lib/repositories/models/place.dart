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