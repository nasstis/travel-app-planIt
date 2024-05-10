import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.cities,
    required TextEditingController controller,
    required this.isForTrip,
  }) : _controller = controller;

  final List<City>? cities;
  final TextEditingController _controller;
  final bool isForTrip;

  @override
  Widget build(BuildContext context) {
    if (cities == null || cities!.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          const Center(
            child: Text('There is no such city yet...'),
          ),
        ],
      );
    } else {
      return Expanded(
        child: SizedBox(
          height: 500,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: cities!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        _controller.clear();
                        context.read<SearchBloc>().add(ClearSearchResults());
                        if (isForTrip) {
                          context.pop(cities![index]);
                        } else {
                          context.go(PageName.cityRoute, extra: cities![index]);
                        }
                      },
                      title: Text(
                        cities![index].name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: MyThemeMode.isDark
                              ? MyColors.darkLight
                              : MyColors.darkPrimary,
                        ),
                      ),
                      subtitle: Text(
                        cities![index].country,
                        style: TextStyle(
                          fontSize: 13,
                          color: MyThemeMode.isDark
                              ? MyColors.darkLight
                              : MyColors.darkPrimary,
                        ),
                      ),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                cities![index].picture),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }),
        ),
      );
    }
  }
}
