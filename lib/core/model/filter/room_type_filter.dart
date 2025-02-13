import 'package:freezed_annotation/freezed_annotation.dart';
import '/core/enums/room_type.dart';

part 'room_type_filter.freezed.dart';
part 'room_type_filter.g.dart';

@freezed
class RoomTypeFilter with _$RoomTypeFilter {
  const RoomTypeFilter._();
  const factory RoomTypeFilter({required RoomType roomType}) = _RoomTypeFilter;

  factory RoomTypeFilter.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFilterFromJson(json);
}
