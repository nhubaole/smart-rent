import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_rent/core/enums/sort.dart';

part 'sort_filter.freezed.dart';
part 'sort_filter.g.dart';

@freezed
class SortFilter with _$SortFilter {
  const SortFilter._();
  const factory SortFilter({required Sort sort}) = _SortFilter;

  factory SortFilter.fromJson(Map<String, dynamic> json) =>
      _$SortFilterFromJson(json);
}
