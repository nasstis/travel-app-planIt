import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/components/delete_dialog.dart';
import 'package:travel_app/screens/trips/components/place_card.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:trip_repository/trip_repository.dart';

class PlacesListView extends StatefulWidget {
  const PlacesListView({
    super.key,
    required this.trip,
  });

  final Trip trip;

  @override
  State<PlacesListView> createState() => _PlacesListViewState();
}

class _PlacesListViewState extends State<PlacesListView> {
  bool refreshRequired = false;

  Future<void> removePlaceFromTrip(BuildContext context, Place place) async {
    bool? removeItem = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteConfirmDialog(
        title: 'Confirm removing',
        content: 'Are you sure you want to remove this place from your trip?',
        action: 'Remove',
      ),
    );

    if (removeItem != null && removeItem) {
      if (context.mounted) {
        context.read<TripBloc>().add(
              RemovePlaceFromTrip(
                  tripId: widget.trip.id,
                  places: widget.trip.places,
                  placeId: place.id),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripBloc, TripState>(
          listener: (context, state) {
            if (state is RemovePlaceFromTripSuccess) {
              context
                  .read<GetTripsBloc>()
                  .add(GetTripByIdRequired(widget.trip.id));
            }
          },
        ),
        BlocListener<GetTripsBloc, GetTripsState>(
          listener: (context, state) {
            if (state is GetTripByIdLoading) {
              setState(() {
                refreshRequired = true;
              });
            }
            if (state is GetTripByIdSuccess) {
              context.go(PageName.tripRoute, extra: {
                'trip': state.trip,
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Place successfully removed from the trip!')));
              setState(() {
                refreshRequired = false;
              });
            }
            if (state is GetTripByIdFailure) {
              setState(() {
                refreshRequired = false;
              });
            }
          },
        ),
      ],
      child: SizedBox(
        height: 415,
        child: refreshRequired
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.trip.places.length,
                itemBuilder: (context, index) {
                  Place place = widget.trip.places[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            context.push('/trips/trip/place', extra: place);
                          },
                          child: PlaceCard(
                            place: place,
                            onRemovePlaceTap: () {
                              removePlaceFromTrip(context, place);
                            },
                          )),
                    ),
                  );
                }),
      ),
    );
  }
}
