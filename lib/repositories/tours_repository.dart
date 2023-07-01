import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:latlong2/latlong.dart';

import 'models/models.dart';

class ToursRepository {
  final _fireStore = FirebaseFirestore.instance.collection('users');
  final Reference _storage = FirebaseStorage.instance.ref();

  // TODO: Use instance from AuthRepository
  final String user = FirebaseAuth.instance.currentUser!.uid;

  List<Place> _convertPlaces(dynamic list) {
    List<Place> places = [];
    for (var p in list) {
      final place = p.data();
      place.update(
          'location', (value) => LatLng(value.latitude, value.longitude));

      places.add(Place.fromJson(place));
    }

    return places;
  }

  Future<List<Tour>> getAllTours() async {
    QuerySnapshot snapshot =
        await _fireStore.doc(user).collection('tours').get();

    List<Tour> tours = [];

    for (var doc in snapshot.docs) {
      var placesRef = await doc.reference.collection('places').get();

      final tour = doc.data() as Map<String, dynamic>;

      tour.addAll({'places': _convertPlaces(placesRef.docs)});
      tours.add(Tour.fromJson(tour));
    }

    return tours;
  }

  Future<Tour> updateTour(Tour tour) async {
    var tourRef = _fireStore.doc(user).collection('tours').doc(tour.key);

    if (tour.key == null) {
      tour = tour.copyWith(key: tourRef.id);
    }

    // Save cover image
    if (tour.imageUrl != null) {
      final file = File(tour.imageUrl!);
      String name = file.path.split('/').last;

      final coverRef = _storage.child('users/$user/${tourRef.id}/cover/$name');

      String remoteUri = await coverRef
          .putFile(file)
          .then((snapshot) async => await snapshot.ref.getDownloadURL());

      tour = tour.copyWith(imageUrl: remoteUri);
    }

    await tourRef.set(tour.toJson());

    var placesRef = tourRef.collection('places');
    for (Place p in tour.places) {
      var placeRef = placesRef.doc(p.key.toString());

      final json = p.toJson();
      json['location'] = GeoPoint(
        json['location'].latitude,
        json['location'].longitude,
      );

      // Save audio
      if (p.audioUri != null) {
        if (!p.audioUri!.contains('googleapis.com')) {
          // It's a local file. Needs to be uploaded
          final file = File(p.audioUri!);
          String name = file.path.split('/').last;

          final audioRef =
              _storage.child('users/$user/${tourRef.id}/${p.key}/audio/$name');

          String remoteUri = await audioRef
              .putFile(file)
              .then((snapshot) async => await snapshot.ref.getDownloadURL());

          json['audioUri'] = remoteUri;
        }
      }

      // Save images
      final List<String> images = [];
      if (p.images != null) {
        for (String i in p.images!) {
          if (!i.contains('googleapis.com')) {
            // It's a local file. Needs to be uploaded
            final file = File(i);
            String name = file.path.split('/').last;

            final imageRef = _storage
                .child('users/$user/${tourRef.id}/${p.key}/images/$name');

            String remoteUri = await imageRef
                .putFile(file)
                .then((snapshot) async => await snapshot.ref.getDownloadURL());

            images.add(remoteUri);
          }
        }
      }
      json['images'] = images;

      await placeRef.set(json);
    }

    return tour;
  }

  Future<void> deleteTour(Tour tour) async {
    final tourRef = _fireStore.doc(user).collection('tours').doc(tour.key);

    try {
      // Delete all the files from storage
      List places = await _storage
          .child('users/$user/${tourRef.id}/audio/')
          .listAll()
          .then((value) => value.items);
      for (Reference item in places) {
        await item.delete();
      }
      // Delete the tour FireStore
      await tourRef.delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<List<Tour>> getUserTours() {
    // TODO: implement getUserTours
    throw UnimplementedError();
  }
}
