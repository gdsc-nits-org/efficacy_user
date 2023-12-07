import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_list.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_viewer.dart';
import 'package:efficacy_user/pages/homepage/widgets/tab_navigation/tab_view.dart';
import 'package:efficacy_user/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_user/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentTabIndex = 0;

  void navigator(Status buttonMessage) {
    setState(() {
      currentTabIndex = Status.values.indexOf(buttonMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomDrawer(),
      body: Column(
        children: [
          TabView(
            currentTabIndex: currentTabIndex,
            navigator: navigator,
          ),
          EventViewer(
            typeIndex: currentTabIndex,
            events: eventList,
          ),
        ].separate(26),
      ),
    );
  }
}
