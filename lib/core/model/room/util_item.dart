import 'package:freezed_annotation/freezed_annotation.dart';
import '/core/enums/utilities.dart';

part 'util_item.freezed.dart';
part 'util_item.g.dart';

@freezed
class UtilItem with _$UtilItem {
  const UtilItem._();
  const factory UtilItem(
      {required Utilities utility, required bool isChecked}) = _UtilItem;

  factory UtilItem.fromJson(Map<String, dynamic> json) =>
      _$UtilItemFromJson(json);
}
