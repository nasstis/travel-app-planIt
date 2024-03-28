import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/screens/place/blocs/get_working_hours_bloc.dart/get_working_hours_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.place.openingHours != null) {
      final bloc = context.read<GetWorkingHoursBloc>();
      bloc.add(
          GetWotkingHoursRequired(openingHours: widget.place.openingHours!));
      bloc.stream.listen((state) {
        if (state is GetWorkingHoursSucces) {
          setState(() {
            isOpen = state.isOpen;
            workingHours = state.workingHours;
            currentDay = state.currentDay;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isOpen != null)
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 20,
                    color: MyColors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    isOpen! ? 'Right now Open' : 'Right now Closed ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            const Text(
              'Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const FaIcon(
                  FontAwesomeIcons.mapPin,
                  size: 20,
                  color: MyColors.primary,
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.place.address,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            if (workingHours.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Openning hours',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.light,
                      ),
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.place.openingHours!.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                            );
                          },
                          itemBuilder: (context, index) {
                            List<String> keys = workingHours.keys.toList();
                            if (keys[index].contains(currentDay)) {
                              return Container(
                                color: MyColors.primary.withOpacity(0.2),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -3),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(keys[index]),
                                      Text(
                                        workingHours[keys[index]]!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return ListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -3),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(keys[index]),
                                  Text(
                                    workingHours[keys[index]]!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            if (widget.place.description != null)
              ReadMoreText(
                widget.place.description!,
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
