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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loadData(widget.imageUrl);
      },
    );
  }

  Future<void> loadData(String imageUrl) async {
    setState(() => isLoading = true);

    photo = await cacheImage(context, imageUrl);

    setState(() => isLoading = false);
  }

  Future<String> cacheImage(BuildContext context, String url) async {
    await precacheImage(CachedNetworkImageProvider(url), context);
    return url;
  }

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
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.1),
                    colorBlendMode: BlendMode.srcOver,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.heart_fill,
              color: MyColors.light,
              size: 25,
            ),
          ),
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
                    fontSize: 17,
                    color: MyColors.light,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 28,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColors.light.withOpacity(0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      CupertinoIcons.star_fill,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Text(
                      widget.rating.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
