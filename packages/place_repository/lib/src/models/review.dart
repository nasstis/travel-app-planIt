import '../entities/entities.dart';

class Review {
  String text;
  double rating;
  String authorName;
  String authorPhoto;
  String publishTime;

  Review({
    required this.text,
    required this.rating,
    required this.authorName,
    required this.authorPhoto,
    required this.publishTime,
  });

  static Review fromEntity(ReviewEntity entity) {
    return Review(
      text: entity.text,
      rating: entity.rating,
      authorName: entity.authorName,
      authorPhoto: entity.authorPhoto,
      publishTime: entity.publishTime,
    );
  }
}
