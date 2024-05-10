import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/blocs/user_history_bloc/user_history_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/screens/home/components/places_horizontal_list_view.dart';
import 'package:travel_app/screens/home/components/popular_destinations.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<City> cities;

  @override
  Widget build(BuildContext context) {
    if (GoRouterState.of(context).uri.toString() == PageName.homeRoute) {
      setState(() {
        context.read<UserHistoryBloc>().add(GetUserHistory());
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.light,
        title: const Text(
          'Hey, User!',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
                context.go(PageName.initRoute);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: BlocBuilder<GetCitiesBloc, GetCitiesState>(
          builder: (context, state) {
            if (state is GetCitiesSuccess) {
              cities = state.cities;
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Where are you going?',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<UserHistoryBloc, UserHistoryState>(
                    builder: (context, state) {
                      if (state is GetUserHistorySuccess) {
                        return PlacesHorizontalListView(
                          recentlyViewed: state.recentlyViewed,
                        );
                      }
                      if (state is GetUserHistoryLoading) {
                        return const SizedBox(
                          height: 160,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PopularDestinations(
                      cities: state.cities,
                    ),
                  )),
                  const SizedBox(
                    height: 70,
                  )
                ],
              );
            } else if (state is GetCitiesFailure) {
              return const Center(
                child: Text('An error has occured...'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
