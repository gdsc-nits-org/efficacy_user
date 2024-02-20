import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showSubFilterTutorial(
  BuildContext context,
  GlobalKey filterKeySubPage, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getSubFilterTargets(context, filterKeySubPage);
  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getSubFilterTargets(
  BuildContext parentContext,
  GlobalKey filterKeySubPage,
) {
  return [
    TargetFocus(
      identify: "Filter Events",
      keyTarget: filterKeySubPage,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Filter Events",
              text:
                  "Click here to filter subscribed, unsubscribed and all clubs.",
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
