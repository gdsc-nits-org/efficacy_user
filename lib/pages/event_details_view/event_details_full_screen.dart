import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:efficacy_user/pages/event_details_view/event_details_viewer.dart';
import 'package:efficacy_user/pages/event_details_view/widgets/photo_viewer.dart';
import 'package:efficacy_user/utils/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventFullScreen extends StatefulWidget {
  static const String routeName = "/eventFullScreen";
  final EventModel? currentEvent;
  const EventFullScreen({super.key, required this.currentEvent});

  @override
  State<EventFullScreen> createState() => _EventFullScreenState();
}

class _EventFullScreenState extends State<EventFullScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: SlidingUpPanel(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                ),
                Container(
                  height: 4,
                  width: screenWidth * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 30),
            maxHeight: screenHeight,
            minHeight: screenHeight * 0.63,
            panel: EventDetailsViewer(currentEvent: widget.currentEvent),
            body: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EventPosterViewer(currentEvent: widget.currentEvent!)));
              },
              child: widget.currentEvent == null
                  ? Column(
                      children: [ 
                        Image.asset(
                            Assets.mediaImgPath,
                          ),
                      ],
                    )
                  : widget.currentEvent?.posterURL == null ||
                          widget.currentEvent!.posterURL.isEmpty
                      ? Column(
                          children: [
                            Image.asset(
                              Assets.mediaImgPath,
                              fit: BoxFit.cover,
                            ),
                          ],
                        )
                      :SizedBox(
                          child: CustomNetworkImage(
                        url: widget.currentEvent!.posterURL)
                        ,)
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 35,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: dark,
                child: Icon(
                  Icons.close,
                  size: screenHeight * 0.035,
                  color: light,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
