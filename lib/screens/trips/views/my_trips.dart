import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/components/delete_dialog.dart';
import 'package:travel_app/screens/trips/components/trip_card.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: BlocBuilder<GetTripsBloc, GetTripsState>(
        builder: (context, state) {
          if (state is GetTripsSuccess) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.primary,
                title: const Text(
                  'Your trips',
                  style: TextStyle(
                    color: MyColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: state.trips.isEmpty
                  ? Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Text(
                          'It looks like you haven\'t \n created any trips yet',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: state.trips.length,
                        itemBuilder: (context, index) => Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Dismissible(
                              key: Key(state.trips[index].id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteConfirmDialog(
                                      title: "Confirm deletion",
                                      content:
                                          "Are you sure you want to delete ${state.trips[index].name} trip?",
                                      action: 'Delete',
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) {
                                context.read<TripBloc>().add(
                                      DeleteTrip(state.trips[index].id),
                                    );
                              },
                              background: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Icon(
                                          Icons.delete,
                                          size: 35,
                                          color: MyColors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  context.push(
                                    PageName.tripRoute,
                                    extra: {
                                      'trip': state.trips[index],
                                      'tag':
                                          '${state.trips[index].photoUrl}$index',
                                    },
                                  );
                                },
                                child: TripCard(
                                    index: index, trip: state.trips[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.go(PageName.newTripRoute);
                },
                backgroundColor: MyColors.primary,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: MyColors.white,
                ),
              ),
            );
          } else if (state is GetTripsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetTripsFailure) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }
          return const Center();
        },
      ),
    );
  }
}
