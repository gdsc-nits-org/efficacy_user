import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showSubFilterTutorial(BuildContext context, GlobalKey filterKeySubPage) {
  List<TargetFocus> targets = getTargets(filterKeySubPage);
  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getTargets(
    GlobalKey filterKeySubPage) {
  return [
    TargetFocus(
      identify: "Filter Events",
      keyTarget: filterKeySubPage,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Filter Events",
              text: "Click here to filter subscribed, unsubscribed and all clubs.",
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
    )
  ];
}
