import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    required String phoneNumber,
    required String email,
    required String uid,
    required String photoUrl,
    required String username,
    required String address,
    required bool sex,
    required int age,
    @Default(false) bool? verified,
    @Default(false) bool? isOnline,
    @Default(0) double? rating,
    @Default([]) List<String> listRoomForRent,
    @Default([]) List<String> listSaved,
    @Default([]) List<String> listRoomRent,
    @Default([]) List<String> listFollowers,
    @Default([]) List<String> listFollowing,
    @Default([]) List<String> listComments,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
