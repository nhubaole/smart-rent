// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthResponseModel {
  final String userName;
  final String? accessToken;
  final int expiresIn;
  AuthResponseModel({
    required this.userName,
    this.accessToken,
    required this.expiresIn,
  });

  AuthResponseModel copyWith({
    String? userName,
    String? accessToken,
    int? expiresIn,
  }) {
    return AuthResponseModel(
      userName: userName ?? this.userName,
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'accessToken': accessToken,
      'expiresIn': expiresIn,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      userName: map['userName'] as String,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      expiresIn: map['expiresIn'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthResponseModel(userName: $userName, accessToken: $accessToken, expiresIn: $expiresIn)';

  @override
  bool operator ==(covariant AuthResponseModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.accessToken == accessToken &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode =>
      userName.hashCode ^ accessToken.hashCode ^ expiresIn.hashCode;
}
