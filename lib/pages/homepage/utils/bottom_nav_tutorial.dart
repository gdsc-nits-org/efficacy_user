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
      identify: "Edit Club",
      keyTarget: eventsKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Club",
              text: "Click here to edit club.",
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
      identify: "Edit Club Position",
      keyTarget: homeKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Club Position",
              text:
                  "Click to create and edit club positions and also view members in different positions of the club.",
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
      identify: "Invite",
      keyTarget: subKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Invite",
              text: "Click here to invite new members to the club.",
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
