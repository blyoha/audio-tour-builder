import 'place.dart';

class Tour {
  final String? key;
  final String author;
  final String title;
  final String description;
  final double distance;
  final double time;
  final List<Place> places;
  final String? imageUrl;
  bool isLiked;

  Tour({
    this.key,
    required this.author,
    required this.title,
    required this.description,
    required this.distance,
    required this.time,
    required this.places,
    this.imageUrl,
    this.isLiked = false,
  });

  factory Tour.fromJson(Map<dynamic, dynamic> json) {
    return Tour(
      key: json['key'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      places: json['places'],
      time: json['time'] ?? 0.0,
      distance: json['distance'] ?? 0.0,
      isLiked: json['isLiked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'author': author,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'time': time,
      'distance': distance,
    };
  }

  factory Tour.empty() {
    return Tour(
      author: '',
      title: '',
      description: '',
      imageUrl: null,
      distance: 0.0,
      time: 0.0,
      places: [],
      isLiked: false
    );
  }

  Tour copyWith({
    String? key,
    String? author,
    String? title,
    String? description,
    String? imageUrl,
    double? distance,
    double? time,
    bool? isLiked,
    List<Place>? places,
  }) {
    return Tour(
      key: key ?? this.key,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      isLiked: isLiked ?? this.isLiked,
      places: places ?? this.places,
    );
  }

  @override
  String toString() {
    return '$title. ${places.length} places';
  }
}
