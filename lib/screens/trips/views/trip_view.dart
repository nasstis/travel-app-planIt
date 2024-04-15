import 'package:flutter/material.dart';
import 'package:travel_app/screens/trips/components/trip_header.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:trip_repository/trip_repository.dart';

class TripView extends StatelessWidget {
  const TripView({
    super.key,
    this.extra,
  });

  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    final Trip trip = extra!['trip'];
    final String? tag = extra!['tag'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: MyColors.light,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Add edit page
            },
            icon: const Icon(
              Icons.edit,
              size: 20,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              tag != null
                  ? Hero(
                      tag: tag,
                      child: TripHeader(
                        photoUrl: trip.photoUrl,
                        name: trip.name,
                        startDate: trip.startDate,
                        endDate: trip.endDate,
                      ))
                  : TripHeader(
                      photoUrl: trip.photoUrl,
                      name: trip.name,
                      startDate: trip.startDate,
                      endDate: trip.endDate,
                    ),
              Positioned(
                top: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height - 185,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          dividerColor: Colors.transparent,
                          tabs: [
                            Text('Info'),
                            Text('Itinerary'),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height - 230,
                          child: const TabBarView(
                            children: [
                              Text('Info'),
                              Text('Itinerary'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
