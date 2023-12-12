import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventViewer extends StatelessWidget {
  final List<EventModel> events;
  final int typeIndex;
  const EventViewer({
    super.key,
    required this.typeIndex,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    List<EventModel> specificList = events
        .where((element) => Status.values.indexOf(element.type) == typeIndex)
        .toList();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 17.0),
        child: ListView.builder(
          itemCount: specificList.length,
          itemBuilder: (context, index) {
            final item = specificList[index];
            return GestureDetector(
              onTap: () {}, // to card_pressed_screen
              child: EventCard(item: item),
            );
          },
        ),
      ),
    );
  }
}
