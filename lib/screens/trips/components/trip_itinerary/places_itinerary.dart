import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/utils/components/is_open_text.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:trip_repository/trip_repository.dart';

class PlacesItineraryView extends StatefulWidget {
  const PlacesItineraryView({
    super.key,
    required this.places,
    required this.date,
    required this.trip,
  });

  final List places;
  final Trip trip;
  final DateTime date;

  @override
  State<PlacesItineraryView> createState() => _PlacesItineraryViewState();
}

class _PlacesItineraryViewState extends State<PlacesItineraryView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: widget.places.length,
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
                              widget.places[index].photos[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (widget.places[index].openingHours != null)
                      Positioned(
                        top: 5,
                        left: 5,
                        child: IsOpenText(
                          openingHours: widget.places[index].openingHours!,
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
                              widget.places[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      widget.places[index].description != null
                          ? Text(widget.places[index].description)
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
            context.push(PageName.addPlaceToItinerary, extra: {
              'places': widget.trip.places
                  .where((e) => !widget.places.contains(e))
                  .toList(),
              'tripId': widget.trip.id,
              'date': widget.date,
            }).then((value) {
              setState(() {
                context
                    .read<TripCalendarBloc>()
                    .add(GetTripCalendar(widget.trip.id));
              });
            });
          },
          child: const Text('Add more places'),
        ),
      ],
    );
  }
}
