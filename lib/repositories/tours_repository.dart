import 'package:firebase_database/firebase_database.dart';

import 'models/tour.dart';

abstract class ToursRepository {
  Future<List<Tour>> getAllTours();

  Future<Tour> updateTour(Tour tour);

  void deleteTour(Tour tour);
}

class FirebaseTourRepository implements ToursRepository {
  final DatabaseReference _fireRef = FirebaseDatabase.instance.ref('all_tours');

  FirebaseTourRepository();

  @override
  Future<List<Tour>> getAllTours() async {
    List<Tour> tours = [];
    final snapshot = await _fireRef.get();

    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        Map data = {'key': key};
        data.addAll(value);
        tours.add(Tour.fromJson(data));
      });
    }

    return tours;
  }

  @override
  Future<Tour> updateTour(Tour tour) async {
    List places = [];

    for (var place in tour.places) {
      places.add({
        'title': place.title,
        'description': place.description,
        'audio': place.audio,
        'location': {
          'lat': place.location.latitude,
          'lng': place.location.longitude,
        },
      });
    }

    Map<String, dynamic> data = {
      'title': tour.title,
      'description': tour.description,
      'places': places,
      'distance': tour.distance,
      'time': tour.time,
    };

    String? key = tour.key ?? _fireRef.push().key;
    await _fireRef.child(key as String).update(data);

    return tour.copyWith(key: key);
  }

  @override
  void deleteTour(Tour tour) async {
    await _fireRef.child('${tour.key}').remove();
  }
}
