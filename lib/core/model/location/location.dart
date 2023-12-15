import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_rent/core/model/location/city.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/location/ward.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const Location._();
  const factory Location({
    required String street,
    required String address,
    required City city,
    required District district,
    required Ward ward,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  String toString() {
    return address +
        ", " +
        street +
        ", " +
        ward.name_with_type.toString() +
        ", " +
        district.name_with_type.toString() +
        ", " +
        city.name_with_type.toString();
  }
}
