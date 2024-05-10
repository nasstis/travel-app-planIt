import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class PlacesHorizontalListView extends StatelessWidget {
  const PlacesHorizontalListView({
    super.key,
    required this.recentlyViewed,
  });

  final List<City> recentlyViewed;

  @override
  Widget build(BuildContext context) {
    return recentlyViewed.isNotEmpty
        ? SizedBox(
            height: 160,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recently viewed',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: recentlyViewed.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          context.push(PageName.cityRoute,
                              extra: recentlyViewed[index]);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      recentlyViewed[index].picture),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Text(
                              recentlyViewed[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
