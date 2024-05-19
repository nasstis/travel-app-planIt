import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';

import 'package:travel_app/screens/place/components/gallery.dart';
import 'package:travel_app/screens/place/components/modal_bottom_sheet.dart';
import 'package:travel_app/screens/place/components/place_info.dart';
import 'package:travel_app/screens/place/components/reviews.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/utils/components/is_open_text.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:trip_repository/trip_repository.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final tripRepo = FirebaseTripRepo();
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: MyColors.light,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => GetTripsBloc(tripRepo)
                          ..add(const GetTripsRequired()),
                      ),
                      BlocProvider(
                        create: (context) => TripBloc(
                            tripRepo, context.read<AuthBloc>().userRepository),
                      ),
                    ],
                    child: ModalBottomSheet(
                      placeId: place.id,
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.add,
              size: 33,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: CachedNetworkImage(
                      imageUrl: place.photos[0],
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.4),
                      colorBlendMode: BlendMode.srcOver,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: place.name.length >= 30
                        ? MediaQuery.of(context).size.height * 0.14
                        : MediaQuery.of(context).size.height * 0.17,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            place.name,
                            style: const TextStyle(
                                fontSize: 33,
                                color: MyColors.light,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: MyColors.light,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  place.cityName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: MyColors.light,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5),
                            if (place.openingHours != null)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  IsOpenText(
                                    openingHours: place.openingHours!,
                                    width: 80,
                                    height: 20,
                                    iconSize: 12,
                                    fontSize: 12,
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(children: [
                  PlaceInfo(
                    place: place,
                  ),
                  Gallery(
                    images: place.photos,
                  ),
                  Reviews(
                    reviews: place.reviews,
                    placeRating: place.rating!,
                    ratingCount: place.ratingCount,
                  ),
                ]),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.36,
              right: MediaQuery.of(context).size.width * 0.07,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyThemeMode.isDark ? MyColors.dark : MyColors.light,
                  ),
                  child: const TabBar(
                    tabs: [
                      Text('Info'),
                      Text('Gallery'),
                      Text('Reviews'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
