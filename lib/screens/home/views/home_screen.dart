import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: const Text('Hey, User!'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
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
