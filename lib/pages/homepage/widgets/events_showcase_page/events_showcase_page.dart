import 'dart:math';

import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_card.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_user/controllers/controllers.dart';

class EventsShowcasePage extends StatefulWidget {
  final bool showSubscribedOnly;
  final ValueNotifier<int> currentEventFilterTypeIndex;
  const EventsShowcasePage({
    super.key,
    required this.showSubscribedOnly,
    required this.currentEventFilterTypeIndex,
  });

  @override
  State<EventsShowcasePage> createState() => _EventsShowcasePageState();
}

class _EventsShowcasePageState extends State<EventsShowcasePage> {
  late Stream<EventPaginationResponse> event;
  int skip = 0;

  final ScrollController _controller = ScrollController();
  Set<EventModel> events = {};
  int itemCount = 0;
  EventStatus? currentEventStatus;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          if (skip != -1) {
            event = EventController.getAllEvents(
              skip: skip,
              eventStatus: currentEventStatus,
            );
          }
        });
      }
    });
  }

  Future<void> _refreshEvents() async {
    setState(() {
      isLoading = true;
      events.clear();
      skip = 0;
    });
    EventPaginationResponse updatedEvent = await EventController.getAllEvents(
      skip: skip,
      forceGet: true,
      eventStatus: currentEventStatus,
    ).first;
    setState(() {
      isLoading = false;
      skip = updatedEvent.skip;
      events.addAll(updatedEvent.events);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.currentEventFilterTypeIndex,
        builder: (context, int currentEventFilterTypeIndex, _) {
          Size screen = MediaQuery.of(context).size;
          EventStatus status = EventStatus.values[currentEventFilterTypeIndex];
          if (status != currentEventStatus) {
            isLoading = true;
            currentEventStatus = status;
            skip = 0;
            events.clear();
            event = EventController.getAllEvents(
              skip: skip,
              eventStatus: currentEventStatus,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "${currentEventStatus?.name} Events",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: const Color.fromARGB(253, 82, 81, 81),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshEvents,
                  child: StreamBuilder(
                    stream: event,
                    builder: (context,
                        AsyncSnapshot<EventPaginationResponse> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                              "Some error occurred. Please restart the app"),
                        );
                      } else {
                        if (snapshot.hasData) {
                          EventPaginationResponse? response = snapshot.data;
                          if (response != null) {
                            if (response.events.isEmpty) {
                              isLoading = false;
                            } else {
                              EventModel testData = response.events.first;
                              if (testData.type == currentEventStatus) {
                                isLoading = false;
                              }
                            }
                          }
                        }
                        if (isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.data != null) {
                          skip = snapshot.data!.skip;
                          events.addAll(snapshot.data!.events);
                        }

                        List<EventModel> filteredList = events.toList();
                        if (widget.showSubscribedOnly) {
                          filteredList = events
                              .where((event) => UserController
                                  .currentUser!.following
                                  .contains(event.clubID))
                              .toList();
                        }
                        itemCount = filteredList.length;
                        return ListView.builder(
                          controller: _controller,
                          itemCount: max(1, itemCount + 1),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (itemCount == 0) {
                              return SizedBox(
                                width: screen.width,
                                height: screen.height * .7,
                                child:
                                    const Center(child: Text("No event found")),
                              );
                            } else if (index == itemCount) {
                              return SizedBox(
                                width: 40,
                                height: 40,
                                child: skip != -1
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : null,
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: EventCard(
                                  item: snapshot.data != null
                                      ? filteredList[index]
                                      : null),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          );
        });
  }
}
