import 'dart:developer';

import 'package:city_repository/city_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCityRepo implements CityRepo {
  final cityColection = FirebaseFirestore.instance.collection('cities');

  Future<List<City>> getCities() async {
    try {
      return await cityColection.get().then((value) => value.docs
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
}
