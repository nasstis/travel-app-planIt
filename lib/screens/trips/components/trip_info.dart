import 'package:flutter/material.dart';
import 'package:travel_app/screens/trips/components/places_list_view.dart';
import 'package:trip_repository/trip_repository.dart';

class TripInfo extends StatelessWidget {
  const TripInfo({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Places to go (${trip.places.length})',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                weight: 10,
                size: 26,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        trip.places.isEmpty
            ? Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'There are no places yet... \n Start planning your trip by adding the first one!',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add place'),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            : PlacesListView(trip: trip),
        const SizedBox(height: 20),
        const Text(
          'Recommendations',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
