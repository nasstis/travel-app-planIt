import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/views/welcome_screen.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/screens/home/views/home_screen.dart';
import 'package:travel_app/screens/splash/views/splash_screen.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initRoute,
    redirect: (context, state) {
      if (authBloc.state.status == AuthStatus.unknown) {
        return initRoute;
      }
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
        path: initRoute,
        builder: (context, state) => BlocProvider<AuthBloc>.value(
          value: BlocProvider.of<AuthBloc>(context),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: welcomeRoute,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: homeRoute,
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
    ],
    //   ),
    // ],
  );
}
