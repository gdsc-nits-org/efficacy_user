part of '../user_controller.dart';

Future<UserModel?> _updateImpl(String? password) async {
  if (UserController.currentUser == null) {
    throw Exception("Please Login");
  }
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);

  List<UserModel> oldData = await UserController.get(
    email: UserController.currentUser!.email,
    forceGet: true,
  ).first;
  if (oldData.isEmpty) {
    throw Exception("Couldn't find user");
  } else {
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(UserFields.app.name, appName);
    selectorBuilder.eq(
        UserFields.email.name, UserController.currentUser!.email);
    if (password == null) {
      await collection.updateOne(
        selectorBuilder,
        compare(
          oldData.first.toJson(),
          UserController.currentUser!.toJson(),
          // ignore: [UserFields.password.name, UserFields.email.name],
          ignore: [
            UserFields.email.name,
            UserFields.password.name,
          ],
        ).map,
      );
    } else {
      await collection.updateOne(
        selectorBuilder,
        compare(
          oldData.first.toJson(),
          UserController.currentUser!.toJson(),
          // ignore: [UserFields.password.name, UserFields.email.name],
          ignore: [
            UserFields.email.name,
            UserFields.name.name,
            UserFields.phoneNumber.name,
            UserFields.scholarID.name,
            UserFields.userPhoto.name,
            UserFields.branch.name,
            UserFields.degree.name,
            UserFields.socials.name,
            UserFields.app.name,
            UserFields.positions.name,
            UserFields.following.name
          ],
        ).map,
      );
    }
    UserController.currentUser =
        (await UserController._save(user: UserController.currentUser))!;
    return UserController.currentUser;
  }
}
