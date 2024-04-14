import 'package:flutter/material.dart';
import 'package:trip_repository/trip_repository.dart';

class TripView extends StatelessWidget {
  const TripView({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(trip.name),
    );
  }
}
