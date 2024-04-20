import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/components/delete_dialog.dart';
import 'package:travel_app/screens/trips/components/is_open_text.dart';
import 'package:travel_app/utils/constants/colors.dart';
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
        height: 395,
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
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            place.photos[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (place.openingHours != null)
                                    Positioned(
                                      top: 10,
                                      left: 5,
                                      child: IsOpenText(
                                          openingHours: place.openingHours!),
                                    ),
                                  Positioned(
                                      right: 0,
                                      top: -5,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            gradient: RadialGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.2),
                                                Colors.black.withOpacity(0.1),
                                                Colors.black.withOpacity(0),
                                              ],
                                            )),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: MyColors.light,
                                          ),
                                          onPressed: () async {
                                            bool? removeItem =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const DeleteConfirmDialog(
                                                title: 'Confirm removing',
                                                content:
                                                    'Are you sure you want to remove this place from your trip?',
                                                action: 'Remove',
                                              ),
                                            );

                                            if (removeItem != null &&
                                                removeItem) {
                                              if (context.mounted) {
                                                context.read<TripBloc>().add(
                                                      RemovePlaceFromTrip(
                                                          tripId:
                                                              widget.trip.id,
                                                          places: widget
                                                              .trip.places,
                                                          placeId: place.id),
                                                    );
                                              }
                                            }
                                          },
                                        ),
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      place.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    place.description == null
                                        ? const Text(
                                            'Oops! It looks like we couldn\'t find a description for this place',
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          )
                                        : Text(
                                            place.description!,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    const SizedBox(height: 7),
                                    Wrap(
                                      runSpacing: -6,
                                      children: List.generate(
                                        place.types.length > 2
                                            ? 2
                                            : place.types.length,
                                        (index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: Chip(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 0),
                                              label: Text(
                                                place.types[index],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
