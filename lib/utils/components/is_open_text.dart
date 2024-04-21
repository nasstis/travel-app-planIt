import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/helpers/get_working_hours.dart';

class IsOpenText extends StatelessWidget {
  const IsOpenText({
    super.key,
    required this.openingHours,
  });

  final List openingHours;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> workingHoursInfo =
        getPlaceWorkingHoursInfo(openingHours);
    bool isOpen = workingHoursInfo['isOpen'];

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 80,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isOpen
              ? MyColors.green.withOpacity(0.1)
              : MyColors.red.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.solidClock,
              size: 12,
              color: isOpen ? MyColors.green : MyColors.red,
            ),
            const SizedBox(width: 5),
            Text(
              isOpen ? 'Open' : 'Closed',
              style: TextStyle(
                fontSize: 12,
                color: isOpen ? MyColors.green : MyColors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
