import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class PopUpButton extends StatelessWidget {
  const PopUpButton({
    super.key,
    required this.onTap,
    required this.currentTabIndex,
  });
  final Function(EventStatus) onTap;
  final int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 2.0,
      openWithTap: true,
      onPressed: () {},
      menuItems: EventStatus.values
          .map(
            (status) => FocusedMenuItem(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  status.toString().split('.').last,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
              ),
              backgroundColor: currentTabIndex == EventStatus.values.indexOf(status)
                  ? const Color(0xFFADECFF)
                  : null,
              onPressed: () => onTap(status),
            ),
          )
          .toList(),
      child: Icon(
        Icons.filter_alt_outlined,
        size: MediaQuery.of(context).size.width * 0.1,
        color: dark,
      ),
    );
  }
}
