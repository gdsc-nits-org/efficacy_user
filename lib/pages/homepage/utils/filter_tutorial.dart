import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showFilterTutorial(BuildContext context, GlobalKey filterKeyHomePage) {
  List<TargetFocus> targets = getTargets(filterKeyHomePage);
  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getTargets(
    GlobalKey filterKeyHomePage) {
  return [
    TargetFocus(
      identify: "Filter Events",
      keyTarget: filterKeyHomePage,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Filter Events",
              text: "Click here to filter upcoming, ongoing and completed events",
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
