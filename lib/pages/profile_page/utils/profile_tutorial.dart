import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showProfileTutorial(BuildContext context, GlobalKey editProfileKey,
    GlobalKey deleteProfileKey) {
  List<TargetFocus> targets = getTargets(
    editProfileKey,
    deleteProfileKey,
  );

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getTargets(
  GlobalKey editProfileKey,
  GlobalKey deleteProfileKey,
) {
  return [
    TargetFocus(
      identify: "Edit Profile",
      keyTarget: editProfileKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Profile",
              text: "Click here to edit profile.",
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
      identify: "Delete Profile",
      keyTarget: deleteProfileKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Delete Profile",
              text: "Click here to delete your profile.",
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
