part of '../user_controller.dart';

Future<void> _toggleFollowClubImpl({required String clubID}) async {
  if (UserController.currentUser?.id == null) {
    throw Exception("Please Login first");
  }
  List<String> followedClubs = List.of(UserController.currentUser!.following);
  if (followedClubs.contains(clubID)) {
    followedClubs.removeWhere((String id) => id == clubID);
  } else {
    followedClubs.add(clubID);
  }
  try {
    await ClubController.toggleFollow(clubID: clubID);
  } catch (e) {
    rethrow;
  }
  UserController.currentUser = UserController.currentUser!.copyWith(
    following: followedClubs,
  );
  await UserController.update();
}
