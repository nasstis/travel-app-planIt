import 'package:place_repository/place_repository.dart';

class PlaceEntity {
  String id;
  String name;
  List<dynamic> types;
  double latitude;
  double longitude;
  String address;
  List reviews;
  int ratingCount;
  List<dynamic> photos;
  String cityId;
  String? description;
  String? businessStatus;
  double? rating;
  bool? goodForChildren;
  List<dynamic>? openingHours;
  bool? restroom;

  PlaceEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.reviews,
    required this.ratingCount,
    required this.photos,
    required this.cityId,
    this.description,
    this.businessStatus,
    this.rating,
    this.goodForChildren,
    this.openingHours,
    this.restroom,
  });

  // Map<String, Object?> toDocument() {
  //   return {
  //     "id": id,
  //     "name": name,
  //     "description": description,
  //     "pictures": pictures,
  //     "latitude": latitude,
  //     "longitude": longitude,
  //     "cityId": cityId,
  //     "address": address,
  //   };
  // }

  static PlaceEntity fromDocument(Map<String, dynamic> doc) {
    return PlaceEntity(
      id: doc["id"],
      name: doc["name"],
      types: doc["types"]
          .where((type) => type != 'tourist_attraction')
          .map((type) {
        return type.replaceAll('_', ' ');
      }).toList(),
      latitude: doc["latitude"],
      longitude: doc["longitude"],
      address: doc["address"],
      reviews: doc["reviews"]
          .map(
            (review) => Review.fromEntity(
              ReviewEntity.fromDocument(review),
            ),
          )
          .toList(),
      ratingCount: doc["ratingCount"],
      photos: doc["photos"],
      cityId: doc["cityId"],
      description: doc["description"],
      businessStatus: doc["businessStatus"],
      rating: doc["rating"].toDouble(),
      goodForChildren: doc["goodForChildren"],
      openingHours: doc["openingHours"],
      restroom: doc["restroom"],
    );
  }
}
