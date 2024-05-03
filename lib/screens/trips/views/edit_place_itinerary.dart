import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';

class EditPlacesItinerary extends StatefulWidget {
  const EditPlacesItinerary({super.key, required this.extra});

  final Map<String, dynamic> extra;

  @override
  State<EditPlacesItinerary> createState() => _EditPlacesItineraryState();
}

class _EditPlacesItineraryState extends State<EditPlacesItinerary> {
  bool editRequired = false;
  @override
  Widget build(BuildContext context) {
    final List places = widget.extra['places'];
    final String tripId = widget.extra['tripId'];
    final DateTime date = widget.extra['date'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.light,
        title: Text(
          DateFormat.MMMMd().format(date).toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocListener<TripCalendarBloc, TripCalendarState>(
        listener: (context, state) {
          if (state is EditItinerarySuccess) {
            setState(() {
              editRequired = false;
            });
            context.pop();
          }
          if (state is EditItineraryLoading) {
            setState(() {
              editRequired = true;
            });
          }
          if (state is EditItineraryFailure) {
            setState(() {
              editRequired = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Something went wrong...')));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            places.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'There is nothing to edit here.\n Try adding some places first.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ReorderableListView.builder(
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final temp = places[oldIndex];
                        places.removeAt(oldIndex);
                        places.insert(newIndex, temp);
                      },
                      itemCount: places.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        key: Key('$index'),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  places.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: MyColors.red,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                    places[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  leading: Container(
                                    width: 70,
                                    // height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      : null,
                                  visualDensity:
                                      const VisualDensity(vertical: 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.drag_handle),
                          ],
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 18, top: 10),
              child: ElevatedButton(
                onPressed: editRequired
                    ? null
                    : () {
                        context.read<TripCalendarBloc>().add(
                              EditItinerary(
                                  tripId: tripId,
                                  date: date.toString(),
                                  places: places),
                            );
                        context.read<RouteBloc>().add(
                              EditRoute(
                                tripId,
                                places
                                    .map((place) =>
                                        '${place.longitude},${place.latitude}')
                                    .toList(),
                                date.toString(),
                              ),
                            );
                      },
                child: editRequired
                    ? const CircularProgressIndicator()
                    : const Text('Save changes'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
