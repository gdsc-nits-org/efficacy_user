import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/pages/event_details_view/widgets/contributors.dart';
import 'package:efficacy_user/pages/event_details_view/widgets/event_registration_button.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'widgets/event_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetailsViewer extends StatelessWidget {
  static const String routeName = "/eventDetails";
  const EventDetailsViewer({super.key, required this.currentEvent});
  final EventModel? currentEvent;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentEvent!.title,
                  style: TextStyle(
                    color: dark,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.094,
                  ),
                ),
                Text(currentEvent!.shortDescription),
              ].separate(15),
            ),
            Row(
              children: [
                if (currentEvent?.registrationLink != null &&
                    currentEvent!.registrationLink!.isNotEmpty)
                  Expanded(
                    child: EventRegistrationButton(
                      onTap: () {
                        showLoadingOverlay(
                            context: context,
                            asyncTask: () async {
                              await launchUrlString(
                                  currentEvent!.registrationLink!);
                            });
                      },
                      icon: Image.asset(
                        Assets.googleLogoImagePath,
                        height: 25,
                      ),
                      message: "Google Form",
                    ),
                  ),
                if (currentEvent?.facebookPostURL != null &&
                    currentEvent!.facebookPostURL!.isNotEmpty)
                  Expanded(
                    child: EventRegistrationButton(
                      onTap: () {
                        showLoadingOverlay(
                            context: context,
                            asyncTask: () async {
                              launchUrlString(currentEvent!.facebookPostURL!);
                            });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        size: 20,
                        color: dark,
                      ),
                      message: "Facebook",
                    ),
                  ),
              ].separate(8),
            ),
            const Text(
              "Event Stats",
              style: TextStyle(
                color: dark,
                fontSize: 20,
              ),
            ),
            EventStats(event: currentEvent!),
            if (currentEvent != null && currentEvent!.contacts.isNotEmpty)
              Contributors(
                contacts: currentEvent!.contacts,
                role: "Moderators",
              ),
          ].separate(20),
        ),
      ),
    );
  }
}
