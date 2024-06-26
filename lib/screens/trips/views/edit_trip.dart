import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/blocs/get_trips_bloc/get_trips_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/components/delete_dialog.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:trip_repository/trip_repository.dart';

class EditTrip extends StatefulWidget {
  const EditTrip({super.key, required this.trip});

  final Trip trip;

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTimeRange? pickedDate;
  File? newPhoto;
  bool _editRequired = false;
  final color = MyThemeMode.isDark ? MyColors.light : MyColors.darkGrey;
  final fillColor = MyThemeMode.isDark ? MyColors.dark : MyColors.white;

  @override
  void initState() {
    _nameController.text = widget.trip.name;
    _descriptionController.text = widget.trip.description ?? '';
    _dateController.text =
        '${DateFormat.yMMMMd().format(widget.trip.startDate).toString()} / ${DateFormat.yMMMMd().format(widget.trip.endDate).toString()}';
    super.initState();
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        newPhoto = File(returnedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemeMode.isDark ? MyColors.dark : MyColors.light,
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.28),
          child: const Text(
            'Edit',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                maxLength: 50,
                style: TextStyle(color: color),
                cursorColor: color,
                decoration: InputDecoration(
                  label: const Text('Trip name'),
                  labelStyle: TextStyle(color: color),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _dateController,
                style: TextStyle(
                  color: color,
                ),
                decoration: InputDecoration(
                  label: const Text('Date'),
                  labelStyle: TextStyle(color: color),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  prefixIcon: const Icon(Icons.calendar_month),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  prefixIconColor: color,
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
              const SizedBox(height: 30),
              TextField(
                controller: _descriptionController,
                style: TextStyle(
                  color: color,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  label: const Text('Description'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Here you can add some details about your trip',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  labelStyle: TextStyle(color: color),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 27),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Trip photo',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              InkWell(
                onTap: _pickImageFromGallery,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                    image: DecorationImage(
                      image: newPhoto != null
                          ? FileImage(newPhoto!)
                          : CachedNetworkImageProvider(
                              widget.trip.photoUrl,
                            ) as ImageProvider,
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      color: MyColors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton.icon(
                icon: const Icon(
                  Icons.delete,
                  size: 18,
                  color: MyColors.red,
                ),
                onPressed: () async {
                  final currentContext = context;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteConfirmDialog(
                        title: "Confirm deletion",
                        content:
                            "Are you sure you want to delete ${widget.trip.name} trip?",
                        action: 'Delete',
                      );
                    },
                  ).then((deleteConfirmed) {
                    if (deleteConfirmed != null && deleteConfirmed) {
                      currentContext.read<TripBloc>().add(
                            DeleteTrip(widget.trip.id),
                          );
                      currentContext.go(PageName.tripsRoute);
                    }
                  });
                },
                label: const Text(
                  'Delete trip',
                  style: TextStyle(
                    color: MyColors.red,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              MultiBlocListener(
                listeners: [
                  BlocListener<TripBloc, TripState>(
                    listener: (context, state) {
                      if (state is EditTripLoading) {
                        setState(() {
                          _editRequired = true;
                        });
                      }
                      if (state is EditTripSuccess) {
                        setState(() {
                          _editRequired = false;
                        });
                        context.read<GetTripsBloc>().add(
                              GetTripByIdRequired(widget.trip.id),
                            );
                      }
                      if (state is EditTripSuccess) {
                        setState(() {
                          _editRequired = false;
                        });
                      }
                    },
                  ),
                  BlocListener<GetTripsBloc, GetTripsState>(
                    listener: (context, state) {
                      if (state is GetTripByIdSuccess) {
                        context.go(PageName.tripRoute, extra: {
                          'trip': state.trip,
                        });
                      }
                    },
                  ),
                ],
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<TripBloc>().add(
                              EditTripEvent(newPhoto,
                                  tripId: widget.trip.id,
                                  name: _nameController.text,
                                  description: _descriptionController.text,
                                  startDate: pickedDate != null
                                      ? pickedDate!.start
                                      : widget.trip.startDate,
                                  endDate: pickedDate != null
                                      ? pickedDate!.end
                                      : widget.trip.endDate),
                            );
                      },
                      child: _editRequired
                          ? const CircularProgressIndicator()
                          : const Text('Save'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
