import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/services/event/event_controller.dart';
import 'package:efficacy_user/controllers/services/user/user_controller.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/utils/share_handler.dart';
import 'package:efficacy_user/widgets/snack_bar/error_snack_bar.dart';
import 'stats_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventStats extends StatefulWidget {
  final EventModel event;
  const EventStats({super.key, required this.event});

  @override
  State<EventStats> createState() => _EventStatsState();
}

class _EventStatsState extends State<EventStats> {
  late EventModel event;

  void toggleLike() {
    List<String> liked = List.from(event.liked);

    if (UserController.currentUser != null) {
      // For faster response as soon as the user presses the like button
      // it is reflected on the frontend side.
      //
      // Once the backend completes its work it then updates the state
      // confirming the final state
      String email = UserController.currentUser!.email;
      bool couldRemove = liked.remove(email);
      if (!couldRemove) {
        liked.add(email);
      }
      EventController.toggleLike(userEmail: email, event: event)
          .then((updatedEvent) async {
        // The delay ensures that both the event update (local and with backend)
        // never happen simultaneously else it would cause 2 time screen update
        // which might crash the widget
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          event = updatedEvent;
        });
      });
      setState(() {
        event = event.copyWith(liked: liked);
      });
    } else {
      showSnackBar(context, "Please log in again");
    }
  }

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton(
              onPressed: toggleLike,
              icon: event.liked.contains(UserController.currentUser?.email)
                  ? const Icon(
                      Icons.thumb_up,
                      color: light,
                    )
                  : const Icon(
                      Icons.thumb_up_outlined,
                    ),
            ),
            StatsInfo(
              message: "${event.liked.length}",
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              CupertinoIcons.calendar,
              color: dark,
              size: 40,
            ),
            StatsInfo(
              message: DateFormat("d MMM").format(event.startDate),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                showLoadingOverlay(
                    context: context,
                    asyncTask: () async {
                      await ShareHandler.shareEvent(event);
                    });
              },
              icon: const Icon(Icons.share),
            ),
            const StatsInfo(message: "Share")
          ],
        )
      ].separate(35),
    );
  }
}
