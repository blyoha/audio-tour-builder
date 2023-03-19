import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

abstract class ToursRepository {
  Future<List<Tour>> getAllTours();

  Future<Tour> updateTour(Tour tour);

  void deleteTour(Tour tour);
}

class ToursRepositoryImpl implements ToursRepository {
  final _fireStore = FirebaseFirestore.instance.collection('users');
  final Reference _storage = FirebaseStorage.instance.ref();

  // TODO: Use instance from AuthRepository
  final String user = FirebaseAuth.instance.currentUser!.uid;

  Future<String> _uploadFile(File file) async {
    final String fileName = const Uuid().v4();

    Reference ref = _storage.child('users/$user/audio').child(fileName);

    String fileUrl = await ref
        .putFile(file)
        .then((value) async => await value.ref.getDownloadURL());

    return fileUrl;
  }

  @override
  Future<List<Tour>> getAllTours() async {
    QuerySnapshot snapshot =
    await _fireStore.doc(user).collection('tours').get();
    if (snapshot.size == 0) {
      return List.empty();
    }

    List<Tour> tours = [];
    for (var doc in snapshot.docs) {
      var tour = Tour.fromJson(doc.data() as Map);
      var placesRef = await doc.reference.collection('places').get();
      var places =
      placesRef.docs.map((place) => Place.fromJson(place.data())).toList();

      tour = tour.copyWith(
        id: doc.id,
        places: places,
      );
      tours.add(tour);
    }

    return tours;
  }

  @override
  Future<Tour> updateTour(Tour tour) async {
    var tourRef = _fireStore.doc(user).collection('tours').doc(tour.id);
    var placesRef = tourRef.collection('places');

    Map<String, dynamic> data = {
      'title': tour.title,
      'description': tour.description,
      'distance': tour.distance,
      'time': tour.time,
    };
    await tourRef.set(data);

    for (var i = 0; i < tour.places.length; i++) {
      var placeRef = placesRef.doc(tour.id);

      var data = {
        'title': tour.places[i].title,
        'description': tour.places[i].description,
        'location': GeoPoint(
          tour.places[i].location.latitude,
          tour.places[i].location.longitude,
        ),
      };

      if (tour.places[i].audio != null) {
        data.addAll({'audio': _uploadFile(tour.places[i].audio!)});
      }

      tour.places[i] = tour.places[i].copyWith(id: placeRef.id);
      await placeRef.set(data);
    }

    return tour;
  }

  @override
  void deleteTour(Tour tour) {
    _fireStore.doc(user).collection('tours').doc(tour.id).delete();
  }
}
