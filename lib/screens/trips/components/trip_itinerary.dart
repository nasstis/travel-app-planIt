import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/helpers/get_list_of_days.dart';
import 'package:trip_repository/trip_repository.dart';

class Itinerary extends StatelessWidget {
  const Itinerary({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> days =
        getListOfDaysInDateRange(trip.startDate, trip.endDate);
    return BlocBuilder<GetTripsBloc, GetTripsState>(
      builder: (context, state) {
        if (state is GetTripCalendarSuccess) {
          final TripCalendar tripCalendar = state.tripCalendar;
          return Column(
            children: [
              SizedBox(
                height: 55,
                child: ListView.builder(
                  itemCount: days.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          color: MyColors.light,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat.MMMd().format(days[index]).toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: MyColors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final List places =
                        tripCalendar.places.values.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: places.isEmpty
                          ? SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${DateFormat.E().format(days[index]).toString()}, ${DateFormat.MMMMd().format(days[index]).toString()}',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.arrow_drop_down))
                                    ],
                                  ),
                                  const SizedBox(height: 60),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: const Text(
                                      'Build your itinerary by adding places from your saves',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Add place'),
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              ),
                            )
                          : const Text('DHDHDH'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        }
        return const Center();
      },
    );
  }
}
