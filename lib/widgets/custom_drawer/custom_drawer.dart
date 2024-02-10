import 'dart:io';

import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:efficacy_user/utils/database/constants.dart';
import 'package:efficacy_user/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  void showFeedback() {
    BetterFeedback.of(context).show(
      sendFeedback(
        projectId: dotenv.env[EnvValues.GITLAB_ID.name]!,
        apiToken: dotenv.env[EnvValues.GITLAB_TOKEN.name]!,
        gitlabUrl: null,
        client: null,
      ),
    );
  }

  OnFeedbackCallback sendFeedback({
    required String projectId,
    required String apiToken,
    String? gitlabUrl,
    http.Client? client,
  }) {
    final httpClient = client ?? http.Client();
    final baseUrl = gitlabUrl ?? 'gitlab.com';

    return (UserFeedback feedback) async {
      final uri = Uri.https(
        baseUrl,
        '/api/v4/projects/$projectId/uploads',
      );
      final uploadRequest = http.MultipartRequest('POST', uri)
        ..headers.putIfAbsent('PRIVATE-TOKEN', () => apiToken)
        ..fields['id'] = projectId
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          feedback.screenshot,
          filename: 'feedback.png',
          contentType: MediaType('image', 'png'),
        ));

      final uploadResponse = await httpClient.send(uploadRequest);

      final dynamic uploadResponseMap = jsonDecode(
        await uploadResponse.stream.bytesToString(),
      );

      final imageMarkdown = uploadResponseMap["markdown"] as String?;
      final extras = feedback.extra?.toString() ?? '';

      final description = '${feedback.text}\n'
          '${imageMarkdown ?? 'Missing image!'}\n'
          '$extras';

      // Create issue
      await httpClient.post(
        Uri.https(
          baseUrl,
          '/api/v4/projects/$projectId/issues',
          <String, String>{
            'title':
                "${feedback.text} - ${UserController.currentUser!.name} - ${UserController.currentUser!.email}",
            'description': description,
          },
        ),
        headers: {'PRIVATE-TOKEN': apiToken},
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("Efficacy has reported the bug to the team"),
      //   ),
      // );
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
            onTap: showFeedback,
          ),
          ListTile(
            leading: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            leading: const Icon(Icons.developer_mode),
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
