import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: state.trips.length,
                  itemBuilder: (context, index) => Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () {
                          context.push(
                            PageName.tripRoute,
                            extra: {
                              'trip': state.trips[index],
                              'tag': '${state.trips[index].photoUrl}$index',
                            },
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: '${state.trips[index].photoUrl}$index',
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.96,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          state.trips[index].photoUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: MyColors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.96,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.trips[index].name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 22,
                                            color: Color(0xFF313131),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${DateFormat.MMMd().format(state.trips[index].startDate).toString()} - ${DateFormat.MMMd().format(state.trips[index].endDate).toString()}',
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
