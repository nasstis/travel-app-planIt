import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';

class SearchPlaceResults extends StatelessWidget {
  const SearchPlaceResults({
    super.key,
    required this.places,
    required TextEditingController controller,
  }) : _controller = controller;

  final List<Place>? places;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    if (places == null || places!.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          const Center(
            child: Text('There is no such place yet...'),
          ),
        ],
      );
    } else {
      return Expanded(
        child: SizedBox(
          height: 500,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: places!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        _controller.clear();
                        context.read<SearchBloc>().add(ClearSearchResults());
                      },
                      title: Text(
                        places![index].name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: MyColors.darkPrimary,
                        ),
                      ),
                      subtitle: Text(
                        places![index].cityName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: MyColors.darkPrimary,
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
                                places![index].photos[0]),
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          weight: 10,
                          color: MyColors.darkPrimary,
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
