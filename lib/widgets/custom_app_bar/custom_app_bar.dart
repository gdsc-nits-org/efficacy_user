import 'package:efficacy_user/config/configurations/assets/assets.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget> actions;
  const CustomAppBar({
    super.key,
    this.title,
    this.actions = const [],
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String _displayedTitle;

  @override
  void initState() {
    // TODO: implement initState
    // init();
    super.initState();
    _displayedTitle = widget.title ?? 'Efficacy';
  }

  void updateAppBar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    //size constants
    final double avatarRadius = width * 0.25;
    const double pad = 8.0;

    return AppBar(
      surfaceTintColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(pad),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          radius: avatarRadius,
          child: Image.asset(Assets.efficacyUserLogoImagePath),
        ),
      ),
      title: Text(
        _displayedTitle,
        style: const TextStyle(
          color: Color(0xFF05354C),
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      // Removing the default back button
      automaticallyImplyLeading: false,
      // Editing the back button (back button not responsive on all pages due to navigation)
      // leading: const BackButton(
      //     style:
      //         ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent),)),
      actions: [
        ...widget.actions,
        Stack(
          children: [
            // App drawer button
            IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
