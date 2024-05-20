import 'dart:developer';

import 'package:city_repository/city_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCityRepo implements CityRepo {
  final cityCollection = FirebaseFirestore.instance.collection('cities');

  final cityQuery =
      FirebaseFirestore.instance.collection('cities').withConverter<City>(
            fromFirestore: (snapshot, _) =>
                City.fromEntity(CityEntity.fromDocument(snapshot.data()!)),
            toFirestore: (city, _) => city.toEntity().toDocument(),
          );

  @override
  Future<List<City>> getCities() async {
    try {
      return await cityCollection.limit(10).get().then((value) => value.docs
          .map(
            (e) => City.fromEntity(
              CityEntity.fromDocument(e.data()),
            ),
          )
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<City>> getCitiesById(List<String> id) async {
    final List<City> cities = [];
    for (var cityId in id) {
      await cityCollection
          .where('cityId', isEqualTo: cityId)
          .get()
          .then((value) {
        cities.add(City.fromEntity(
          CityEntity.fromDocument(value.docs.first.data()),
        ));
      });
    }
    return cities;
  }

  @override
  Future<List<City>?> getSearchResult({required String qSearch}) async {
    String newVal =
        qSearch[0].toUpperCase() + qSearch.substring(1).toLowerCase();
    final city = await cityCollection
        .where('name', isGreaterThanOrEqualTo: newVal)
        .where('name', isLessThanOrEqualTo: '$newVal\uf8ff')
        .get();

    List<City> cities = city.docs
        .map(
          (e) => City.fromEntity(
            CityEntity.fromDocument(e.data()),
          ),
        )
        .toList();
    return cities;
  }

  @override
  Future<String> getCityName(String cityId) async {
    String cityName = await cityCollection
        .doc(cityId)
        .get()
        .then((doc) => doc.data()!['name']);
    return cityName;
  }
}
