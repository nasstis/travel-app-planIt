import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_header.dart';
import 'package:travel_app/screens/trips/components/trip_info.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/trip_itinerary.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:trip_repository/trip_repository.dart';

class TripView extends StatelessWidget {
  const TripView({
    super.key,
    this.extra,
  });

  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    final Trip trip = extra!['trip'];
    final String? tag = extra!['tag'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: MyColors.light,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(PageName.editTripRoue, extra: trip);
            },
            icon: const Icon(
              Icons.edit,
              size: 20,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          tag != null
              ? Hero(
                  tag: tag,
                  child: TripHeader(
                    photoUrl: trip.photoUrl,
                    name: trip.name,
                    startDate: trip.startDate,
                    endDate: trip.endDate,
                  ))
              : TripHeader(
                  photoUrl: trip.photoUrl,
                  name: trip.name,
                  startDate: trip.startDate,
                  endDate: trip.endDate,
                ),
          Positioned(
            top: 200,
            child: Container(
              height: MediaQuery.of(context).size.height - 185,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyThemeMode.isDark ? MyColors.darkDark : Colors.white),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      dividerColor: Colors.transparent,
                      tabs: [
                        Text('Info'),
                        Text('Itinerary'),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height - 230,
                      child: TabBarView(
                        children: [
                          TripInfo(trip: trip),
                          BlocProvider(
                            create: (context) => TripCalendarBloc(
                                FirebaseTripRepo(),
                                context.read<AuthBloc>().userRepository)
                              ..add(GetTripCalendar(trip.id)),
                            child: Itinerary(
                              trip: trip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            context.push(PageName.tripMap, extra: trip.places);
          },
          backgroundColor: MyColors.primary,
          shape: const CircleBorder(),
          child: const FaIcon(
            FontAwesomeIcons.solidMap,
            color: MyColors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
