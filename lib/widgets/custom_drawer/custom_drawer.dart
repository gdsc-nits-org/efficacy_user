import 'dart:io';

import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:efficacy_user/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late bool pendingInvites = false;

  @override
  void initState() {
    // TODO : integrate with backend
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    //size constants
    double gap = height * 0.02;

    // Get current route name
    var route = ModalRoute.of(context);
    String? routeName;

    if (route != null) {
      // debugPrint(route.settings.name);
      routeName = route.settings.name;
    }
    return Drawer(
      backgroundColor: light,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfilePage.routeName);
            },
            child: AbsorbPointer(
              child: DrawerHeader(
                decoration: const BoxDecoration(color: dark),
                child: ProfileImageViewer(
                  enabled: false,
                  imagePath: UserController.currentUser?.userPhoto,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            selected: routeName == "/homePage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Home page
              Navigator.of(context).pushNamed(
                Homepage.routeName,
              );
            },
          ),
          ListTile(
            title: const Text('Organizations'),
            trailing: pendingInvites ? const Text("NEW") : null,
            selected: routeName == "/OrganizationsPage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () async {
              await UserController.logOut();

              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.routeName,
                  (route) => false,
                );
              }
            },
          ),
        ].separate(gap),
      ),
    );
  }
}
