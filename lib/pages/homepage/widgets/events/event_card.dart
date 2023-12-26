import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/models/event/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../utils/utils.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.item,
  });
  final EventModel? item;
  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Stack(children: [
        Card(
          child: Column(
            children: [
              Gap(10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: (item!.posterURL != null)?Image.asset(
                  "assets/images/media.png",
                  fit: BoxFit.cover,
                ):Image.network(item!.posterURL),
              //   // child: CustomNetworkImage(
              //   //   posterUrl: item.posterURL,
              //   //   defaultUrl: "",
              //   // ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 28.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item!.title,
                    style: const TextStyle(
                      color: Color.fromARGB(253, 82, 81, 81),
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28.0,
                  bottom: 25.0,
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.calendar,
                          color: shadow,
                          size: 16,
                        ),
                        Text(
                          _dateFormatter.format(item!.startDate),
                          style: const TextStyle(
                            fontSize: 15,
                            color: shadow,
                          ),
                        ),
                      ].separate(10),
                    ),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.clock,
                          color: shadow,
                          size: 16,
                        ),
                        Text(
                          Formatter.timeOnly(item!.endDate),
                          style: const TextStyle(
                            fontSize: 15,
                            color: shadow,
                          ),
                        ),
                      ].separate(10),
                    ),
                  ].separate(20),
                ),
              )
            ].separate(5),
          ),
        ),
        Positioned(
          top: 295,
          left: width * 0.41,
          child: const Icon(
            CupertinoIcons.arrow_down_circle_fill,
            size: 30,
            color: Color.fromARGB(253, 82, 81, 81),
          ),
        )
      ]),
    );
  }
}
