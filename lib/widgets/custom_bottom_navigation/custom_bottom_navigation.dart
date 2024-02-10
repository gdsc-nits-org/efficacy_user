import 'package:efficacy_user/config/config.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.subKey,
      required this.homeKey,
      required this.exploreKey});
  final int currentIndex;
  final Function onTap;

  //keys for guide
  final GlobalKey exploreKey;
  final GlobalKey homeKey;
  final GlobalKey subKey;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedFontSize: 0,
      selectedFontSize: 0,
      selectedItemColor: accent,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        onTap(index); // more logic to be added regarding page navigation
      },
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          tooltip: 'Explore',
          icon: Icon(
            Icons.explore,
            key: exploreKey,
            size: 30,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          tooltip: 'Home',
          label: "",
          icon: Icon(
            Icons.home,
            key: homeKey,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          tooltip: 'Subscriptions',
          icon: Icon(
            Icons.subscriptions,
            key: subKey,
            size: 30,
          ),
          label: "",
        ),
      ],
    );
  }
}
