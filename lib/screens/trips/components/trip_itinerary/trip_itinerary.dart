import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/places_itinerary.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/helpers/get_list_of_days.dart';
import 'package:trip_repository/trip_repository.dart';

class Itinerary extends StatefulWidget {
  const Itinerary({super.key, required this.trip});

  final Trip trip;

  @override
  State<Itinerary> createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  @override
  Widget build(BuildContext context) {
    final List<DateTime> days =
        getListOfDaysInDateRange(widget.trip.startDate, widget.trip.endDate);
    return BlocBuilder<TripCalendarBloc, TripCalendarState>(
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
                    final sortedPlacesMap = Map.fromEntries(
                        tripCalendar.places.entries.toList()
                          ..sort((e1, e2) => e1.key.compareTo(e2.key)));

                    final List places = sortedPlacesMap.values.toList()[index];

                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
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
                                          icon: const Icon(
                                              Icons.arrow_drop_down)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const FaIcon(
                                            FontAwesomeIcons.solidMap,
                                            size: 16,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 16,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              places.isEmpty
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 60),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: const Text(
                                            'Build your itinerary by adding places from your saves',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ElevatedButton(
                                          onPressed: () {
                                            context.push(
                                                PageName.addPlaceToItinerary,
                                                extra: {
                                                  'trip': widget.trip,
                                                  'date': days[index],
                                                }).then((value) {
                                              setState(() {
                                                context
                                                    .read<TripCalendarBloc>()
                                                    .add(GetTripCalendar(
                                                        widget.trip.id));
                                              });
                                            });
                                          },
                                          child: const Text('Add place'),
                                        ),
                                        const SizedBox(height: 60),
                                      ],
                                    )
                                  : PlacesItineraryView(
                                      places: places,
                                      trip: widget.trip,
                                      date: days[index],
                                    ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        }
        if (state is GetTripCalendarLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center();
      },
    );
  }
}
