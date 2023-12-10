import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_list.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_viewer.dart';
import 'package:efficacy_user/pages/homepage/widgets/home_appbar/home_appbar.dart';
import 'package:efficacy_user/widgets/custom_bottom_navigation/custom_bottom_navigation.dart';
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
  int currentBottomIndex = 0;

  void navigator(Status buttonMessage) {
    setState(() {
      currentTabIndex = Status.values.indexOf(buttonMessage);
    });
  }

  void bottonNavigator(int index) {
    setState(() {
      currentBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(navigator: navigator, currentTabIndex: currentTabIndex),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: currentBottomIndex,
        onTap: bottonNavigator,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "${Status.values[currentTabIndex].toString().split('.').last} Events",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Color.fromARGB(253, 82, 81, 81),
                fontWeight: FontWeight.w500,
              ),
            ),
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
