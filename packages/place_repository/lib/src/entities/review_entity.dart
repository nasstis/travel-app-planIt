class ReviewEntity {
  String text;
  double rating;
  String authorName;
  String authorPhoto;
  String publishTime;

  ReviewEntity({
    required this.text,
    required this.rating,
    required this.authorName,
    required this.authorPhoto,
    required this.publishTime,
  });

  static ReviewEntity fromDocument(Map<String, dynamic> doc) {
    return ReviewEntity(
      text: doc["text"]["text"],
      rating: doc["rating"].toDouble(),
      authorName: doc["authorAttribution"]["displayName"],
      authorPhoto: doc["authorAttribution"]["photoUri"],
      publishTime: doc["publishTime"],
    );
  }
}
