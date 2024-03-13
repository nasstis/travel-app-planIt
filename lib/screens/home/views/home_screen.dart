import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/screens/home/components/bottom_navigation_bar.dart';
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
              context.push(PageName.searchRoute);
            },
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22,
              color: MyColors.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
              context.go(PageName.initRoute);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 22,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 4),
        child: BlocBuilder<GetCitiesBloc, GetCitiesState>(
          builder: (context, state) {
            if (state is GetCitiesSuccess) {
              cities = state.cities;
              return Column(
                children: [
                  const PlacesHorizontalListView(),
                  // SizedBox(height: 25),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PopularDestinations(
                      cities: state.cities,
                    ),
                  )),
                  const SizedBox(
                    height: 1,
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
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
