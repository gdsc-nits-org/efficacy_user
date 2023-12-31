import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/club/club_model.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/widgets/clubs/club_stream.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/widgets/filter_button.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({
    super.key,
  });

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int filterIndex = 0;

  void _toggleSubscription(ClubModel club) async {
    showLoadingOverlay(
      context: context,
      asyncTask: () async {
        await UserController.toggleFollowClub(clubID: club.id!);
      },
      onCompleted: () => setState(() {}),
    );
  }

  void _changeIndex(int index) {
    setState(() {
      filterIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "Subscriptions",
                style: TextStyle(
                  fontSize: width * 0.08,
                  color: const Color.fromARGB(253, 82, 81, 81),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Filters",
                style: TextStyle(
                  fontSize: width * 0.06,
                  color: const Color.fromARGB(253, 82, 81, 81),
                  fontWeight: FontWeight.w500,
                ),
              ),
              FilterButton(
                onTap: _changeIndex,
                currentTabIndex: filterIndex,
              ),
            ].separate(10),
          ),
          ClubsStream(
            onToggle: _toggleSubscription,
            filterIndex: filterIndex,
          ),
        ],
      ),
    );
  }
}
