import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_filter.freezed.dart';
part 'price_filter.g.dart';

@freezed
class PriceFilter with _$PriceFilter {
  const PriceFilter._();
  const factory PriceFilter({required int fromPrice, required int toPrice}) =
      _PriceFilter;

  factory PriceFilter.fromJson(Map<String, dynamic> json) =>
      _$PriceFilterFromJson(json);
}
