import '../entities/entities.dart';

class MyUser {
  String userId;
  String name;
  String email;
  String photo;
  List<dynamic> favoriteCities;
  List<dynamic> favoritePlaces;
  List<String> recentlyViewed;

  MyUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.photo,
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
      favoriteCities: entity.favoriteCities,
      favoritePlaces: entity.favoritePlaces,
      recentlyViewed: entity.recentlyViewed,
    );
  }
}
