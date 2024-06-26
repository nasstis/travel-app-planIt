class MyUserEntity {
  String userId;
  String name;
  String email;
  String photo;
  int rank;
  int score;
  List<dynamic> favoriteCities;
  List<dynamic> favoritePlaces;
  List<String> recentlyViewed;

  MyUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.photo,
    this.rank = 0,
    this.score = 0,
    this.favoriteCities = const [],
    this.favoritePlaces = const [],
    this.recentlyViewed = const [],
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'photo': photo,
      'rank': rank,
      'score': score,
      'favoriteCities': favoriteCities,
      'favoritePlaces': favoritePlaces,
      'recentlyViewed': recentlyViewed,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
      photo: doc['photo'],
      rank: doc['rank'],
      score: doc['score'],
      favoriteCities: doc['favoriteCities'],
      favoritePlaces: doc['favoritePlaces'],
      recentlyViewed: doc['recentlyViewed'].cast<String>(),
    );
  }
}
