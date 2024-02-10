import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../widgets/coach_mark_desc/coach_mark_desc.dart';

void showProfileTutorial(
  BuildContext context,
  GlobalKey editProfileKey,
  GlobalKey deleteProfileKey,
  ScrollController scrollController, {
  void Function()? onFinish,
}) {
  List<TargetFocus> targets = getProfileTargets(
    context,
    editProfileKey,
    deleteProfileKey,
    scrollController,
  );

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
  ).show(context: context);
}

List<TargetFocus> getProfileTargets(
  BuildContext parentContext,
  GlobalKey editProfileKey,
  GlobalKey deleteProfileKey,
  ScrollController scrollController,
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
              parentContext: parentContext,
              heading: "Edit Profile",
              text: "Click here to edit profile.",
              onNext: () {
                RenderBox renderBox = deleteProfileKey.currentContext!
                    .findRenderObject() as RenderBox;
                Offset position = renderBox.localToGlobal(Offset.zero);
                scrollController.animateTo(
                  position.dy,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutExpo,
                );
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
              parentContext: parentContext,
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
