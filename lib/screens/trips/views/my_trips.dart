import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Scaffold(
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
      ),
    );
  }
}
