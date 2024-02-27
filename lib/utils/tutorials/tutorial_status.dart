import 'package:flutter/foundation.dart';

class TutorialStatus {
  static final ValueNotifier<bool> isGuideRunningNotifier =
      ValueNotifier<bool>(false);

  TutorialStatus._();

  static final TutorialStatus _instance = TutorialStatus._();

  factory TutorialStatus() {
    return _instance;
  }
}
