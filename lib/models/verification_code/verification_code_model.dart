import 'package:efficacy_user/models/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'verification_code_model.freezed.dart';
part 'verification_code_model.g.dart';

@Freezed(fromJson: true, toJson: true)
class VerificationCodeModel with _$VerificationCodeModel {
  const VerificationCodeModel._();

  const factory VerificationCodeModel({
    @JsonKey(name: '_id') String? id,
    required String email,
    required String code,
    required DateTime expiresAt,

    /// Which app does this user instance belong to
    /// No need to touch this
    @Default(appName) String app,
    DateTime? lastLocalUpdate,
  }) = _VerificationCodeModel;

  factory VerificationCodeModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$VerificationCodeModelFromJson(json);
  }

  @override
  bool operator ==(dynamic other) {
    return id != null && other.id != null
        ? (id == other.id)
        : identical(this, other) ||
            (other.runtimeType == runtimeType &&
                other is _$VerificationCodeModelImpl &&
                (identical(other.id, id) || other.id == id) &&
                (identical(other.email, email) || other.email == email) &&
                (identical(other.code, code) || other.code == code) &&
                (identical(other.app, app) || other.app == app) &&
                (identical(other.expiresAt, expiresAt) ||
                    other.expiresAt == expiresAt) &&
                (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                    other.lastLocalUpdate == lastLocalUpdate));
  }

  @override
  int get hashCode => id != null
      ? Object.hash(runtimeType, id)
      : Object.hash(
          runtimeType, id, email, code, app, expiresAt, lastLocalUpdate);
}

enum VerificationCodeFields { id, email, code, app, expiresAt, lastLocalUpdate }
