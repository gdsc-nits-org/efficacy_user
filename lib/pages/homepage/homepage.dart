import 'dart:async';
import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_card.dart';
import 'package:efficacy_user/pages/homepage/widgets/events/event_list.dart';
import 'package:efficacy_user/pages/homepage/widgets/home_appbar/home_appbar.dart';
import 'package:efficacy_user/pages/homepage/widgets/subscription_page/subscription_page.dart';
import 'package:efficacy_user/widgets/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:efficacy_user/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const Homepage({super.key,});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Stream<EventPaginationResponse> event = EventController.getAllEvents();
  int skip = 0;
  
  final ScrollController _controller = ScrollController();
  List<EventModel> events = [];
  int itemCount = 0;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        const Center(child: CircularProgressIndicator(),);
        event = EventController.getAllEvents(skip: skip);
        setState(() {
        });
        print("more");
      }
     });
  }

  int currentTabIndex = 0;
  int currentEventFilterTypeIndex = 0;
  int currentBottomIndex = 1;
  
  void navigator(Status buttonMessage) {
    setState(() {
      currentEventFilterTypeIndex = Status.values.indexOf(buttonMessage);
    });
  }

  void bottomNavigator(int index) {
    setState(() {
      currentBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(
        navigator: navigator,
        currentTabIndex: currentEventFilterTypeIndex,
        currentBottomIndex: currentBottomIndex,
      ),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: currentBottomIndex,
        onTap: bottomNavigator,
      ),
      body: currentBottomIndex == 2
          ? SubscriptionPage(
              currentBottomIndex: currentBottomIndex,
              bottomNavigator: bottomNavigator,
            )
          : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "${Status.values[currentTabIndex].toString().split('.').last} Events",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: Color.fromARGB(253, 82, 81, 81),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: event,
                  builder: (context,
                      AsyncSnapshot<EventPaginationResponse> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    else if (!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else {
                      if(snapshot.data != null){
                        if(skip != snapshot.data!.skip){
                          skip = snapshot.data!.skip;
                          events.addAll(snapshot.data!.events);
                        }
                      }
                      itemCount = events.length;
                      return ListView.builder(
                          controller: _controller,
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: EventCard(item: snapshot.data != null? events[index] : null),
                            );
                          }
                        );
                      } 
                    }
                  ),
            )
          ],
        )
    );
  }
}
