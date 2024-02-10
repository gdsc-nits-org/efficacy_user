import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/club/club_model.dart';
import 'package:efficacy_user/utils/tutorials/filter_sub_tutorial.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/widgets/clubs/club_stream.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/widgets/filter_button.dart';
import 'package:flutter/material.dart';

import '../../../../utils/local_database/local_database.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({
    super.key,
  });

  @override
  State<SubscriptionPage> createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  GlobalKey filterKeySubPage = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.subFilter)) {
      Future.delayed(const Duration(seconds: 1), () {
        showSubFilterTutorial(context, filterKeySubPage);
      });
    }
  }
  int filterIndex = 0;

  late Stream<List<ClubModel>> clubStream =
      ClubController.get(instituteName: "NIT, Silchar");

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
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            clubStream = ClubController.get(
              instituteName: "NIT, Silchar",
              forceGet: true,
            );
          });
        },
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
                  key: filterKeySubPage,
                  onTap: _changeIndex,
                  currentTabIndex: filterIndex,
                ),
              ].separate(10),
            ),
            ClubsStream(
              onToggle: _toggleSubscription,
              filterIndex: filterIndex,
              clubStream: clubStream,
            ),
          ],
        ),
      ),
    );
  }
}
