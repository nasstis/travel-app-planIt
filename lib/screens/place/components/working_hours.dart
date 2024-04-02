import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class WorkingHoursElement extends StatelessWidget {
  const WorkingHoursElement({
    super.key,
    required this.workingHours,
    required this.currentDay,
    required this.lenght,
  });

  final Map<String, String> workingHours;
  final String currentDay;
  final int lenght;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyColors.light,
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lenght,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                );
              },
              itemBuilder: (context, index) {
                List<String> keys = workingHours.keys.toList();
                if (keys[index].contains(currentDay)) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: currentDay == 'Monday'
                          ? const BorderRadius.vertical(
                              top: Radius.circular(15))
                          : currentDay == 'Sunday'
                              ? const BorderRadius.vertical(
                                  bottom: Radius.circular(15))
                              : null,
                      color: MyColors.primary.withOpacity(0.2),
                    ),
                    child: ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(keys[index]),
                          Text(
                            workingHours[keys[index]]!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -3),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(keys[index]),
                      Text(
                        workingHours[keys[index]]!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
