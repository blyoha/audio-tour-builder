import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'models/models.dart';

class ToursRepository {
  final _fireStore = FirebaseFirestore.instance.collection('users');
  final Reference _storage = FirebaseStorage.instance.ref();

  // TODO: Use instance from AuthRepository
  final String user = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Tour>> getAllTours() async {
    QuerySnapshot snapshot =
        await _fireStore.doc(user).collection('tours').get();

    if (snapshot.size == 0) {
      return List.empty();
    }

    List<Tour> tours = [];
    for (var doc in snapshot.docs) {
      // TODO: do not download audio files
      var tourData = doc.data() as Map;

      var tour = Tour.fromJson(tourData);
      var placesRef = await doc.reference.collection('places').get();

      List<Place> places = [];

      for (var doc in placesRef.docs) {
        var placeData = doc.data();
        // Get audio
        String? audio = placeData['audio'];

        if (audio != null) {
          final File? file;
          final audioRef = FirebaseStorage.instance.refFromURL(audio);
          final dir = await getApplicationDocumentsDirectory();
          // Download the audio file
          file = File('${dir.path}/${audioRef.name}');
          await audioRef.writeToFile(file);
          // Apply the file URL
          placeData.addAll({'audio': file});
        }

        places.add(Place.fromJson(placeData));
      }

      tour = tour.copyWith(
        id: doc.id,
        places: places,
      );

      tours.add(tour);
    }

    return tours;
  }

  Future<Tour> updateTour(Tour tour) async {
    var tourRef = _fireStore.doc(user).collection('tours').doc(tour.id);
    var placesRef = tourRef.collection('places');

    // Uploading the data to FireStore
    Map<String, dynamic> data = {
      'title': tour.title,
      'description': tour.description,
      'distance': tour.distance,
      'time': tour.time,
    };

    // Change data
    await tourRef.set(data);

    // Clear the list of places
    var storeList = await placesRef.get().then((value) => value.docs);
    var t = tour.places.map((e) => e.title);
    for (QueryDocumentSnapshot i in storeList) {
      if (!t.contains(i.get('title'))) {
        await FirebaseStorage.instance.refFromURL(i.get('audio')).delete();
        i.reference.delete();
      }
    }

    for (var i = 0; i < tour.places.length; i++) {
      var p = tour.places[i];
      var placeRef = placesRef.doc('$i');
      var placeData = {
        'title': p.title,
        'description': p.description,
        'location': GeoPoint(
          p.location!.latitude,
          p.location!.longitude,
        ),
      };

      if (p.audio != null) {
        String name = p.audio!.path.split('/').last;
        Reference audioRef =
            _storage.child('users/$user/${tourRef.id}/audio/$name');

        // Upload to Storage
        try {
          var snapshot = await audioRef.putFile(p.audio!);
          String url = await snapshot.ref.getDownloadURL();
          placeData.addAll({'audio': url});
        } on FirebaseException catch (e) {
          print(e);
        }
      }

      tour.places[i] = p.copyWith(key: placeRef.id as int);
      await placeRef.set(placeData);
    }
    //
    // // Clear the list of tours to avoid duplicates
    // for (var doc in await placesRef.get().then((value) => value.docs)) {
    //   await doc.reference.delete();
    // }
    //
    // for (var i = 0; i < tour.places.length; i++) {
    //   var placeRef = placesRef.doc('$i');
    //
    //   var data = {
    //     'title': tour.places[i].title,
    //     'description': tour.places[i].description,
    //     'location': GeoPoint(
    //       tour.places[i].location.latitude,
    //       tour.places[i].location.longitude,
    //     ),
    //   };
    //
    //   if (tour.places[i].audio != null) {
    //     data.addAll({'audio': _uploadFile(tour.places[i].audio!)});
    //   }
    //
    //   tour.places[i] = tour.places[i].copyWith(id: placeRef.id);
    //   await placeRef.set(data);
    // }

    return tour;
  }

  Future<void> deleteTour(Tour tour) async {
    final tourRef = _fireStore.doc(user).collection('tours').doc(tour.id);

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
