import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Account.freezed.dart';
part 'Account.g.dart';

@freezed
class Account with _$Account {
  const Account._();
  const factory Account({
    required String phoneNumber,
    required String uid,
    required String photoUrl,
    required String username,
    required String address,
    required bool sex,
    required int age,
    required String? dateOfBirth,
    required String? dateOfCreate,
    @Default('user@one.com') String email,
    @Default(false) bool verified,
    @Default(false) bool? isOnline,
    @Default(0) double? rating,
    @Default([]) List<String> listRoomForRent,
    @Default([]) List<String> listSaved,
    @Default([]) List<String> listRoomRent,
    @Default([]) List<String> listFollowers,
    @Default([]) List<String> listFollowing,
    @Default([]) List<String> listComments,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
