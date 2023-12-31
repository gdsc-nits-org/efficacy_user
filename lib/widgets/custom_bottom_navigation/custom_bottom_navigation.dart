import 'package:efficacy_user/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: accent,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        onTap(index); // more logic to be added regarding page navigation
      },
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore,
            size: 30,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.home,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.subscriptions,
            size: 30,
          ),
          label: "",
        ),
      ],
    );
  }
}
