import 'dart:convert';

import 'package:efficacy_user/controllers/controllers.dart';
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
}
