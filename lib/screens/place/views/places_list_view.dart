import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlacesBloc, GetPlacesState>(
      builder: (context, state) {
        if (state is GetPlacesSuccess) {
          return Center(
            child: ListView.builder(
              itemCount: state.places.length,
              itemBuilder: (context, index) => Text(state.places[index].name),
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
