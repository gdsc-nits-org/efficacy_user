import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showBottomNavTutorial(
  BuildContext context,
  GlobalKey drawerKey,
  GlobalKey eventsKey,
  GlobalKey homeKey,
  GlobalKey subKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getBottomNavTargets(
    context,
    drawerKey,
    eventsKey,
    homeKey,
    subKey,
  );
  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getBottomNavTargets(
  BuildContext parentContext,
  GlobalKey eventsKey,
  GlobalKey homeKey,
  GlobalKey subKey,
  GlobalKey drawerKey,
) {
  return [
    TargetFocus(
      identify: "Events Page",
      keyTarget: eventsKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Explore",
              text: "Click here to explore the events of all the clubs.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Home Page",
      keyTarget: homeKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Home",
              text: "Click here to view events of your subscribed clubs.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Subscriptions",
      keyTarget: subKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Subscriptions",
              text: "Click here to view clubs and subscribe them.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        ),
      ],
    ),
    TargetFocus(
      identify: "Drawer",
      keyTarget: drawerKey,
      contents: [
        TargetContent(
          // align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Menu",
              text: "Click to navigate between pages and see more options.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
  ];
}
