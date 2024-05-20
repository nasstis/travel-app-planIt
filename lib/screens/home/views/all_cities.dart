import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_repository/city_repository.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/home/blocs/get_cities_bloc/get_cities_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

class AllCitiesView extends StatelessWidget {
  const AllCitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore all Destinations'),
      ),
      body: BlocBuilder<GetCitiesBloc, GetCitiesState>(
        builder: (context, state) {
          if (state is GetAllCitiesState) {
            return FirestoreListView<City>(
              query: state.cityQuery,
              loadingBuilder: (context) => const CircularProgressIndicator(),
              itemBuilder: (context, doc) {
                final city = doc.data();
                return Center(
                  child: InkWell(
                    onTap: () {
                      context.push(PageName.cityRoute, extra: city);
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.96,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(city.picture),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: MyThemeMode.isDark
                                  ? MyColors.darkGrey
                                  : MyColors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.96,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    city.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    city.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center();
        },
      ),
    );
  }
}
