import 'dart:async';
import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_card.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_list.dart';
import 'package:efficacy_user/pages/homepage/widgets/events_showcase_page/events_showcase_page.dart';
import 'package:efficacy_user/pages/homepage/widgets/home_appbar/home_appbar.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/subscription_page.dart';
import 'package:efficacy_user/widgets/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:efficacy_user/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentTabIndex = 0;
  ValueNotifier<int> currentEventFilterTypeIndex = ValueNotifier(0);
  int currentBottomIndex = 1;

  void navigator(EventStatus buttonMessage) {
    setState(() {
      currentEventFilterTypeIndex.value =
          EventStatus.values.indexOf(buttonMessage);
    });
  }

  void bottomNavigator(int index) {
    setState(() {
      currentBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(
        navigator: navigator,
        currentTabIndex: currentEventFilterTypeIndex.value,
        currentBottomIndex: currentBottomIndex,
      ),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: currentBottomIndex,
        onTap: bottomNavigator,
      ),
      body: currentBottomIndex == 2
          ? const SubscriptionPage()
          : EventsShowcasePage(
              showSubscribedOnly: currentBottomIndex == 1,
              currentEventFilterTypeIndex: currentEventFilterTypeIndex,
            ),
    );
  }
}
