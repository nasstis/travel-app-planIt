import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:trip_repository/trip_repository.dart';

class SearchPlaceResults extends StatelessWidget {
  const SearchPlaceResults({
    super.key,
    required this.places,
    required this.trip,
  });

  final List<Place>? places;
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    if (places == null || places!.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          const Center(
            child: Text('There is no such place yet...'),
          ),
        ],
      );
    } else {
      return BlocListener<TripBloc, TripState>(
        listener: (context, state) {
          if (state is AddPlaceToTripSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Place successfully added to trip!')));
            context.go(PageName.tripRoute, extra: {'trip': state.trip});
          }
        },
        child: Expanded(
          child: SizedBox(
            height: 500,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: places!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          context.push(PageName.placeRouteFromTrip,
                              extra: places![index]);
                        },
                        title: Text(
                          places![index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MyColors.darkPrimary,
                          ),
                        ),
                        subtitle: Text(
                          places![index].cityName,
                          style: const TextStyle(
                            fontSize: 13,
                            color: MyColors.darkPrimary,
                          ),
                        ),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  places![index].photos[0]),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<TripBloc>().add(
                                  AddPlaceToTrip(
                                      tripId: trip.id,
                                      places: trip.places,
                                      placeId: places![index].id),
                                );
                          },
                          icon: const Icon(
                            Icons.add,
                            weight: 10,
                            color: MyColors.darkPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                }),
          ),
        ),
      );
    }
  }
}
