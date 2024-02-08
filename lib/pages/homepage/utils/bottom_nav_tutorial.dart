import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showBottomNavTutorial(BuildContext context, GlobalKey eventsKey,
    GlobalKey homeKey, GlobalKey subKey) {
  List<TargetFocus> targets = getTargets(eventsKey, homeKey, subKey);
  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getTargets(
    GlobalKey eventsKey, GlobalKey homeKey, GlobalKey subKey) {
  return [
    TargetFocus(
      identify: "Events Page",
      keyTarget: eventsKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Events",
              text: "Click here to view events page",
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
              heading: "Home Page",
              text:
                  "Click here to view home page",
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
      identify: "Subs Page",
      keyTarget: subKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Subscriptions Page",
              text: "Click here to view your subscribed clubs.",
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
  ];
}
