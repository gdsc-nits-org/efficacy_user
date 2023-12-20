import 'package:efficacy_user/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class FilterButton extends StatelessWidget {
  FilterButton({
    super.key,
    required this.onTap,
    required this.currentTabIndex,
  });
  final Function(int) onTap;
  int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 2.0,
      openWithTap: true,
      onPressed: () {},
      menuItems: [
        FocusedMenuItem(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "All clubs",
              style: TextStyle(
                color: dark,
                // fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          backgroundColor:
              currentTabIndex == 0 ? const Color(0xFFADECFF) : null,
          onPressed: () => onTap(0),
        ),
        FocusedMenuItem(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Subscribed",
              style: TextStyle(
                color: dark,
                // fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          backgroundColor:
              currentTabIndex == 1 ? const Color(0xFFADECFF) : null,
          onPressed: () => onTap(1),
        ),
        FocusedMenuItem(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Unsubscribed",
              style: TextStyle(
                color: dark,
                // fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          backgroundColor:
              currentTabIndex == 2 ? const Color(0xFFADECFF) : null,
          onPressed: () => onTap(2),
        ),
      ],
      child: Icon(
        Icons.sort,
        size: MediaQuery.of(context).size.width * 0.07,
        color: Colors.black,
      ),
    );
  }
}
