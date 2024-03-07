class CityEntity {
  String cityId;
  String name;
  String description;
  String continent;
  String country;
  String picture;
  double latitude;
  double longitude;
  String officialLanguage;
  String timeZone;
  String climate;
  String currency;

  CityEntity(
      {required this.cityId,
      required this.name,
      required this.description,
      required this.continent,
      required this.country,
      required this.picture,
      required this.latitude,
      required this.longitude,
      required this.officialLanguage,
      required this.timeZone,
      required this.climate,
      required this.currency});

  Map<String, Object?> toDocument() {
    return {
      'cityId': cityId,
      'name': name,
      'description': description,
      'continent': continent,
      'country': country,
      'picture': picture,
      'latitude': latitude,
      'longitude': longitude,
      'officialLanguage': officialLanguage,
      'timeZone': timeZone,
      'climate': climate,
      'currency': currency,
    };
  }

  static CityEntity fromDocument(Map<String, dynamic> doc) {
    return CityEntity(
      cityId: doc['cityId'],
      name: doc['name'],
      description: doc['description'],
      continent: doc['continent'],
      country: doc['country'],
      picture: doc['picture'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      officialLanguage: doc['officialLanguage'],
      timeZone: doc['timeZone'],
      climate: doc['climate'],
      currency: doc['currency'],
    );
  }
}
