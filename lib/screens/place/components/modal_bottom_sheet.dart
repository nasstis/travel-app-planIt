import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({
    super.key,
    required this.placeId,
  });

  final String placeId;

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  bool addPlaceRequired = false;
  int tripIndex = 100;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MyColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add to a Trip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GetTripsBloc, GetTripsState>(
              builder: (context, state) {
                if (state is GetTripsSuccess) {
                  return SizedBox(
                    height:
                        state.trips.length <= 4 ? state.trips.length * 72 : 290,
                    child: ListView.builder(
                        itemCount: state.trips.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              state.trips[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${state.trips[index].places.length} places',
                              style: const TextStyle(
                                fontSize: 13,
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
                                      state.trips[index].photoUrl),
                                ),
                              ),
                            ),
                            trailing: BlocListener<TripBloc, TripState>(
                              listener: (context, state) {
                                if (state is AddPlaceToTripSuccess) {
                                  setState(() {
                                    addPlaceRequired = false;
                                  });
                                  if (index == tripIndex) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Place added to the trip!')));
                                  }
                                }
                                if (state is AddPlaceToTripLoading) {
                                  setState(() {
                                    addPlaceRequired = true;
                                  });
                                }
                                if (state is AddPlaceToTripFailure) {
                                  setState(() {
                                    addPlaceRequired = false;
                                  });
                                }
                              },
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    tripIndex = index;
                                  });
                                  context.read<TripBloc>().add(
                                        AddPlaceToTrip(
                                            tripId: state.trips[index].id,
                                            places: state.trips[index].places,
                                            placeId: widget.placeId),
                                      );
                                },
                                icon: addPlaceRequired && index == tripIndex
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator())
                                    : const Icon(Icons.add),
                              ),
                            ),
                          );
                        }),
                  );
                }
                return const Center();
              },
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Create new Trip'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Done'),
                ),
              ],
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
