import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
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
              body: const Center(
                child: Text('My Trips'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.go(PageName.newTripRoute);
                },
                backgroundColor: MyColors.lightPrimary,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: MyColors.primary,
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
