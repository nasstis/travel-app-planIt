import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:city_repository/city_repository.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/blocs/user_history_bloc/user_history_bloc.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/views/add_place_itinerary.dart';
import 'package:travel_app/screens/trips/views/add_place_search.dart';
import 'package:travel_app/screens/trips/views/edit_place_itinerary.dart';
import 'package:travel_app/screens/trips/views/edit_trip.dart';
import 'package:travel_app/screens/trips/views/itinerary_map.dart';
import 'package:travel_app/screens/trips/views/itinerary_steps_map.dart';
import 'package:travel_app/screens/trips/views/trip_map_screen.dart';
import 'package:travel_app/screens/trips/views/trip_view.dart';
import 'package:trip_repository/trip_repository.dart';

import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/views/welcome_screen.dart';
import 'package:travel_app/screens/city/views/city_detail_screen.dart';
import 'package:travel_app/screens/city/views/map_screen.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/screens/home/views/home_screen.dart';
import 'package:travel_app/screens/place/components/full_screen_image.dart';
import 'package:travel_app/screens/search/views/new_trip_search.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/views/my_trips.dart';
import 'package:travel_app/screens/trips/views/new_trip.dart';
import 'package:travel_app/screens/place/views/place_screen.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/screens/search/views/search_screen.dart';
import 'package:travel_app/screens/splash/views/splash_screen.dart';
import 'package:travel_app/utils/components/bottom_nav_bar.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:user_repository/user_repository.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final FirebaseCityRepo _firebaseCityRepo = FirebaseCityRepo();
final FirebasePlaceRepo _firebasePlaceRepo = FirebasePlaceRepo();
final FirebaseTripRepo _firebaseTripRepo = FirebaseTripRepo();
final RouteRepository _routeRepository = RouteRepository();
final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

GoRouter router(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: PageName.initRoute,
    redirect: (context, state) {
      if (authBloc.state.status == AuthStatus.unknown) {
        return PageName.initRoute;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: PageName.initRoute,
        builder: (context, state) => BlocProvider<AuthBloc>.value(
          value: BlocProvider.of<AuthBloc>(context),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: PageName.welcomeRoute,
        builder: (context, state) => const WelcomeScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: PageName.homeRoute,
                  builder: (context, state) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => SignInBloc(
                                context.read<AuthBloc>().userRepository),
                          ),
                          BlocProvider(
                            create: (context) =>
                                GetCitiesBloc(_firebaseCityRepo)
                                  ..add(GetCities()),
                          ),
                          BlocProvider(
                            create: (context) => UserHistoryBloc(
                                _firebaseUserRepository, _firebaseCityRepo),
                          ),
                        ],
                        child: const HomeScreen(),
                      ),
                  routes: <RouteBase>[
                    GoRoute(
                      path: PageName.cityPathName,
                      builder: (context, state) => BlocProvider(
                        create: (context) => UserHistoryBloc(
                            _firebaseUserRepository, _firebaseCityRepo),
                        child: CityDetailScreen(city: state.extra as City),
                      ),
                    ),
                    GoRoute(
                      path: PageName.placePathName,
                      builder: (context, state) =>
                          PlaceScreen(place: state.extra as Place),
                    ),
                    GoRoute(
                      path: PageName.mapPathName,
                      builder: (context, state) =>
                          MapScreen(city: state.extra as City),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PageName.searchRoute,
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      SearchBloc(_firebaseCityRepo, _firebasePlaceRepo),
                  child: const SearchScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PageName.tripsRoute,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetTripsBloc(_firebaseTripRepo)
                        ..add(const GetTripsRequired()),
                    ),
                    BlocProvider(
                      create: (context) => TripBloc(_firebaseTripRepo),
                    ),
                  ],
                  child: const MyTrips(),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: PageName.newTripPathName,
                    builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => TripBloc(_firebaseTripRepo),
                        ),
                        BlocProvider(
                          create: (context) => GetTripsBloc(_firebaseTripRepo),
                        ),
                      ],
                      child: const NewTrip(),
                    ),
                  ),
                  GoRoute(
                      path: PageName.tripPathName,
                      builder: (context, state) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    TripBloc(_firebaseTripRepo),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    GetTripsBloc(_firebaseTripRepo),
                              ),
                            ],
                            child: TripView(
                              extra: state.extra as Map<String, dynamic>?,
                            ),
                          ),
                      routes: [
                        GoRoute(
                          path: PageName.placePathName,
                          builder: (context, state) =>
                              PlaceScreen(place: state.extra as Place),
                        ),
                      ]),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: PageName.galleryRoute,
        builder: (context, state) =>
            FullScreenImage(extra: state.extra as Map<String, dynamic>?),
      ),
      GoRoute(
        path: PageName.newTripSearchRoute,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              SearchBloc(_firebaseCityRepo, _firebasePlaceRepo),
          child: const NewTripSearch(),
        ),
      ),
      GoRoute(
        path: PageName.editTripRoue,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TripBloc(_firebaseTripRepo),
            ),
            BlocProvider(
              create: (context) => GetTripsBloc(_firebaseTripRepo),
            ),
          ],
          child: EditTrip(trip: state.extra as Trip),
        ),
      ),
      GoRoute(
          path: PageName.addPlaceSearchRoute,
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        SearchBloc(_firebaseCityRepo, _firebasePlaceRepo),
                  ),
                  BlocProvider(
                    create: (context) => TripBloc(_firebaseTripRepo)
                      ..add(GetCityPlaces((state.extra as Trip).cityId)),
                  ),
                ],
                child: AddPlaceSearch(
                  trip: state.extra as Trip,
                ),
              ),
          routes: [
            GoRoute(
              path: PageName.placePathName,
              builder: (context, state) =>
                  PlaceScreen(place: state.extra as Place),
            ),
          ]),
      GoRoute(
        path: PageName.addPlaceToItinerary,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                return TripCalendarBloc(_firebaseTripRepo);
              },
            ),
            BlocProvider(
              create: (context) => RouteBloc(_routeRepository),
            ),
          ],
          child: AddPlaceItinerary(
            extra: state.extra as Map<String, dynamic>,
          ),
        ),
      ),
      GoRoute(
        path: PageName.editPlacesItinerary,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                return TripCalendarBloc(_firebaseTripRepo);
              },
            ),
            BlocProvider(
              create: (context) => RouteBloc(_routeRepository),
            ),
          ],
          child: EditPlacesItinerary(
            extra: state.extra as Map<String, dynamic>,
          ),
        ),
      ),
      GoRoute(
          path: PageName.tripMap,
          builder: (context, state) =>
              TripMapScreen(places: state.extra as List)),
      GoRoute(
          path: PageName.itineraryMap,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            if (extra['places'].length <= 1) {
              return ItineraryMap(
                places: extra['places'],
                hasOnePlace: true,
              );
            } else {
              return BlocProvider(
                create: (context) => RouteBloc(_routeRepository)
                  ..add(GetRoute(
                      extra['tripId'], extra['day'], extra['profile'])),
                child: ItineraryMap(
                  places: extra['places'],
                  hasOnePlace: false,
                ),
              );
            }
          }),
      GoRoute(
          path: PageName.itineraryStepsMap,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => RouteBloc(_routeRepository),
              child: ItineraryStepsMap(
                places: extra['places'],
                tripId: extra['tripId'],
                day: extra['day'],
                startingRoute: extra['startingRoute'],
                startingLocation: extra['startingLocation'],
                profile: extra['profile'],
              ),
            );
          }),
    ],
  );
}
