import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ward.freezed.dart';
part 'ward.g.dart';

@freezed
class Ward with _$Ward {
  const Ward._();
  const factory Ward({
    required String name,
    required String type,
    required String slug,
    required String name_with_type,
    required String path,
    required String path_with_type,
    required String code,
    required String parent_code,
  }) = _Ward;

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);
}