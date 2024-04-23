import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/utils/components/is_open_text.dart';
import 'package:travel_app/utils/constants/colors.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.place,
    required this.onRemovePlaceTap,
  });

  final Place place;
  final void Function() onRemovePlaceTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(place.photos[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (place.openingHours != null)
                Positioned(
                  top: 10,
                  left: 5,
                  child: IsOpenText(
                    openingHours: place.openingHours!,
                    width: 80,
                    height: 20,
                    iconSize: 12,
                    fontSize: 12,
                  ),
                ),
              Positioned(
                  right: 0,
                  top: -5,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: RadialGradient(
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0),
                          ],
                        )),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: MyColors.light,
                      ),
                      onPressed: onRemovePlaceTap,
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 13,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      place.cityName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                place.description == null
                    ? const Text(
                        'Oops! It looks like we couldn\'t find a description for this place',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    : Text(
                        place.description!,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                const SizedBox(height: 7),
                Wrap(
                  runSpacing: -6,
                  children: List.generate(
                    place.types.length > 2 ? 2 : place.types.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Chip(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 0),
                          label: Text(
                            place.types[index],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
