import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/search/blocs/search_bloc/search_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cities = context.select((SearchBloc bloc) => bloc.state.cities);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: MyColors.light,
        ),
      ),
      backgroundColor: MyColors.white,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              color: MyColors.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 50, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: MyColors.light,
                    ),
                  ),
                  const Text(
                    'for cities',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      color: MyColors.light,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        context
                            .read<SearchBloc>()
                            .add(SearchWordRequired(value));
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
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Search result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: MyColors.darkPrimary,
              ),
            ),
          ),
          if (cities == null || cities.isEmpty)
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                const Center(
                  child: Text('There is no such city yet...'),
                ),
              ],
            )
          else
            Expanded(
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              _controller.clear();
                              context.go(PageName.cityRoute,
                                  extra: cities[index]);
                            },
                            title: Text(
                              cities[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: MyColors.darkPrimary,
                              ),
                            ),
                            subtitle: Text(
                              cities[index].country,
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
                                  image: NetworkImage(cities[index].picture),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
