class PlaceEntity {
  String id;
  String name;
  String description;
  List<dynamic> pictures;
  double latitude;
  double longitude;
  String cityId;

  PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pictures,
    required this.latitude,
    required this.longitude,
    required this.cityId,
  });

  Map<String, Object?> toDocument() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "pictures": pictures,
      "latitude": latitude,
      "longitude": longitude,
      "cityId": cityId,
    };
  }

  static PlaceEntity fromDocument(Map<String, dynamic> doc) {
    return PlaceEntity(
      id: doc["id"],
      name: doc["name"],
      description: doc["description"],
      pictures: doc["pictures"],
      latitude: doc["latitude"],
      longitude: doc["longitude"],
      cityId: doc["cityId"],
    );
  }
}
