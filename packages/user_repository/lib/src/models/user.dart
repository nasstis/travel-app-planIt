import '../entities/entities.dart';

class MyUser {
  String userId;
  String name;
  String email;
  List<String> favoriteCities;
  List<String> favoritePlaces;

  MyUser({
    required this.userId,
    required this.name,
    required this.email,
    this.favoriteCities = const [],
    this.favoritePlaces = const [],
  });

  static final MyUser empty = MyUser(
    userId: '',
    name: '',
    email: '',
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      name: name,
      email: email,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      favoriteCities: entity.favoriteCities,
      favoritePlaces: entity.favoritePlaces,
    );
  }
}
