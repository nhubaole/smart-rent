import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_rent/core/enums/utilities.dart';

part 'util_filter.freezed.dart';
part 'util_filter.g.dart';

@freezed
class UtilFilter with _$UtilFilter {
  const UtilFilter._();
  const factory UtilFilter({required List<Utilities> listUtils}) = _UtilFilter;

  factory UtilFilter.fromJson(Map<String, dynamic> json) =>
      _$UtilFilterFromJson(json);
}
