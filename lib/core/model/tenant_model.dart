import 'package:smart_rent/core/enums/role_user.dart';
import 'package:smart_rent/core/model/rating/rating_info_model.dart';

class TenantModel {
  final int id;
  final RoleUser role;
  String? avatar;
  String? name;
  int? totalRating;
  double? avgRating;
  int? totalRoom;
  List<RatingInfoModel>? ratingInfo;

  TenantModel({
    required this.id,
    required this.role,
    this.avatar,
    this.name,
    this.totalRating,
    this.avgRating,
    this.totalRoom,
    this.ratingInfo,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id'] as int,
      role: RoleUserExtension.getRoleUser(json['role'] as String),
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      totalRating: json['total_rating'] ?? 0,
      avgRating: json['avg_rating'] ?? 0.0,
      totalRoom: json['total_room'] ?? 0,
      ratingInfo: (json['rating_info'] as List<dynamic>?)
          ?.map((e) => RatingInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
