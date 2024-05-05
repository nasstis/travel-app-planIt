import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/components/search_place_results.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:trip_repository/trip_repository.dart';

class AddPlaceSearch extends StatefulWidget {
  const AddPlaceSearch({super.key, required this.trip});

  final Trip trip;

  @override
  State<AddPlaceSearch> createState() => _AddPlaceSearchState();
}

class _AddPlaceSearchState extends State<AddPlaceSearch> {
  final _controller = TextEditingController();
  List<Place>? places;
  List<Place>? cityPlaces;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    places = context.select((SearchBloc bloc) => bloc.state.places);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              counter++;
              context.read<SearchBloc>().add(SearchWordPlace(value));
            },
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 1,
                  color: MyColors.darkLight,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: " Search for a place to add...",
              suffixIcon: IconButton(
                onPressed: () {
                  context
                      .read<SearchBloc>()
                      .add(SearchWordPlace(_controller.text));
                  FocusScope.of(context).unfocus();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 18,
                  color: MyColors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              if (state is GetCityPlacesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetCityPlacesSuccess) {
                cityPlaces = state.places;
              }

              return SearchPlaceResults(
                places: places!.isEmpty && counter == 0 ? cityPlaces : places,
                trip: widget.trip,
              );
            },
          ),
        ],
      ),
    );
  }
}
