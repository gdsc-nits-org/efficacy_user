import 'package:efficacy_user/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showReportBugTutorial(
  BuildContext context,
  GlobalKey reportBugKey,
  void Function()? onFinish,
) {}

List<TargetFocus> getTargets(BuildContext context, GlobalKey reportBugKey) {
  return [
    TargetFocus(
      identify: "Report Bug",
      keyTarget: reportBugKey,
      contents: [
        TargetContent(
          align: ContentAlign.left,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: context,
              heading: "Report Bugs",
              text: "Click here to report a bug.",
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
