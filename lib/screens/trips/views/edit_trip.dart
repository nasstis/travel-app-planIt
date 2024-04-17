import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/trips/blocs/trip_bloc/trip_bloc.dart';
import 'package:travel_app/screens/trips/components/delete_dialog.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
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
  String? newPhotoUrl;

  @override
  void initState() {
    _nameController.text = widget.trip.name;
    _descriptionController.text = widget.trip.description ?? '';
    _dateController.text =
        '${DateFormat.yMMMMd().format(widget.trip.startDate).toString()} / ${DateFormat.yMMMMd().format(widget.trip.endDate).toString()}';
    super.initState();
  }

  // Future _pickImageFromGallery() async {
  //   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     newPhotoUrl = File(returnedImage!.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.light,
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
                style: const TextStyle(color: MyColors.darkGrey),
                cursorColor: MyColors.darkGrey,
                decoration: const InputDecoration(
                  label: Text('Trip name'),
                  labelStyle: TextStyle(color: MyColors.darkGrey),
                  filled: true,
                  fillColor: MyColors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: MyColors.darkGrey, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _dateController,
                style: const TextStyle(
                  color: MyColors.darkGrey,
                ),
                decoration: const InputDecoration(
                  label: Text('Date'),
                  labelStyle: TextStyle(color: MyColors.darkGrey),
                  filled: true,
                  fillColor: MyColors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  prefixIcon: Icon(Icons.calendar_month),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  prefixIconColor: MyColors.darkGrey,
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
                style: const TextStyle(
                  color: MyColors.darkGrey,
                ),
                maxLines: 4,
                decoration: const InputDecoration(
                  label: Text('Description'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Here you can add some details about your trip',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  labelStyle: TextStyle(color: MyColors.darkGrey),
                  filled: true,
                  fillColor: MyColors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: MyColors.darkGrey, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
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
              Container(
                height: 125,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      newPhotoUrl ?? widget.trip.photoUrl,
                    ),
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
              const SizedBox(height: 20),
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
                      return DeleteConfirmDialog(name: widget.trip.name);
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
                  'Delete',
                  style: TextStyle(
                    color: MyColors.red,
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
