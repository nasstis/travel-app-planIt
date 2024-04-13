class TripEntity {
  String id;
  String userId;
  String cityId;
  List<String> placesId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String? description;

  TripEntity({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.placesId,
    required this.startDate,
    required this.endDate,
    required this.name,
    this.description,
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
      placesId: doc['placesId'] as List<String>,
      startDate: doc['startDate'],
      endDate: doc['endDate'],
      name: doc['name'],
      description: doc['description'],
    );
  }
}