import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CityInfo extends StatelessWidget {
  const CityInfo({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            ReadMoreText(
              city.description,
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
            const SizedBox(height: 10),
            const Text(
              'Photos',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
