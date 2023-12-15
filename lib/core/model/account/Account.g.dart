// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      phoneNumber: json['phoneNumber'] as String,
      uid: json['uid'] as String,
      photoUrl: json['photoUrl'] as String,
      username: json['username'] as String,
      address: json['address'] as String,
      sex: json['sex'] as bool,
      age: json['age'] as int,
      dateOfBirth: json['dateOfBirth'] as String?,
      dateOfCreate: json['dateOfCreate'] as String?,
      email: json['email'] as String? ?? 'user@one.com',
      verified: json['verified'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      listRoomForRent: (json['listRoomForRent'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listSaved: (json['listSaved'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listRoomRent: (json['listRoomRent'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listFollowers: (json['listFollowers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listFollowing: (json['listFollowing'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listComments: (json['listComments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'uid': instance.uid,
      'photoUrl': instance.photoUrl,
      'username': instance.username,
      'address': instance.address,
      'sex': instance.sex,
      'age': instance.age,
      'dateOfBirth': instance.dateOfBirth,
      'dateOfCreate': instance.dateOfCreate,
      'email': instance.email,
      'verified': instance.verified,
      'isOnline': instance.isOnline,
      'rating': instance.rating,
      'listRoomForRent': instance.listRoomForRent,
      'listSaved': instance.listSaved,
      'listRoomRent': instance.listRoomRent,
      'listFollowers': instance.listFollowers,
      'listFollowing': instance.listFollowing,
      'listComments': instance.listComments,
    };
