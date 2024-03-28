import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/components/city_info.dart';
import 'package:travel_app/screens/city/components/city_map.dart';
import 'package:travel_app/screens/place/views/places_list_view.dart';
import 'package:travel_app/utils/constants/colors.dart';

class CityDetailScreen extends StatefulWidget {
  const CityDetailScreen({super.key, required this.city});

  final City city;

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkLight,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: MyColors.light,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star_border_outlined,
              size: 28,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: CachedNetworkImage(
                        imageUrl: widget.city.picture,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.4),
                        colorBlendMode: BlendMode.srcOver,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
                  Positioned(
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.17,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            widget.city.name,
                            style: const TextStyle(
                                fontSize: 35,
                                color: MyColors.light,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: MyColors.light,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.city.country,
                              style: const TextStyle(
                                fontSize: 15,
                                color: MyColors.light,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(
                  children: [
                    CityInfo(
                      city: widget.city,
                    ),
                    BlocProvider(
                      create: (context) => GetPlacesBloc(FirebasePlaceRepo())
                        ..add(GetPlaces(widget.city.cityId)),
                      child: PlacesList(
                        cityName: widget.city.name,
                      ),
                    ),
                    CityMap(
                      city: widget.city,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.36,
              right: MediaQuery.of(context).size.width * 0.07,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.light,
                  ),
                  child: const TabBar(
                    tabs: [
                      Text('Info'),
                      Text('Places'),
                      Text('Map'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
