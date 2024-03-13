import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/utils/components/card_view.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlacesBloc, GetPlacesState>(
      builder: (context, state) {
        if (state is GetPlacesSuccess) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
            child: MasonryGridView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.places.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              itemBuilder: (context, index) {
                return Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      context.push(
                        PageName.placeRoute,
                        extra: {
                          'place': state.places[index],
                          'cityName': cityName,
                        },
                      );
                    },
                    child: CardView(
                      imageUrl: state.places[index].pictures[0],
                      name: state.places[index].name,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: Text('Не робе'),
        );
      },
    );
  }
}
