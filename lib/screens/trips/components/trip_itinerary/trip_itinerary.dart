import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/itinerary_view.dart';
import 'package:travel_app/utils/constants/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<DateTime> days =
        getListOfDaysInDateRange(widget.trip.startDate, widget.trip.endDate);
    return BlocBuilder<TripCalendarBloc, TripCalendarState>(
      builder: (context, state) {
        if (state is GetTripCalendarSuccess) {
          int initialIndex = state.index;
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
                          color: tripCalendar
                                  .isDayFinished[days[index].toString()]!
                              ? MyColors.green.withOpacity(0.1)
                              : MyColors.light,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat.MMMd().format(days[index]).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: tripCalendar
                                      .isDayFinished[days[index].toString()]!
                                  ? MyColors.grey.withOpacity(0.5)
                                  : MyColors.grey,
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
                    return ItineraryView(
                      date: days[index],
                      places: tripCalendar.places[days[index].toString()]!,
                      trip: widget.trip,
                      seePlaces: index == initialIndex,
                      index: index,
                      isFinished:
                          tripCalendar.isDayFinished[days[index].toString()]!,
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
