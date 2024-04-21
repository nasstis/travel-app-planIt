import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/utils/constants/colors.dart';

class TripHeader extends StatelessWidget {
  const TripHeader(
      {super.key,
      required this.photoUrl,
      required this.name,
      required this.startDate,
      required this.endDate});

  final String photoUrl;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: photoUrl,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.srcOver,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 250,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 2),
                        blurRadius: 8.0,
                        color: Color(0xFF000000),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 170,
          left: 15,
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: MyColors.white,
                size: 15,
              ),
              Text(
                ' ${DateFormat.MMMd().format(startDate).toString()} - ${DateFormat.MMMd().format(endDate).toString()}',
                style: const TextStyle(
                  fontSize: 13,
                  color: MyColors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
