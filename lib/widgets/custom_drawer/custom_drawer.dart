import 'dart:io';
import 'dart:typed_data';

import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:efficacy_user/utils/database/constants.dart';
import 'package:efficacy_user/utils/local_database/local_database.dart';
import 'package:efficacy_user/utils/tutorials/report_bug_tutorial.dart';
import 'package:efficacy_user/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_user/widgets/snack_bar/error_snack_bar.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'utils/get_feedback_data.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late bool pendingInvites = false;

  OnFeedbackCallback sendFeedback() {
    return (UserFeedback feedback) async {
      await showLoadingOverlay(
        context: context,
        asyncTask: () async {
          Uint8List data = await getFeedBackData(feedback);
          DateTime now = DateTime.now();
          await ImageController.uploadImage(
            img: data,
            folder: ImageFolder.feedback,
            name: now.toIso8601String(),
          );
          showErrorSnackBar(
            context,
            "Your feedback was shared, Thank you for your feedback.",
          );
        },
      );
    };
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
          Container(
            height: height * 0.33,
            decoration: const BoxDecoration(color: dark),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
              child: AbsorbPointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ProfileImageViewer(
                      enabled: false,
                      imagePath: UserController.currentUser?.userPhoto,
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: light,
                          foregroundColor: dark,
                        ),
                        child: const Text("Profile"),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ].separate(15),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: routeName == "/homePage"
                  ? Theme.of(context).scaffoldBackgroundColor
                  : dark,
            ),
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
            leading: const Icon(
              Icons.bug_report_outlined,
              color: dark,
            ),
            title: const Text(
              'Report Bug',
              style: TextStyle(color: Colors.black87),
            ),
            onTap: () async {
              if (LocalDatabase.getAndSetGuideStatus(
                  LocalGuideCheck.reportBug)) {
                await showReportBugTutorial(context);
              }
              BetterFeedback.of(context).show(sendFeedback());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.developer_mode,
              color: routeName == "/developersPage"
                  ? Theme.of(context).scaffoldBackgroundColor
                  : dark,
            ),
            title: const Text('Developers'),
            selected: routeName == "/developersPage",
            selectedColor: light,
            selectedTileColor: dark,
            onTap: () {
              // Close the drawer
              Navigator.pop(context);
              // Navigate to Home page
              Navigator.of(context).pushNamed(
                DevelopersPage.routeName,
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.red),
            ),
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
