import '../entities/entities.dart';

class MyUser {
  String userId;
  String name;
  String email;
  String photo;
  int rank;
  int score;
  List<dynamic> favoriteCities;
  List<dynamic> favoritePlaces;
  List<String> recentlyViewed;
  final rankSystem = [
    {'rank': 0, 'minScore': 0},
    {'rank': 1, 'minScore': 40},
    {'rank': 2, 'minScore': 100},
    {'rank': 3, 'minScore': 160},
    {'rank': 4, 'minScore': 240},
    {'rank': 5, 'minScore': 320},
  ];

  MyUser({
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

  static final MyUser empty = MyUser(
    userId: '',
    name: '',
    email: '',
    photo: '',
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      name: name,
      email: email,
      photo: photo,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      photo: entity.photo,
      rank: entity.rank,
      score: entity.score,
      favoriteCities: entity.favoriteCities,
      favoritePlaces: entity.favoritePlaces,
      recentlyViewed: entity.recentlyViewed,
    );
  }
}
