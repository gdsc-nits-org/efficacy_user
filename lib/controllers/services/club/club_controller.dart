import 'dart:convert';

import 'package:efficacy_user/controllers/services/user/user_controller.dart';
import 'package:efficacy_user/models/club/club_model.dart';
import 'package:efficacy_user/utils/database/database.dart';
import 'package:efficacy_user/utils/formatter.dart';
import 'package:efficacy_user/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:efficacy_user/controllers/utils/comparator.dart';

part 'functions/_save_impl.dart';
part 'functions/_check_duplicate_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_get_name_impl.dart';
part 'functions/_get_all_clubs_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_toggle_follow_impl.dart';

class ClubController {
  const ClubController._();
  static const String _collectionName = "clubs";

  static Future<ClubModel> _save(ClubModel club) async {
    return await _saveImpl(club);
  }

  static bool _isMinified(Map<String, dynamic> json) {
    return json[ClubFields.email.name] == null;
  }

  static Future<void> _checkDuplicate(ClubModel club) async {
    return await _checkDuplicateImpl(club);
  }

  /// For a given id returns all the data of the club
  static Stream<List<ClubModel>> get({
    String? id,
    String? instituteName,
    String? clubName,
    bool forceGet = false,
  }) {
    return _getImpl(
      id: id,
      instituteName: instituteName,
      clubName: clubName,
      forceGet: forceGet,
    );
  }

  static Future<ClubModel> update(ClubModel club) async {
    return await _updateImpl(club);
  }

  /// For a given id returns only the name
  static Stream<String?> getName(String id) {
    return _getNameImpl(id);
  }

  /// In minified only the club id, name and institute name is returned
  /// Recommended to use minified
  static Stream<List<ClubModel>> getAllClubs({
    List<String> instituteName = const [],
    bool minified = true,
  }) {
    return _getAllClubsImpl(
      instituteName: instituteName,
      minified: minified,
    );
  }

  /// Used Deprecated to warn not to use this.
  /// Maybe use some better alternative.
  @Deprecated("Use [UserController.toggleFollowClub()] instead")
  static Future<void> toggleFollow({required String clubID}) async {
    return await _toggleFollowImpl(clubID: clubID);
  }
}
