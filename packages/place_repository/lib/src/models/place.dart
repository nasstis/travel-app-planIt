import 'package:city_repository/city_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:place_repository/place_repository.dart';

class Place extends Equatable {
  final String id;
  final String name;
  final List<dynamic> types;
  final double latitude;
  final double longitude;
  final String address;
  final List reviews;
  final int ratingCount;
  final List<dynamic> photos;
  final String cityId;
  final String cityName;
  final String? description;
  final String? businessStatus;
  final double? rating;
  final bool? goodForChildren;
  final List<dynamic>? openingHours;
  final bool? restroom;

  const Place({
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
    required this.cityName,
    this.description,
    this.businessStatus,
    this.rating,
    this.goodForChildren,
    this.openingHours,
    this.restroom,
  });

  // PlaceEntity toEntity() {
  //   return PlaceEntity(
  //     id: id,
  //     name: name,
  //     types: types,
  //     description: description,
  //     pictures: pictures,
  //     latitude: latitude,
  //     longitude: longitude,
  //     cityId: cityId,
  //     address: address,
  //   );
  // }

  static Future<Place> fromEntity(PlaceEntity entity) async {
    return Place(
      id: entity.id,
      name: entity.name,
      types: entity.types,
      latitude: entity.latitude,
      longitude: entity.longitude,
      address: entity.address,
      reviews: entity.reviews,
      ratingCount: entity.ratingCount,
      photos: entity.photos,
      cityId: entity.cityId,
      cityName: await FirebaseCityRepo().getCityName(entity.cityId),
      description: entity.description,
      businessStatus: entity.businessStatus,
      rating: entity.rating,
      goodForChildren: entity.goodForChildren,
      openingHours: entity.openingHours,
      restroom: entity.restroom,
    );
  }

  @override
  List<Object?> get props => [id];
}
