import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/screens/place/components/place_types.dart';
import 'package:travel_app/screens/place/components/working_hours.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:travel_app/utils/helpers/get_working_hours.dart';

class PlaceInfo extends StatefulWidget {
  const PlaceInfo({super.key, required this.place});

  final Place place;

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  bool? isOpen;
  Map<String, String> workingHours = {};
  String currentDay = "";
  bool seeAllTypesRequired = false;
  bool seeWorkingHoursRequired = false;

  @override
  void initState() {
    if (widget.place.openingHours != null) {
      final Map<String, dynamic> workingHoursInfo =
          getPlaceWorkingHoursInfo(widget.place.openingHours!);
      setState(() {
        isOpen = workingHoursInfo['isOpen'];
        workingHours = workingHoursInfo['workingHours'];
        currentDay = workingHoursInfo['currentDay'];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            PlaceTypesElement(
              seeAllTypesRequired: seeAllTypesRequired,
              types: widget.place.types,
              seeAll: () {
                setState(() {
                  seeAllTypesRequired = !seeAllTypesRequired;
                });
              },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const FaIcon(
                  FontAwesomeIcons.mapPin,
                  size: 22,
                  color: MyColors.primary,
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.place.address,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (isOpen != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    seeWorkingHoursRequired = !seeWorkingHoursRequired;
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          const FaIcon(
                            FontAwesomeIcons.solidClock,
                            size: 15,
                            color: MyColors.primary,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            seeWorkingHoursRequired
                                ? 'Hide'
                                : 'See working hours',
                            style: const TextStyle(
                              fontSize: 14,
                              color: MyColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Icon(seeWorkingHoursRequired
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down),
                    ]),
              ),
            if (seeWorkingHoursRequired)
              WorkingHoursElement(
                workingHours: workingHours,
                currentDay: currentDay,
                lenght: widget.place.openingHours!.length,
              ),
            if (widget.place.description != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ReadMoreText(
                    widget.place.description!,
                    trimLines: 6,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'More',
                    trimExpandedText: ' Hide',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            if (widget.place.goodForChildren != null &&
                widget.place.goodForChildren!)
              Chip(
                avatar: const Icon(
                  Icons.child_friendly,
                  size: 18,
                ),
                label: const Text(
                  'This place is good for children',
                ),
                backgroundColor:
                    MyThemeMode.isDark ? MyColors.dark : MyColors.light,
              ),
            if (widget.place.restroom != null && widget.place.restroom!)
              Chip(
                avatar: const FaIcon(
                  FontAwesomeIcons.restroom,
                  size: 15,
                ),
                label: const Text(
                  'This place have a restroom',
                ),
                backgroundColor:
                    MyThemeMode.isDark ? MyColors.dark : MyColors.light,
              ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
