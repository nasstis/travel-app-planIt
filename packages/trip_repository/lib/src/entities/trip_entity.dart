class TripEntity {
  String id;
  String userId;
  String cityId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String photoUrl;
  String? description;
  List placesId;

  TripEntity({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.photoUrl,
    this.description,
    required this.placesId,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'userId': userId,
      'cityId': cityId,
      'placesId': placesId,
      'startDate': startDate,
      'endDate': endDate,
      'name': name,
      'photoUrl': photoUrl,
      'description': description,
    };
  }

  static TripEntity fromDocument(Map<String, dynamic> doc) {
    return TripEntity(
      id: doc['id'],
      userId: doc['userId'],
      cityId: doc['cityId'],
      placesId: doc['placesId'],
      startDate: doc['startDate'].toDate(),
      endDate: doc['endDate'].toDate(),
      name: doc['name'],
      photoUrl: doc['photoUrl'],
      description: doc['description'],
    );
  }
}
