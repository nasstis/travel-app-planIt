import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/screens/city/components/info_components.dart';
import 'package:travel_app/utils/constants/colors.dart';

class CityInfo extends StatelessWidget {
  const CityInfo({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${city.name} | ${city.country}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoComponents(
                  text: city.continent,
                  icon: FontAwesomeIcons.earthAmericas,
                ),
                InfoComponents(
                  text: city.timeZone,
                  icon: FontAwesomeIcons.solidClock,
                ),
                InfoComponents(
                  text: city.officialLanguage,
                  icon: FontAwesomeIcons.language,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.temperatureThreeQuarters,
                  size: 22,
                  color: MyColors.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  '${city.climate} climate',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.creditCard,
                  size: 20,
                  color: MyColors.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  'Currency: ${city.currency}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
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
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
