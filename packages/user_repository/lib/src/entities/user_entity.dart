class MyUserEntity {
  String userId;
  String name;
  String email;
  List<dynamic> favoriteCities;
  List<dynamic> favoritePlaces;

  MyUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    this.favoriteCities = const [],
    this.favoritePlaces = const [],
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'favoriteCities': favoriteCities,
      'favoritePlaces': favoritePlaces,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
      favoriteCities: doc['favoriteCities'],
      favoritePlaces: doc['favoritePlaces'],
    );
  }
}
