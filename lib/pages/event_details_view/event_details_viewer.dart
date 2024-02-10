import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/club/club_model.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/pages/event_details_view/widgets/contributors.dart';
import 'package:efficacy_user/pages/event_details_view/widgets/event_registration_button.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'widgets/event_stats.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetailsViewer extends StatelessWidget {
  static const String routeName = "/eventDetails";
  const EventDetailsViewer({
    super.key,
    required this.currentEvent,
  });
  final EventModel? currentEvent;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
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
                StreamBuilder(
                    stream: ClubController.get(id: currentEvent!.clubID),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        List<ClubModel> club = snapshot.data;

                        if (club.isNotEmpty) {
                          return Row(
                            children: [
                              Text(
                                "Club: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: dark,
                                        fontWeight: FontWeight.w600),
                              ),
                              Text(
                                club.first.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: dark),
                              ),
                            ],
                          );
                        }
                      }
                      return const SizedBox();
                    }),
                const Text(
                  "When and Where",
                  style: TextStyle(
                    color: dark,
                    fontSize: 20,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          color: dark,
                          size: 25,
                        ),
                        Text(
                          "${dateFormatter.format(currentEvent!.startDate)} - ${dateFormatter.format(currentEvent!.endDate)}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: shadow,
                          ),
                        ),
                      ].separate(15),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: dark,
                          size: 25,
                        ),
                        Text(
                          currentEvent!.venue,
                          style: const TextStyle(
                            fontSize: 15,
                            color: shadow,
                          ),
                        ),
                      ].separate(15),
                    )
                  ].separate(10),
                ),
                const Text(
                  "About",
                  style: TextStyle(
                    color: dark,
                    fontSize: 20,
                  ),
                ),
                Text((currentEvent!.longDescription != null)
                    ? currentEvent!.longDescription!
                    : currentEvent!.shortDescription),
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
