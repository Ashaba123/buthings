import 'package:buthings/models/rating.dart';
import 'package:buthings/repositories/rating_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RatingsProvider extends ChangeNotifier {
  final _ratingsRepo = RatingRepository();

  Future createRating(Rating? rating) {
    return _ratingsRepo.createRating(rating!);
  }

  Stream<List<QueryDocumentSnapshot>> getAllRatings() {
    return _ratingsRepo.getAllRatings();
  }

  Future<int> countRatings() {
    return _ratingsRepo.countRatings();
  }
}
