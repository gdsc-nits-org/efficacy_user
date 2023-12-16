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
      openWithTap: true,
      onPressed: () {},
      menuItems: [
        FocusedMenuItem(
          title: const Text("All clubs"),
          onPressed: () => onTap(currentTabIndex),
        ),
        FocusedMenuItem(
          title: const Text("Subscribed"),
          onPressed: () => onTap(currentTabIndex),
        ),
        FocusedMenuItem(
          title: const Text("Unsubscribed"),
          onPressed: () => onTap(currentTabIndex),
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
