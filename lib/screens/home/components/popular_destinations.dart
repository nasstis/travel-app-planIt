import 'package:city_repository/city_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/utils/constants/colors.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({super.key, required this.cities});

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    // List imagesAssets = [
    //   'assets/images/2.jpg',
    //   'assets/images/3.jpg',
    //   'assets/images/4.jpg',
    //   'assets/images/5.jpg',
    //   'assets/images/2.jpg',
    //   'assets/images/3.jpg',
    //   'assets/images/5.jpg',
    // ];

    // List names = [
    //   'Paris',
    //   'Turkey',
    //   'Japan',
    //   'Dubai',
    //   'Paris',
    //   'Turkey',
    //   'Dubai',
    // ];

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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 180,
                          maxHeight: 250,
                          minWidth: 200,
                        ),
                        child: Image(
                          image: NetworkImage(cities[index].pictures[0]),
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.1),
                          colorBlendMode: BlendMode.srcOver,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.heart_fill,
                          color: MyColors.light,
                          size: 25,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cities[index].name,
                            style: const TextStyle(
                              fontSize: 17,
                              color: MyColors.light,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 28,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.light.withOpacity(0.8),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
