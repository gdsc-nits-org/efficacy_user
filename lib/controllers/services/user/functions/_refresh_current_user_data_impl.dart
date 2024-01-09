part of '../user_controller.dart';

Future<UserModel?> _refreshCurrentUserDataImpl() async {
  if (UserController.currentUser == null) return null;
  List<UserModel> users = await UserController.get(
    email: UserController.currentUser!.email,
    forceGet: true,
  ).first;
  if (users.isNotEmpty) {
    UserController.currentUser = users.first;
    await UserController._gatherData();
    return UserController.currentUser;
  }
  return null;
}
