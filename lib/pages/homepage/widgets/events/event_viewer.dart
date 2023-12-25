import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/controllers/services/event/event_controller.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_card.dart';
import 'package:efficacy_user/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventViewer extends StatelessWidget {
  final int typeIndex;
  final int currentBottomIndex;
  const EventViewer({
    super.key,
    required this.typeIndex,
    required this.currentBottomIndex,
  });

  @override
  Widget build(BuildContext context) {
    Stream<EventPaginationResponse> eventStream =
        EventController.getAllEvents();
    return StreamBuilder(
      stream: eventStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Error state
          showErrorSnackBar(context, 'Error: ${snapshot.error}');
          throw Exception('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          // Empty data state
          return const Text('No clubs available for NIT Silchar');
        } else {}
        // Data available
        final events = snapshot.data!.events;
        final subscribedEvents = events
            .where((event) =>
                UserController.currentUser!.following.contains(event.clubID))
            .toList();
        List<EventModel> specificList =
            currentBottomIndex == 0 ? events : subscribedEvents;
        List<EventModel> displayList = specificList
            .where(
                (element) => Status.values.indexOf(element.type) == typeIndex)
            .toList();

        return Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 17.0),
            child: ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final item = displayList[index];
                return GestureDetector(
                  onTap: () {}, // to card_pressed_screen
                  child: EventCard(item: item),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
