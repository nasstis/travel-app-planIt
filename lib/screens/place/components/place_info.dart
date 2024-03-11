import 'package:flutter/material.dart';
import 'package:place_repository/place_repository.dart';
import 'package:readmore/readmore.dart';

class PlaceInfo extends StatelessWidget {
  const PlaceInfo({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              place.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            ReadMoreText(
              place.description,
              trimLines: 6,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'More',
              trimExpandedText: ' Hide',
              moreStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              lessStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
