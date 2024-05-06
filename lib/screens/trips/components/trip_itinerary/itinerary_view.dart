import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/modal_bottom_sheet.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/places_itinerary.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:trip_repository/trip_repository.dart';

class ItineraryView extends StatefulWidget {
  const ItineraryView({
    super.key,
    required this.date,
    required this.places,
    required this.trip,
    required this.seePlaces,
    required this.index,
  });

  final DateTime date;
  final List places;
  final Trip trip;
  final bool seePlaces;
  final int index;

  @override
  State<ItineraryView> createState() => _ItineraryViewState();
}

class _ItineraryViewState extends State<ItineraryView> {
  late bool seePlaces;
  @override
  void initState() {
    seePlaces = widget.seePlaces;
    super.initState();
  }

  void editPlaceHandle(BuildContext context) {
    context.push(PageName.editPlacesItinerary, extra: {
      'places': widget.places,
      'tripId': widget.trip.id,
      'date': widget.date,
    }).then((value) {
      setState(() {
        context
            .read<TripCalendarBloc>()
            .add(GetTripCalendar(widget.trip.id, index: widget.index));
      });
    });
  }

  void addPlaceHandle(BuildContext context) {
    context.push(PageName.addPlaceToItinerary, extra: {
      'places':
          widget.trip.places.where((e) => !widget.places.contains(e)).toList(),
      'tripId': widget.trip.id,
      'date': widget.date,
      'allPlaces': widget.places,
    }).then((value) {
      setState(() {
        context.read<TripCalendarBloc>().add(
              GetTripCalendar(
                widget.trip.id,
                index: widget.index,
              ),
            );
      });
    });
  }

  void showMap(BuildContext context) {
    if (widget.places.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need to add some places to this itinerary first.'),
        ),
      );
    } else {
      context.push(PageName.itineraryMap, extra: {
        'places': widget.places,
        'tripId': widget.trip.id,
        'day': widget.date.toString(),
        'profile': 'walking',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${DateFormat.E().format(widget.date).toString()}, ${DateFormat.MMMMd().format(widget.date).toString()}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              seePlaces = !seePlaces;
                            });
                          },
                          icon: Icon(seePlaces
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down)),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return const ItineraryModalBottomSheet();
                        },
                      ).then((value) {
                        if (value == 'Edit') editPlaceHandle(context);
                        if (value == 'Add') addPlaceHandle(context);
                        if (value == 'Map') showMap(context);
                      });
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                ],
              ),
              if (seePlaces)
                widget.places.isEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: 60),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Text(
                              'Build your itinerary by adding places from your saves',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              addPlaceHandle(context);
                            },
                            child: const Text('Add place'),
                          ),
                          const SizedBox(height: 60),
                        ],
                      )
                    : PlacesItineraryView(
                        places: widget.places,
                        trip: widget.trip,
                        date: widget.date,
                        index: widget.index,
                      ),
            ],
          ),
        ));
  }
}
