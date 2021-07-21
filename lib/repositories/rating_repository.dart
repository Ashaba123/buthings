import 'package:buthings/models/rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IRatingRepository {
  Stream<List<QueryDocumentSnapshot>> getAllRatings();
  createRating(Rating rating);
  updateRating(int id);
  deleteRating(int id);
  Future<int> countRatings();
}

class RatingRepository extends IRatingRepository {
  final db = FirebaseFirestore.instance
      .collection('ratings')
      .withConverter<Rating>(
          fromFirestore: (snapshot, _) => Rating.fromJson(snapshot.data()!),
          toFirestore: (rating, _) => rating.toJson());

  @override
  Stream<List<QueryDocumentSnapshot>> getAllRatings() {
    return db.get().then((value) => value.docs).asStream();
  }

  @override
  createRating(Rating rating) async {
    return await db.doc(rating.id.toString()).set(rating);
  }

  @override
  deleteRating(int id) {
    throw UnimplementedError();
  }

  @override
  updateRating(int id) {
    throw UnimplementedError();
  }

  @override
  Future<int> countRatings() async {
    QuerySnapshot q = await db.get();
    return q.docs.length;
  }
}
