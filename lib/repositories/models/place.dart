import 'dart:io';

import 'package:latlong2/latlong.dart';

class Place {
  final String? id;
  final String title;
  final String description;
  final LatLng location;
  final File? audio;

  Place({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    this.audio,
  });

  factory Place.fromJson(Map<dynamic, dynamic> json) {
    final LatLng location = LatLng(
      json['location'].latitude,
      json['location'].longitude,
    );

    return Place(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: location,
      audio: json['audio'],
    );
  }

  Place copyWith({
    String? id,
    String? title,
    String? description,
    LatLng? location,
    File? audio,
  }) {
    return Place(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      audio: audio ?? this.audio,
    );
  }
}
