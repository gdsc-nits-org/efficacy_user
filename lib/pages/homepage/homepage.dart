import 'dart:async';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/utils/tutorials/tutorials.dart';
import 'package:efficacy_user/pages/homepage/widgets/events_showcase_page/events_showcase_page.dart';
import 'package:efficacy_user/pages/homepage/widgets/home_appbar/home_appbar.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/subscription_page.dart';
import 'package:efficacy_user/widgets/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:efficacy_user/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";

  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //keys for guide
  GlobalKey exploreKey = GlobalKey();
  GlobalKey homeKey = GlobalKey();
  GlobalKey subKey = GlobalKey();
  GlobalKey filterKeyHomePage = GlobalKey();

  GlobalKey reportBugKey = GlobalKey();

  GlobalKey drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // To view guide everytime uncomment the next line
    // LocalDatabase.resetGuideCheckpoint();
    if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.bottomNav)) {
      TutorialStatus.isGuideRunningNotifier.value = true;
      Future.delayed(
        const Duration(seconds: 0),
        () {
          showBottomNavTutorial(
            context,
            exploreKey,
            homeKey,
            subKey,
            drawerKey,
            onFinish: () {
              TutorialStatus.isGuideRunningNotifier.value = false;
              if (LocalDatabase.getAndSetGuideStatus(
                  LocalGuideCheck.homeFilter)) {
                TutorialStatus.isGuideRunningNotifier.value = true;
                showFilterTutorial(
                  context,
                  filterKeyHomePage,
                  onFinish: () {
                    TutorialStatus.isGuideRunningNotifier.value = false;
                  },
                  onSkip: () {
                    TutorialStatus.isGuideRunningNotifier.value = false;
                    // Returning true to allow skip
                    return true;
                  },
                );
              }
            },
            onSkip: () {
              TutorialStatus.isGuideRunningNotifier.value = false;
              // Returning true to allow skip
              return true;
            },
          );
        },
      );
    } else if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.homeFilter)) {
      TutorialStatus.isGuideRunningNotifier.value = true;
      Future.delayed(
        const Duration(seconds: 0),
        () {
          showFilterTutorial(
            context,
            filterKeyHomePage,
            onFinish: () {
              TutorialStatus.isGuideRunningNotifier.value = false;
            },
            onSkip: () {
              TutorialStatus.isGuideRunningNotifier.value = false;

              // Returning true to allow skip
              return true;
            },
          );
        },
      );
    }
  }

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (!TutorialStatus.isGuideRunningNotifier.value) {
          final bool shouldPop = await showExitWarning(context);
          if (shouldPop) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        appBar: HomeBar(
          drawerKey: drawerKey,
          filterKeyHomePage: filterKeyHomePage,
          navigator: navigator,
          currentTabIndex: currentEventFilterTypeIndex.value,
          currentBottomIndex: currentBottomIndex,
        ),
        endDrawer: CustomDrawer(
          pageContext: context,
        ),
        bottomNavigationBar: CustomBottomNavigation(
          exploreKey: exploreKey,
          subKey: subKey,
          homeKey: homeKey,
          currentIndex: currentBottomIndex,
          onTap: bottomNavigator,
        ),
        body: currentBottomIndex == 2
            ? const SubscriptionPage()
            : EventsShowcasePage(
                showSubscribedOnly: currentBottomIndex == 1,
                currentEventFilterTypeIndex: currentEventFilterTypeIndex,
              ),
      ),
    );
  }
}
