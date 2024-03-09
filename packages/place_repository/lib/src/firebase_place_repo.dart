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

    List<Place> places = placesQuery.docs
        .map(
          (e) => Place.fromEntity(
            PlaceEntity.fromDocument(e.data()),
          ),
        )
        .toList();
    return places;
  }
}
