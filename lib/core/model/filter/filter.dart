import 'package:freezed_annotation/freezed_annotation.dart';
import '/core/model/filter/capacity_filter.dart';
import '/core/model/filter/price_filter.dart';
import '/core/model/filter/room_type_filter.dart';
import '/core/model/filter/sort_filter.dart';
import '/core/model/filter/util_filter.dart';

part 'filter.freezed.dart';
part 'filter.g.dart';

@freezed
class Filter with _$Filter {
  const Filter._();
  const factory Filter(
      {PriceFilter? priceFilter,
      UtilFilter? utilFilter,
      RoomTypeFilter? roomTypeFilter,
      CapacityFilter? capacityFilter,
      SortFilter? sortFilter}) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}
