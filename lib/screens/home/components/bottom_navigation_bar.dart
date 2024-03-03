import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: Icon(
                  CupertinoIcons.square_grid_2x2_fill,
                  size: 28,
                  color: pageIndex == 0
                      ? MyColors.primary
                      : MyColors.buttonDisabled,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: pageIndex == 1
                      ? MyColors.primary
                      : MyColors.buttonDisabled,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: Icon(
                  CupertinoIcons.star_fill,
                  color: pageIndex == 2
                      ? MyColors.primary
                      : MyColors.buttonDisabled,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: Icon(
                  CupertinoIcons.person_fill,
                  color: pageIndex == 3
                      ? MyColors.primary
                      : MyColors.buttonDisabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
