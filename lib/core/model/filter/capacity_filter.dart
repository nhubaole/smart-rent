import 'package:freezed_annotation/freezed_annotation.dart';
import '/core/enums/gender.dart';

part 'capacity_filter.freezed.dart';
part 'capacity_filter.g.dart';

@freezed
class CapacityFilter with _$CapacityFilter {
  const CapacityFilter._();
  const factory CapacityFilter(
      {required int capacity, required Gender gender}) = _CapacityFilter;

  factory CapacityFilter.fromJson(Map<String, dynamic> json) =>
      _$CapacityFilterFromJson(json);
}
