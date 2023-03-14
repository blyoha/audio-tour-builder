import 'dart:io';

import 'package:latlong2/latlong.dart';

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

  factory Place.fromJson(Map<dynamic, dynamic> json) {
    final LatLng location = LatLng(
      json['location']['lat'],
      json['location']['lng'],
    );

    return Place(
      title: json['title'],
      description: json['description'],
      location: location,
      audio: json['audio'],
    );
  }

  Place copyWith({
    String? title,
    String? description,
    LatLng? location,
    File? audio,
  }) {
    return Place(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      audio: audio ?? this.audio,
    );
  }
}