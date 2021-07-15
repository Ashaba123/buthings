import 'package:buthings/models/rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IRatingRepository {
  Stream<List<Rating>> getAllRatings();
  createRating(int id);
  updateRating(int id);
  deleteRating(int id);
}

class RatingRepository extends IRatingRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Stream<List<Rating>> getAllRatings() {
    return db.collection("categories").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Rating.fromJson(doc.data())).toList());
  }

  @override
  createRating(int id) {
    throw UnimplementedError();
  }

  @override
  deleteRating(int id) {
    throw UnimplementedError();
  }

  @override
  updateRating(int id) {
    throw UnimplementedError();
  }
}
