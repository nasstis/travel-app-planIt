class CityEntity {
  String cityId;
  String name;
  String description;
  String continent;
  String country;
  List<String> pictures;
  double latitude;
  double longitude;

  CityEntity({
    required this.cityId,
    required this.name,
    required this.description,
    required this.continent,
    required this.country,
    required this.pictures,
    required this.latitude,
    required this.longitude,
  });

  Map<String, Object?> toDocument() {
    return {
      'cityId': cityId,
      'name': name,
      'description': description,
      'continent': continent,
      'country': country,
      'pictures': pictures,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static CityEntity fromDocument(Map<String, dynamic> doc) {
    return CityEntity(
      cityId: doc['cityId'],
      name: doc['name'],
      description: doc['description'],
      continent: doc['continent'],
      country: doc['country'],
      pictures: doc['pictures'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
    );
  }
}
