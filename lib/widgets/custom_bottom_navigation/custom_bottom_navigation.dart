import 'package:efficacy_user/config/config.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.subKey,
    required this.homeKey,
    required this.eventsKey
  });
  final int currentIndex;
  final Function onTap;

  //keys for guide
  GlobalKey eventsKey = GlobalKey();
  GlobalKey homeKey = GlobalKey();
  GlobalKey subKey = GlobalKey();

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
      items:  [
        BottomNavigationBarItem(
          key: eventsKey,
          tooltip: 'Events',
          icon: const Icon(
            Icons.explore,
            size: 30,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          key: homeKey,
          tooltip: 'Home',
          label: "",
          icon: const Icon(
            Icons.home,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          key: subKey,
          tooltip: 'Subscriptions',
          icon: const Icon(
            Icons.subscriptions,
            size: 30,
          ),
          label: "",
        ),
      ],
    );
  }
}
