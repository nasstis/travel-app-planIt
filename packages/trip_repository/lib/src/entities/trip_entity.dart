class TripEntity {
  String id;
  String userId;
  String cityId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String? description;
  List<String>? placesId;

  TripEntity({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.startDate,
    required this.endDate,
    required this.name,
    this.description,
    this.placesId,
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
      description: doc['description'],
    );
  }
}
