import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/views/welcome_screen.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/views/city_detail_screen.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/screens/home/views/home_screen.dart';
import 'package:travel_app/screens/place/views/place_screen.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/screens/search/views/search_screen.dart';
import 'package:travel_app/screens/splash/views/splash_screen.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      // builder: (context, state, child) {
      //   if (state.fullPath == loginRoute || state.fullPath == initRoute) {
      //     return child;
      //   } else {
      //     return BlocProvider(
      //       create: (context) =>
      //           SignInBloc(context.read<AuthBloc>().userRepository),
      //       child: BaseScreen(child),
      //     );
      //   }
      // },
      // routes: [
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
      GoRoute(
        path: PageName.homeRoute,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  SignInBloc(context.read<AuthBloc>().userRepository),
            ),
            BlocProvider(
              create: (context) =>
                  GetCitiesBloc(FirebaseCityRepo())..add(GetCities()),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: PageName.searchRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchBloc(FirebaseCityRepo()),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: PageName.cityRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => GetPlacesBloc(FirebasePlaceRepo()),
          child: CityDetailScreen(city: state.extra as City),
        ),
      ),
      GoRoute(
        path: PageName.placeRoute,
        builder: (context, state) =>
            PlaceScreen(extra: state.extra as Map<String, dynamic>?),
      ),
    ],
    //   ),
    // ],
  );
}
