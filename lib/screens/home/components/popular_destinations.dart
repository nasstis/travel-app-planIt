import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/screens/city/views/city_detail_screen.dart';
import 'package:travel_app/utils/components/card_view.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({super.key, required this.cities});

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Destinations',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See All',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        Expanded(
          child: MasonryGridView.builder(
            itemCount: cities.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            itemBuilder: (context, index) {
              return Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityDetailScreen(
                            city: cities[index],
                          ),
                        ));
                  },
                  child: CardView(
                    imageUrl: cities[index].picture,
                    name: cities[index].name,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
