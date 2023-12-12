import 'dart:convert';

import 'package:efficacy_user/models/institution/institution_model.dart';
import 'package:efficacy_user/utils/database/database.dart';
import 'package:efficacy_user/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_check_duplicate_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_get_all_institutions_impl.dart';

class InstitutionController {
  const InstitutionController._();
  static const String _collectionName = "institutions";

  static Future<InstitutionModel> _save(InstitutionModel institution) async {
    return await _saveImpl(institution);
  }

  static Future<void> _checkDuplicate(InstitutionModel institution) async {
    return await _checkDuplicateImpl(institution);
  }

  static Stream<InstitutionModel?> get({
    required String id,
    bool forceGet = false,
  }) {
    return _getImpl(id: id, forceGet: forceGet);
  }

  static Future<List<InstitutionModel>> getAllInstitutions() async {
    return await _getAllInstitutionsImpl();
  }
}
