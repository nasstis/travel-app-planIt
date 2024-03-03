import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/home/components/bottom_navigation_bar.dart';
import 'package:travel_app/screens/home/components/places_horizontal_list_view.dart';
import 'package:travel_app/screens/home/components/popular_destinations.dart';
import 'package:travel_app/utils/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22,
              color: MyColors.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 22,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: Column(
          children: [
            PlacesHorizontalListView(),
            // SizedBox(height: 25),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: PopularDestinations(),
            )),
            SizedBox(
              height: 1,
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
