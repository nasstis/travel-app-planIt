import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage(
      {super.key, required this.images, required this.initialIndex});

  final List<dynamic> images;
  final int initialIndex;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late final PageController _pageController;
  late int _activePage;
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialIndex);
    _activePage = widget.initialIndex;
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
              itemCount: widget.images.length,
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _activePage = value;
                });
              },
              itemBuilder: (context, index) => Center(
                child: Hero(
                  tag: widget.images[widget.initialIndex],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.images[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_activePage < widget.images.length - 1)
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
                    '${_activePage + 1} / ${widget.images.length}',
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
