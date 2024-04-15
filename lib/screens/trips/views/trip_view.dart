import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:trip_repository/trip_repository.dart';

class TripView extends StatelessWidget {
  const TripView({
    super.key,
    this.extra,
  });

  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    final Trip trip = extra!['trip'];
    final String tag = extra!['tag'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: MyColors.light,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Add edit page
            },
            icon: const Icon(
              Icons.edit,
              size: 20,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: tag,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: trip.photoUrl,
                              color: Colors.black.withOpacity(0.3),
                              colorBlendMode: BlendMode.srcOver,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 250,
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Text(
                            trip.name,
                            style: const TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1, 2),
                                  blurRadius: 8.0,
                                  color: Color(0xFF000000),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 170,
                      left: 15,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: MyColors.white,
                            size: 15,
                          ),
                          Text(
                            ' ${DateFormat.MMMd().format(trip.startDate).toString()} - ${DateFormat.MMMd().format(trip.endDate).toString()}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: MyColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height - 185,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          dividerColor: Colors.transparent,
                          tabs: [
                            Text('Info'),
                            Text('Itinerary'),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height - 230,
                          child: const TabBarView(
                            children: [
                              Text('Info'),
                              Text('Itinerary'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
