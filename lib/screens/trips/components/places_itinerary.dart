import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/utils/components/is_open_text.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class PlacesItineraryView extends StatelessWidget {
  const PlacesItineraryView({
    super.key,
    required this.places,
  });

  final List places;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: places.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              places[index].photos[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (places[index].openingHours != null)
                      Positioned(
                        top: 5,
                        left: 5,
                        child: IsOpenText(
                          openingHours: places[index].openingHours!,
                          width: 55,
                          height: 15,
                          iconSize: 10,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.63,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(children: [
                            const FaIcon(
                              FontAwesomeIcons.locationPin,
                              size: 20,
                              color: MyColors.primary,
                            ),
                            Positioned(
                              left: index + 1 == 11
                                  ? 3
                                  : index + 1 > 9
                                      ? 2
                                      : index + 1 == 1
                                          ? 5
                                          : 4.5,
                              top: 1.5,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: MyColors.light,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ]),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              places[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      places[index].description != null
                          ? Text(places[index].description)
                          : const Text(
                              'Oops! It looks like we couldn\'t find a description for this place',
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            context.push(PageName.addPlaceToItinerary, extra: places);
          },
          child: const Text('Add more places'),
        ),
      ],
    );
  }
}
