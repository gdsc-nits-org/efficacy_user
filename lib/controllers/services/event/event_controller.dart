import 'dart:convert';

import 'package:efficacy_user/controllers/utils/comparator.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/utils/database/database.dart';
import 'package:efficacy_user/utils/formatter.dart';
import 'package:efficacy_user/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_is_any_update_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_get_all_events_impl.dart';
part 'functions/_toggle_like_impl.dart';

class EventController {
  static const String _collectionName = "events";
  const EventController._();

  static Future<EventModel> _save(EventModel event) async {
    return await _saveImpl(event);
  }

  //
  static Future<bool> isAnyUpdate(String clubID, DateTime? lastChecked) async {
    return await _isAnyUpdateImpl(clubID, lastChecked);
  }

  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<EventModel>> get({
    String? eventID,
    String? clubID,
    bool forceGet = false,
  }) {
    return _getImpl(
      eventID: eventID,
      clubID: clubID,
      forceGet: forceGet,
    );
  }

  /// Returns all the events.
  /// Can be used for pagination
  ///
  /// Pass [prevPassed] as page number and
  /// [count] as max number of events to be returned
  ///
  /// The [prevPassed] is used in terms of the updatedAt parameter
  ///
  /// NOTE: If [clubIDs] is null it returns for all the clubs.
  ///
  /// [skip] is returned -1 if there are no more events
  static Stream<EventPaginationResponse> getAllEvents({
    int skip = 0,
    List<String>? clubIDs,
    EventStatus? eventStatus,
    bool forceGet = false,
    int count = 10,
  }) {
    return _getAllEventsImpl(
      skip: skip,
      clubIDs: clubIDs,
      forceGet: forceGet,
      eventStatus: eventStatus,
      count: count,
    );
  }

  static Future<EventModel> toggleLike(
      {required String userEmail, required EventModel event}) async {
    return _toggleLikeImpl(userEmail: userEmail, event: event);
  }

  static Future<EventModel> update(EventModel event) async {
    return await _updateImpl(event);
  }
}

class EventPaginationResponse {
  final int skip;
  final List<EventModel> events;
  const EventPaginationResponse(this.skip, this.events);
}
