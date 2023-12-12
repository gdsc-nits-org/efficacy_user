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
      selectedItemColor: Color.fromARGB(255, 6, 188, 176),
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        onTap(index); // more logic to be added regarding page navigation
      },
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.home,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.profile_circled,
            size: 30,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.compass,
            size: 30,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.menu,
            size: 30,
          ),
        ),
      ],
    );
  }
}
