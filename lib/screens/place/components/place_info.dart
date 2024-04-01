import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/screens/place/blocs/get_working_hours_bloc.dart/get_working_hours_bloc.dart';
import 'package:travel_app/screens/place/components/place_types.dart';
import 'package:travel_app/screens/place/components/working_hours.dart';
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
  bool seeAllTypesRequired = false;

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
            const SizedBox(height: 20),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 5),
            if (isOpen != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidClock,
                    size: 17,
                    color: isOpen! ? MyColors.green : MyColors.red,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      isOpen! ? 'Right now Open' : 'Right now Closed ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
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
                  const SizedBox(height: 15),
                ],
              ),
            if (workingHours.isNotEmpty)
              WorkingHoursElement(
                workingHours: workingHours,
                currentDay: currentDay,
                lenght: widget.place.openingHours!.length,
              ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
