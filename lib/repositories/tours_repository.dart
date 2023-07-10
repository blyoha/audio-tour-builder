import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'models/models.dart';

class ToursRepository {
  final _fireStore = FirebaseFirestore.instance;
  final Reference _storage = FirebaseStorage.instance.ref();

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<bool> isOwned(Tour tour) async {
    final List result = await _fireStore
        .collection('users')
        .doc(userId)
        .collection('tours')
        .where('key', isEqualTo: tour.key)
        .get()
        .then((value) => value.docs);

    return result.isNotEmpty;
  }

  Future<bool> toggleLike(Tour tour) async {
    final ref = _fireStore
        .collection('users')
        .doc(tour.author)
        .collection('tours')
        .doc(tour.key);

    try {
      await _fireStore.collection('users').doc(userId).update({
        'favorites': tour.isLiked
            ? FieldValue.arrayRemove([ref])
            : FieldValue.arrayUnion([ref])
      });
    } catch (e) {
      return false;
    }

    tour.isLiked = !tour.isLiked;
    return true;
  }

  Future<bool> _isLiked(String id) async {
    DocumentSnapshot user =
        await _fireStore.collection('users').doc(userId).get();

    final fav =
        List<DocumentReference>.from(user.get('favorites')).map((e) => e.id);

    return fav.contains(id);
  }

  Future<List<Tour>> getAllTours() async {
    var all = await _fireStore.collection('allTours').doc('tours').get();
    List<Tour> tours = [];

    for (DocumentReference ref in all.get('list')) {
      final data =
          await _fireStore.doc(ref.path).get().then((value) => value.data());
      final places = await _fireStore.doc(ref.path).collection('places').get();

      var list = places.docs.map((doc) => Place.fromJson(doc.data())).toList();
      bool liked = await _isLiked(ref.id);

      data?.addAll({'places': list, 'isLiked': liked});

      tours.add(Tour.fromJson(data as Map<String, dynamic>));
    }

    return tours;
  }

  Future<List<Tour>> getUserTours() async {
    QuerySnapshot snapshot = await _fireStore
        .collection('users')
        .doc(userId)
        .collection('tours')
        .get();

    List<Tour> tours = [];

    for (DocumentSnapshot doc in snapshot.docs) {
      var places = await doc.reference.collection('places').get();

      final data = doc.data() as Map<String, dynamic>;

      var list = places.docs.map((doc) => Place.fromJson(doc.data())).toList();

      bool liked = await _isLiked(doc.id);
      data.addAll({'places': list, 'isLiked': liked});
      data.addAll({'places': list});
      tours.add(Tour.fromJson(data));
    }

    return tours;
  }

  Future<List<Tour>> getFavorites() async {
    var snapshot = await _fireStore.collection('users').doc(userId).get();

    List<Tour> tours = [];

    for (DocumentReference doc in snapshot.get('favorites')) {
      final snapshot = await doc.get();

      if (!snapshot.exists) {
        _fireStore.collection('users').doc(userId).update({
          'favorites': FieldValue.arrayRemove([snapshot.reference])
        });
        continue;
      }

      final data = Map.from(snapshot.data() as Map<dynamic, dynamic>);
      final places = await doc.collection('places').get();

      var list = places.docs.map((doc) => Place.fromJson(doc.data())).toList();

      bool liked = await _isLiked(doc.id);
      data.addAll({'places': list, 'isLiked': liked});

      tours.add(Tour.fromJson(data));
    }

    return tours;
  }

  Future<Tour> updateTour(Tour tour) async {
    var tourRef = _fireStore
        .collection('users')
        .doc(userId)
        .collection('tours')
        .doc(tour.key);

    if (tour.key == null) {
      tour = tour.copyWith(key: tourRef.id);
    }

    if (tour.author.isEmpty) {
      tour = tour.copyWith(author: userId);
    }

    // Save cover image
    if (tour.imageUrl != null) {
      final file = File(tour.imageUrl!);
      String name = file.path.split('/').last;

      final coverRef =
          _storage.child('users/$userId/${tourRef.id}/cover/$name');

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

          final audioRef = _storage
              .child('users/$userId/${tourRef.id}/${p.key}/audio/$name');

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
                .child('users/$userId/${tourRef.id}/${p.key}/images/$name');

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
    final tourRef = _fireStore
        .collection('users')
        .doc(userId)
        .collection('tours')
        .doc(tour.key);

    try {
      // Delete all the files from storage
      List places = await _storage
          .child('users/$userId/${tourRef.id}/audio/')
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
}
