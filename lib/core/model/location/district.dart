import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'district.freezed.dart';
part 'district.g.dart';

@freezed
class District with _$District {
  const District._();
  const factory District({
    required String name,
    required String type,
    required String slug,
    required String name_with_type,
    required String path,
    required String path_with_type,
    required String code,
    required String parent_code,
  }) = _District;

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
}