import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/models/models.dart';

///list of events of class EventModel
// List<EventModel> eventList = [
//   EventModel(
//     posterURL:
//         "https://t3.ftcdn.net/jpg/05/85/86/44/360_F_585864419_kgIYUcDQ0yiLOCo1aRjeu7kRxndcoitz.jpg",
//     title: "Title",
//     shortDescription:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit euismod e ullamcorper in mag meaning in non ",
//     startDate: DateTime.now(),
//     endDate: DateTime.now().add(Duration(days: 10)),
//     registrationLink: "",
//     venue: "Venue",
//     contacts: ["+918473083589"],
//     clubID: "123",
//   )
// ];

List<EventModel> eventList = [];
//     EventController.get(clubID: clubList.map((club) => club.id).toList())
//         as List<EventModel>;


List<EventModel> subscribedList = [];

// List<EventModel> subscribedList = eventList
//     .where((element) => userClubList
//         .map((favorites) => favorites.id)
//         .toList()
//         .contains(element.clubID))
//     .toList();
