import 'package:freezed_annotation/freezed_annotation.dart';
import '/core/model/location/city.dart';
import '/core/model/location/district.dart';
import '/core/model/location/ward.dart';

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

  @override
  String toString() {
    return "$address, $street, ${ward.name_with_type}, ${district.name_with_type}, ${city.name_with_type}";
  }
}
