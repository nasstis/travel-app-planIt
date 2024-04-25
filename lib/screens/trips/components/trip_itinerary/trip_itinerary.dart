import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/itinerary_view.dart';
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
  final ItemScrollController itemScrollController = ItemScrollController();
  int initialIndex = 0;

  void editPlaceHandle(
      BuildContext context, List places, DateTime date, int index) {
    context.push(PageName.editPlacesItinerary, extra: {
      'places': places,
      'tripId': widget.trip.id,
      'date': date,
    }).then((value) {
      setState(() {
        context.read<TripCalendarBloc>().add(GetTripCalendar(widget.trip.id));
        initialIndex = index;
      });
    });
  }

  void addPlaceHandle(
      BuildContext context, DateTime date, List places, int index) {
    context.push(PageName.addPlaceToItinerary, extra: {
      'places': widget.trip.places.where((e) => !places.contains(e)).toList(),
      'tripId': widget.trip.id,
      'date': date,
    }).then((value) {
      setState(() {
        context.read<TripCalendarBloc>().add(GetTripCalendar(widget.trip.id));
        initialIndex = index;
      });
    });
  }

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
                      onTap: () {
                        itemScrollController.scrollTo(
                            index: index,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOutCubic);
                      },
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
                child: ScrollablePositionedList.builder(
                  initialScrollIndex: initialIndex,
                  itemScrollController: itemScrollController,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final sortedPlacesMap = Map.fromEntries(
                        tripCalendar.places.entries.toList()
                          ..sort((e1, e2) => e1.key.compareTo(e2.key)));

                    final List places = sortedPlacesMap.values.toList()[index];

                    return ItineraryView(
                      date: days[index],
                      places: places,
                      trip: widget.trip,
                      seePlaces: index == initialIndex,
                      editPlace: () {
                        editPlaceHandle(context, places, days[index], index);
                      },
                      addPlace: () {
                        addPlaceHandle(context, days[index], places, index);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 100),
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
