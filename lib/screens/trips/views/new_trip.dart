import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:travel_app/utils/helpers/get_list_of_days.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:uuid/uuid.dart';

class NewTrip extends StatefulWidget {
  const NewTrip({super.key});

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  bool _creationRequired = false;
  City? pickedCity;
  DateTimeRange? pickedDate;
  final uuid = const Uuid();
  final String tripId = const Uuid().v4();

  @override
  void initState() {
    _dateController.text = 'Date';
    super.initState();
  }

  void planTripHandle(BuildContext context) {
    if (pickedCity != null && pickedDate != null) {
      context.read<TripBloc>().add(
            CreateTrip(
                Trip(
                  id: tripId,
                  userId: '',
                  cityId: pickedCity!.cityId,
                  startDate: pickedDate!.start,
                  endDate: pickedDate!.end,
                  name:
                      '${pickedCity!.name} ${DateFormat.yMMMM().format(pickedDate!.start).toString()}',
                  photoUrl: pickedCity!.picture,
                  places: [],
                ),
                TripCalendar(
                  id: uuid.v4(),
                  tripId: tripId,
                  places: Map.fromIterables(
                      getListOfDaysInDateRange(
                              pickedDate!.start, pickedDate!.end)
                          .map((date) => date.toString()),
                      List.generate(
                          pickedDate!.end.difference(pickedDate!.start).inDays +
                              1,
                          (index) => [])),
                ),
                context.read<AuthBloc>().state.user!),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please, fill all fields'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripBloc, TripState>(
          listener: (context, state) {
            if (state is CreateTripLoading) {
              setState(() {
                _creationRequired = true;
              });
            } else if (state is CreateTripSuccess) {
              setState(() {
                _creationRequired = false;
              });
              context.read<GetTripsBloc>().add(
                    GetTripByIdRequired(tripId),
                  );
            } else if (state is CreateTripFailure) {
              setState(() {
                _creationRequired = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong...'),
                ),
              );
            }
          },
        ),
        BlocListener<GetTripsBloc, GetTripsState>(
          listener: (context, state) {
            if (state is GetTripByIdSuccess) {
              context.go(
                PageName.tripRoute,
                extra: {
                  'trip': state.trip,
                },
              );
            }
          },
        ),
      ],
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: MyColors.light,
            ),
          ),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(40)),
                  color: MyThemeMode.isDark
                      ? MyColors.darkPrimary
                      : MyColors.primary,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 30, top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start planning your',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          color: MyColors.light,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Adventure ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: MyColors.light,
                            ),
                          ),
                          Text(
                            'now',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                              color: MyColors.light,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    TextField(
                      controller: _cityController,
                      style: TextStyle(
                          color: MyThemeMode.isDark
                              ? MyColors.light
                              : MyColors.darkGrey),
                      decoration: InputDecoration(
                        label: const Text('Where are you going?'),
                        labelStyle: TextStyle(
                            color: MyThemeMode.isDark
                                ? MyColors.light
                                : MyColors.darkGrey),
                        filled: true,
                        fillColor: MyThemeMode.isDark
                            ? MyColors.darkGrey
                            : MyColors.white,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                      readOnly: true,
                      onTap: () async {
                        pickedCity =
                            await context.push(PageName.newTripSearchRoute);
                        if (pickedCity != null) {
                          setState(() {
                            _cityController.text = pickedCity!.name;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _dateController,
                      style: TextStyle(
                        color: MyThemeMode.isDark
                            ? MyColors.light
                            : MyColors.darkGrey,
                      ),
                      decoration: InputDecoration(
                        label: _dateController.text == 'Date'
                            ? null
                            : const Text('Date'),
                        labelStyle: TextStyle(
                            color: MyThemeMode.isDark
                                ? MyColors.light
                                : MyColors.darkGrey),
                        filled: true,
                        fillColor: MyThemeMode.isDark
                            ? MyColors.darkGrey
                            : MyColors.white,
                        prefixIcon: const Icon(Icons.calendar_month),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        prefixIconColor: MyThemeMode.isDark
                            ? MyColors.light
                            : MyColors.darkGrey,
                      ),
                      readOnly: true,
                      onTap: () async {
                        pickedDate = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2050),
                        );
                        if (pickedDate != null) {
                          setState(
                            () {
                              _dateController.text =
                                  '${DateFormat.yMMMMd().format(pickedDate!.start).toString()} / ${DateFormat.yMMMMd().format(pickedDate!.end).toString()}';
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _creationRequired
                          ? null
                          : () => planTripHandle(context),
                      child: _creationRequired
                          ? const CircularProgressIndicator()
                          : const Text('Plan Trip'),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
