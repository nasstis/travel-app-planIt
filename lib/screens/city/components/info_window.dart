import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/place/components/star_display.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class MyInfoWindow extends StatelessWidget {
  const MyInfoWindow({
    super.key,
    required this.selectedPlace,
    required this.routingToPlaceAllowed,
  });

  final Place selectedPlace;
  final bool routingToPlaceAllowed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      color: MyColors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: routingToPlaceAllowed
            ? () {
                context.push(PageName.placeRoute, extra: selectedPlace);
              }
            : null,
        child: Row(
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(selectedPlace.photos[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          selectedPlace.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (selectedPlace.rating != null)
                        StarDisplay(rating: selectedPlace.rating!, size: 16),
                      if (selectedPlace.description != null)
                        SizedBox(
                          width: 150,
                          child: Text(
                            selectedPlace.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (routingToPlaceAllowed)
                    const Text(
                      '*Tap to see more',
                      style: TextStyle(fontSize: 10),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
