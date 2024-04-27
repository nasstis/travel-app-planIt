import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/modal_bottom_sheet.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/places_itinerary.dart';
import 'package:trip_repository/trip_repository.dart';

class ItineraryView extends StatefulWidget {
  const ItineraryView({
    super.key,
    required this.date,
    required this.places,
    required this.trip,
    required this.editPlace,
    required this.addPlace,
    required this.seePlaces,
    required this.showMap,
  });

  final DateTime date;
  final List places;
  final Trip trip;
  final bool seePlaces;
  final void Function() editPlace;
  final void Function() addPlace;
  final void Function() showMap;

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
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ItineraryModalBottomSheet(
                            editPlace: widget.editPlace,
                            addPlace: widget.addPlace,
                            showMap: widget.showMap,
                          );
                        },
                      );
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
                            onPressed: widget.addPlace,
                            child: const Text('Add place'),
                          ),
                          const SizedBox(height: 60),
                        ],
                      )
                    : PlacesItineraryView(
                        places: widget.places,
                        trip: widget.trip,
                        date: widget.date,
                      ),
            ],
          ),
        ));
  }
}
