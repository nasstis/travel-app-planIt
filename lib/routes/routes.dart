import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:city_repository/city_repository.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/trips/views/trip_view.dart';
import 'package:trip_repository/trip_repository.dart';

import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/views/welcome_screen.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/views/city_detail_screen.dart';
import 'package:travel_app/screens/city/views/map_screen.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/screens/home/views/home_screen.dart';
import 'package:travel_app/screens/place/components/full_screen_image.dart';
import 'package:travel_app/screens/search/views/new_trip_search.dart';
import 'package:travel_app/screens/trips/blocs/create_trip_bloc/create_trip_bloc.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/views/my_trips.dart';
import 'package:travel_app/screens/trips/views/new_trip.dart';
import 'package:travel_app/screens/place/views/place_screen.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/screens/search/views/search_screen.dart';
import 'package:travel_app/screens/splash/views/splash_screen.dart';
import 'package:travel_app/utils/components/bottom_nav_bar.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final FirebaseCityRepo _firebaseCityRepo = FirebaseCityRepo();
final FirebasePlaceRepo _firebasePlaceRepo = FirebasePlaceRepo();
final FirebaseTripRepo _firebaseTripRepo = FirebaseTripRepo();

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
                        ],
                        child: const HomeScreen(),
                      ),
                  routes: <RouteBase>[
                    GoRoute(
                      path: PageName.cityPathName,
                      builder: (context, state) => BlocProvider(
                        create: (context) => GetPlacesBloc(_firebasePlaceRepo),
                        child: CityDetailScreen(city: state.extra as City),
                      ),
                    ),
                    GoRoute(
                      path: PageName.placePathName,
                      builder: (context, state) => PlaceScreen(
                          extra: state.extra as Map<String, dynamic>?),
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
                  create: (context) => SearchBloc(_firebaseCityRepo),
                  child: const SearchScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PageName.tripsRoute,
                builder: (context, state) => BlocProvider(
                  create: (context) => GetTripsBloc(_firebaseTripRepo)
                    ..add(GetTripsRequired(null)),
                  child: const MyTrips(),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: PageName.newTripPathName,
                    builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              CreateTripBloc(_firebaseTripRepo),
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
                    builder: (context, state) => TripView(
                      extra: state.extra as Map<String, dynamic>?,
                    ),
                    // pageBuilder: (context, state) {
                    //   CustomTransitionPage(
                    //     child: TripView(
                    //       extra: state.extra as Map<String, dynamic>?,
                    //     ),
                    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    //     },
                    //   );
                    // },
                  ),
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
          create: (context) => SearchBloc(_firebaseCityRepo),
          child: const NewTripSearch(),
        ),
      ),
    ],
  );
}
