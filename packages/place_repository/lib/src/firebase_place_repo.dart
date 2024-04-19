import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:place_repository/place_repository.dart';

class FirebasePlaceRepo extends PlaceRepo {
  final placesCollection = FirebaseFirestore.instance.collection('places');

  @override
  Future<List<Place>> getPlaces(String cityId) async {
    final placesQuery = await placesCollection
        .where(
          'cityId',
          isEqualTo: cityId,
        )
        .get();

    final places = await Future.wait(placesQuery.docs
        .map(
          (e) => Place.fromEntity(
            PlaceEntity.fromDocument(e.data()),
          ),
        )
        .toList());

    return places;
  }

  @override
  Future<List<Place>?> getSearchResult({required String qSearch}) async {
    String newVal =
        qSearch[0].toUpperCase() + qSearch.substring(1).toLowerCase();
    final place = await placesCollection
        .where('name', isGreaterThanOrEqualTo: newVal)
        .where('name', isLessThanOrEqualTo: '$newVal\uf8ff')
        .get();

    List<Place> places = await Future.wait(place.docs
        .map(
          (e) => Place.fromEntity(
            PlaceEntity.fromDocument(e.data()),
          ),
        )
        .toList());

    return places;
  }
}
