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
        backgroundColor: MyColors.primary,
        title: const Text(
          'Hey, User!',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: MyColors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
              context.go(PageName.initRoute);
            },
            icon: const Icon(
              Icons.logout,
              color: MyColors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetCitiesBloc, GetCitiesState>(
        builder: (context, state) {
          if (state is GetCitiesSuccess) {
            cities = state.cities;
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: MediaQuery.of(context).size.width * 0.25,
                      child: const Text(
                        'Where are you going?',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: MyColors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: BlocBuilder<UserHistoryBloc, UserHistoryState>(
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
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
