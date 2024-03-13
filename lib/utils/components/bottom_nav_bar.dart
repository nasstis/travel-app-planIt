import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/utils/constants/colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Theme(
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
                    _onTap(context, 0);
                  },
                  icon: Icon(
                    CupertinoIcons.square_grid_2x2_fill,
                    size: 28,
                    color: navigationShell.currentIndex == 0
                        ? MyColors.primary
                        : MyColors.buttonDisabled,
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    _onTap(context, 1);
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                    color: navigationShell.currentIndex == 1
                        ? MyColors.primary
                        : MyColors.buttonDisabled,
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    _onTap(context, 2);
                  },
                  icon: Icon(
                    CupertinoIcons.star_fill,
                    color: navigationShell.currentIndex == 2
                        ? MyColors.primary
                        : MyColors.buttonDisabled,
                  ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    _onTap(context, 3);
                  },
                  icon: Icon(
                    CupertinoIcons.person_fill,
                    color: navigationShell.currentIndex == 3
                        ? MyColors.primary
                        : MyColors.buttonDisabled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
