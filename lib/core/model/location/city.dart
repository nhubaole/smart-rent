import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  const City._();
  const factory City({
    required String name,
    required String slug,
    required String type,
    required String name_with_type,
    required String code
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}