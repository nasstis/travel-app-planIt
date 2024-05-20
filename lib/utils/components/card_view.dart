import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class CardView extends StatefulWidget {
  const CardView({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
  });

  final String imageUrl;
  final String name;
  final double rating;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  bool isLoading = false;
  String photo = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isLoading
              ? Container(
                  height: 200,
                  width: 200,
                  color: MyColors.buttonDisabled,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  constraints: const BoxConstraints(
                    minHeight: 180,
                    maxHeight: 250,
                    minWidth: 200,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.1),
                    colorBlendMode: BlendMode.srcOver,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
        ),
        Positioned(
          bottom: 10,
          left: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170,
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: MyColors.light,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
