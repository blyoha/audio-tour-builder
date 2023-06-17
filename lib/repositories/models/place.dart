import 'dart:io';

import 'package:latlong2/latlong.dart';

class Place {
  final int? key;
  final String? title;
  final String? description;
  final LatLng? location;
  final String? audioUri;

  Place({
    this.key,
    this.title,
    this.description,
    this.location,
    this.audioUri,
  });

  factory Place.fromJson(Map<dynamic, dynamic> json) {
    final LatLng location = LatLng(
      json['location'].latitude,
      json['location'].longitude,
    );

    return Place(
      key: json['key'],
      title: json['title'],
      description: json['description'],
      location: location,
      audioUri: json['audioUri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'description': description,
      'location': location,
      'audioUri': audioUri,
    };
  }

  Place copyWith({
    int? key,
    String? title,
    String? description,
    LatLng? location,
    File? audio,
    String? audioUri,
  }) {
    return Place(
      key: key ?? this.key,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      audioUri: audioUri ?? this.audioUri,
    );
  }

  @override
  String toString() {
    return "$key. Place $title | $location | $audioUri";
  }

  @override
  bool operator ==(Object other) {
    return (key == (other as Place).key);
  }
}
