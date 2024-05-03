import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';

class AddPlaceItinerary extends StatefulWidget {
  const AddPlaceItinerary({
    super.key,
    required this.extra,
  });

  final Map<String, dynamic>? extra;

  @override
  State<AddPlaceItinerary> createState() => _AddPlaceItineraryState();
}

class _AddPlaceItineraryState extends State<AddPlaceItinerary> {
  late List<bool> selectedCheckboxes;
  bool addPlacesRequired = false;
  late final DateTime date;
  late final String tripId;
  late final List places;
  List allPlaces = [];

  @override
  void initState() {
    date = widget.extra!['date'];
    tripId = widget.extra!['tripId'];
    places = widget.extra!['places'];
    allPlaces = widget.extra!['allPlaces'];
    selectedCheckboxes = List.generate(places.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<TripCalendarBloc, TripCalendarState>(
        listener: (context, state) {
          if (state is AddPlacesToItineraryFailure) {
            setState(() {
              addPlacesRequired = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is AddPlacesToItinerarySuccess) {
            setState(() {
              addPlacesRequired = false;
            });
            context.pop();
          }
          if (state is AddPlacesToItineraryLoading) {
            setState(() {
              addPlacesRequired = true;
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedCheckboxes.length,
                itemBuilder: (context, index) => Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              places[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            leading: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      places[index].photos[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            subtitle: places[index].description != null
                                ? Text(
                                    places[index].description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  )
                                : null,
                            isThreeLine: true,
                            visualDensity: const VisualDensity(vertical: 3),
                          ),
                        ),
                      ),
                      Checkbox(
                        value: selectedCheckboxes[index],
                        onChanged: (status) {
                          setState(() {
                            selectedCheckboxes[index] = status!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: addPlacesRequired
                    ? null
                    : () {
                        final List selectedPlacesId = [];
                        int index = 0;
                        for (var checkbox in selectedCheckboxes) {
                          if (checkbox) {
                            selectedPlacesId.add(places[index].id);
                            allPlaces.add(places[index]);
                          }
                          index++;
                        }
                        context.read<TripCalendarBloc>().add(
                              AddPlacesToItinerary(
                                  selectedPlaces: selectedPlacesId,
                                  date: date.toString(),
                                  tripId: tripId),
                            );
                        context.read<RouteBloc>().add(
                              CreateRoute(
                                tripId,
                                allPlaces
                                    .map((place) =>
                                        '${place.longitude},${place.latitude}')
                                    .toList(),
                                date.toString(),
                              ),
                            );
                      },
                child: addPlacesRequired
                    ? const CircularProgressIndicator()
                    : const Text('Add places to Itinerary'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
