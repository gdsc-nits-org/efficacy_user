part of '../club_controller.dart';

Future<void> _toggleFollowImpl({required String clubID}) async {
  if (UserController.currentUser?.id == null) {
    throw Exception("Please Login first");
  }
  List<ClubModel> clubs =
      await ClubController.get(id: clubID, forceGet: true).first;
  if (clubs.isEmpty) {
    throw Exception("Couldn't find club'");
  }
  ClubModel club = clubs.first;
  List<String> followers = List.of(club.followers);
  String userID = UserController.currentUser!.id!;
  if (followers.contains(userID)) {
    followers.removeWhere((String id) => id == userID);
  } else {
    followers.add(userID);
  }
  await ClubController.update(club.copyWith(followers: followers));
}
