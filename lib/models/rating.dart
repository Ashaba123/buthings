class Rating {
  String? id;
  String? product;
  String? user;
  int? rating;
  String? comment;

  Rating({this.id, this.user, this.product, this.rating, this.comment});

  Rating.fromJson(Map<String, Object?> json)
      : this(
          id: json["id"] as String,
          user: json["user"] as String,
          product: json["product"] as String,
          rating: json["product"] as int,
          comment: json["product"] as String,
        );

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "product": product,
      "user": user,
      "rating": rating,
      "comment": comment,
    };
  }
}
