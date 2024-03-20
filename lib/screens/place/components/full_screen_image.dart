import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({super.key, this.extra});

  final Map<String, dynamic>? extra;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late final PageController _pageController;
  late int _activePage;
  late List<dynamic> images;
  late int initialIndex;
  @override
  void initState() {
    images = widget.extra!['images'];
    initialIndex = widget.extra!['initialIndex'];
    _pageController = PageController(initialPage: initialIndex);
    _activePage = initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: MyColors.light.withOpacity(0.8),
        ),
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: images.length,
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _activePage = value;
                });
              },
              itemBuilder: (context, index) => Center(
                child: Hero(
                  tag: images[initialIndex],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_activePage < images.length - 1)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    _pageController.animateToPage(_activePage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  icon: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: MyColors.light.withOpacity(0.8),
                      size: 30,
                    ),
                  ),
                ),
              ),
            if (_activePage > 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 5,
                child: IconButton(
                  onPressed: () {
                    _pageController.animateToPage(_activePage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  icon: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: MyColors.light.withOpacity(0.8),
                      size: 30,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 35,
              left: MediaQuery.of(context).size.width * 0.41,
              right: MediaQuery.of(context).size.width * 0.41,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MyColors.light.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    '${_activePage + 1} / ${images.length}',
                    style: TextStyle(
                      color: MyColors.light.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
