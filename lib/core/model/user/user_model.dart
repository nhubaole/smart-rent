// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_bank_info_model.dart';

class UserModel {
  int? id;
  String? phoneNumber;
  String? fullName;
  String? password;
  String? address;
  int? role;
  DateTime? createAt;
  DateTime? deletedAt;
  String? avatarUrl;
  String? walletAddress;
  String? privteKeyHex;
  DateTime? dob;
  int? totalRoom;
  int? totalRating;
  double? avgRating;
  List<RatingInfo>? ratingInfos;
  List<RoomModel>? rooms;
  UserBankInfoModel? bankInfo;

  UserModel({
    this.id,
    this.phoneNumber,
    this.fullName,
    this.password,
    this.address,
    this.role,
    this.createAt,
    this.deletedAt,
    this.avatarUrl,
    this.privteKeyHex,
    this.walletAddress,
    this.dob,
    this.totalRoom,
    this.totalRating,
    this.avgRating,
    this.ratingInfos,
    this.rooms,
    this.bankInfo,
  });

  UserModel copyWith({
    int? id,
    String? phoneNumber,
    String? fullName,
    String? password,
    String? address,
    int? role,
    DateTime? createAt,
    DateTime? deletedAt,
    String? avatarUrl,
    String? walletAddress,
    String? privteKeyHex,
    DateTime? dob,
    int? totalRoom,
    int? totalRating,
    double? avgRating,
    List<RatingInfo>? ratingInfos,
    List<RoomModel>? rooms,
    UserBankInfoModel? bankInfo,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      address: address ?? this.address,
      role: role ?? this.role,
      createAt: createAt ?? this.createAt,
      deletedAt: deletedAt ?? this.deletedAt,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      walletAddress: walletAddress ?? this.walletAddress,
      privteKeyHex: privteKeyHex ?? this.privteKeyHex,
      dob: dob ?? this.dob,
      totalRoom: totalRoom ?? this.totalRoom,
      totalRating: totalRating ?? this.totalRating,
      avgRating: avgRating ?? this.avgRating,
      ratingInfos: ratingInfos ?? this.ratingInfos,
      rooms: rooms ?? this.rooms,
      bankInfo: bankInfo ?? this.bankInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone_number': phoneNumber,
      'full_name': fullName,
      'password': password,
      'address': address,
      'role': role,
      'created_at': createAt?.microsecondsSinceEpoch,
      'deleted_at': deletedAt?.microsecondsSinceEpoch,
      'avatar_url': avatarUrl,
      'wallet_address': walletAddress,
      'private_key_hex': privteKeyHex,
      'dob': dob?.microsecondsSinceEpoch,
      'total_room': totalRoom,
      'total_rating': totalRating,
      'avg_rating': avgRating,
      'rating_info': ratingInfos?.map((x) => x.toMap()).toList(),
      'rooms': rooms?.map((x) => x.toMap()).toList(),
      'bank_info': bankInfo?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      // createAt: map['created_at'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] * 1000)
      //     : null,
      // deletedAt: map['deleted_at'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['deleted_at'] * 1000)
      //     : null,
      createAt: map['created_at'] != null
          ? _handleTypeTimer(map['created_at'])
          : null,
      deletedAt: map['created_at'] != null
          ? _handleTypeTimer(map['deleted_at'])
          : null,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
      walletAddress: map['wallet_address'] != null
          ? map['wallet_address'] as String
          : null,
      privteKeyHex: map['private_key_hex'] != null
          ? map['private_key_hex'] as String
          : null,
      dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
      totalRoom: map['total_room'] != null ? map['total_room'] as int : null,
      totalRating:
          map['total_rating'] != null ? map['total_rating'] as int : null,
      avgRating:
          map['avg_rating'] != null ? map['avg_rating'] * 1.0 as double : null,
      ratingInfos: map['rating_info'] != null
          ? List<RatingInfo>.from(
              (map['rating_info'] as List).map((x) => RatingInfo.fromMap(x)))
          : null,
      rooms: map['rooms'] != null
          ? List<RoomModel>.from(
              (map['rooms'] as List).map((x) => RoomModel.fromMap(x)))
          : null,
      bankInfo: map['bank_info'] != null
          ? UserBankInfoModel.fromMap(map['bank_info'])
          : null,
    );
  }

  static _handleTypeTimer(dynamic data) {
    if (data is int) {
      return DateTime.fromMillisecondsSinceEpoch(data * 1000);
    } else if (data is String) {
      return DateTime.tryParse(data);
    } else {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, password: $password, address: $address, role: $role, createAt: $createAt, deletedAt: $deletedAt, avatarUrl: $avatarUrl, walletAddress: $walletAddress, privteKeyHex: $privteKeyHex, dob: $dob, totalRoom: $totalRoom, totalRating: $totalRating, avgRating: $avgRating, ratingInfos: $ratingInfos)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.fullName == fullName &&
        other.password == password &&
        other.address == address &&
        other.role == role &&
        other.createAt == createAt &&
        other.deletedAt == deletedAt &&
        other.avatarUrl == avatarUrl &&
        other.walletAddress == walletAddress &&
        other.privteKeyHex == privteKeyHex &&
        other.dob == dob &&
        other.totalRoom == totalRoom &&
        other.totalRating == totalRating &&
        other.avgRating == avgRating &&
        listEquals(other.ratingInfos, ratingInfos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phoneNumber.hashCode ^
        fullName.hashCode ^
        password.hashCode ^
        address.hashCode ^
        role.hashCode ^
        createAt.hashCode ^
        deletedAt.hashCode ^
        avatarUrl.hashCode ^
        walletAddress.hashCode ^
        privteKeyHex.hashCode ^
        dob.hashCode ^
        totalRoom.hashCode ^
        totalRating.hashCode ^
        avgRating.hashCode ^
        ratingInfos.hashCode;
  }
}

class RatingInfo {
  String? ratingName;
  DateTime? createAt;
  int? rate;
  String? comment;
  String? happy;
  String? unHappy;
  RatingInfo({
    this.ratingName,
    this.createAt,
    this.rate,
    this.comment,
    this.happy,
    this.unHappy,
  });

  RatingInfo copyWith({
    String? ratingName,
    DateTime? createAt,
    int? rate,
    String? comment,
    String? happy,
    String? unHappy,
  }) {
    return RatingInfo(
      ratingName: ratingName ?? this.ratingName,
      createAt: createAt ?? this.createAt,
      rate: rate ?? this.rate,
      comment: comment ?? this.comment,
      happy: happy ?? this.happy,
      unHappy: unHappy ?? this.unHappy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ratingName': ratingName,
      'createAt': createAt?.millisecondsSinceEpoch,
      'rate': rate,
      'comment': comment,
      'happy': happy,
      'unHappy': unHappy,
    };
  }

  factory RatingInfo.fromMap(Map<String, dynamic> map) {
    return RatingInfo(
      ratingName:
          map['rater_name'] != null ? map['rater_name'] as String : null,
      createAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      rate: map['rate'] != null ? map['rate'] as int : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      happy: map['happy'] != null ? map['happy'] as String : null,
      unHappy: map['unHappy'] != null ? map['unHappy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingInfo.fromJson(String source) =>
      RatingInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RatingInfo(ratingName: $ratingName, createAt: $createAt, rate: $rate, comment: $comment, happy: $happy, unHappy: $unHappy)';
  }

  @override
  bool operator ==(covariant RatingInfo other) {
    if (identical(this, other)) return true;

    return other.ratingName == ratingName &&
        other.createAt == createAt &&
        other.rate == rate &&
        other.comment == comment &&
        other.happy == happy &&
        other.unHappy == unHappy;
  }

  @override
  int get hashCode {
    return ratingName.hashCode ^
        createAt.hashCode ^
        rate.hashCode ^
        comment.hashCode ^
        happy.hashCode ^
        unHappy.hashCode;
  }
}
