import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/utils/constants/colors.dart';

class NewTrip extends StatefulWidget {
  const NewTrip({super.key});

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  @override
  void initState() {
    _dateController.text = 'Date';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
                color: MyColors.primary,
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
                    style: const TextStyle(
                        color: MyColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      label: Text('Where are you going?'),
                      labelStyle: TextStyle(color: MyColors.darkGrey),
                      filled: true,
                      fillColor: MyColors.white,
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    readOnly: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _dateController,
                    style: const TextStyle(
                      color: MyColors.darkGrey,
                    ),
                    decoration: InputDecoration(
                      label: _dateController.text == 'Date'
                          ? null
                          : const Text('Date'),
                      labelStyle: const TextStyle(color: MyColors.darkGrey),
                      filled: true,
                      fillColor: MyColors.white,
                      prefixIcon: const Icon(Icons.calendar_month),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIconColor: MyColors.darkGrey,
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTimeRange? pickedDate = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2050),
                      );

                      if (pickedDate != null) {
                        setState(
                          () {
                            _dateController.text =
                                '${DateFormat.yMMMMd().format(pickedDate.start).toString()} / ${DateFormat.yMMMMd().format(pickedDate.end).toString()}';
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Plan Trip'),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
