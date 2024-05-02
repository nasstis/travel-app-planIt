import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/utils/constants/colors.dart';

class ItineraryModalBottomSheet extends StatelessWidget {
  const ItineraryModalBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MyColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              onPressed: () {
                context.pop('Map');
              },
              icon: const FaIcon(
                FontAwesomeIcons.solidMap,
                size: 16,
                color: MyColors.darkGrey,
              ),
              label: const Text(
                'See Itinerary on the map',
                style: TextStyle(
                  color: MyColors.darkGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                context.pop('Edit');
              },
              icon: const FaIcon(
                FontAwesomeIcons.pencil,
                size: 16,
                color: MyColors.darkGrey,
              ),
              label: const Text(
                'Edit itinerary',
                style: TextStyle(
                  color: MyColors.darkGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                context.pop('Add');
              },
              icon: const FaIcon(
                FontAwesomeIcons.plus,
                size: 16,
                color: MyColors.darkGrey,
              ),
              label: const Text(
                'Add places to Itinerary',
                style: TextStyle(
                  color: MyColors.darkGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
