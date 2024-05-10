import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/screens/search/components/search_results.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

class NewTripSearch extends StatefulWidget {
  const NewTripSearch({super.key});

  @override
  State<NewTripSearch> createState() => _NewTripSearchState();
}

class _NewTripSearchState extends State<NewTripSearch> {
  final _controller = TextEditingController();
  List<City>? cities;
  @override
  Widget build(BuildContext context) {
    cities = context.select((SearchBloc bloc) => bloc.state.cities);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              context.read<SearchBloc>().add(SearchWordRequired(value));
            },
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  MyThemeMode.isDark ? MyColors.darkGrey : MyColors.white,
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
              hintText: " Search...",
              suffixIcon: IconButton(
                onPressed: () {
                  context
                      .read<SearchBloc>()
                      .add(SearchWordRequired(_controller.text));
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
          SearchResults(
            cities: cities,
            controller: _controller,
            isForTrip: true,
          ),
        ],
      ),
    );
  }
}
