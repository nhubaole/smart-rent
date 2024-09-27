import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '/core/values/app_colors.dart';

class ToggleButtonsCustom extends StatefulWidget {
  const ToggleButtonsCustom({
    super.key,
    required this.data,
    required this.dataLength,
  });
  final Map<String, Icon> data;
  final int dataLength;

  @override
  State<StatefulWidget> createState() {
    return _ToggleButtonsCustomState();
  }
}

class _ToggleButtonsCustomState extends State<ToggleButtonsCustom> {
  late List<bool> _selections; // Khởi tạo danh sách _selections

  @override
  void initState() {
    super.initState();
    _selections = List.generate(widget.dataLength, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      fillColor: AppColors.primary95.withOpacity(0.2),
      selectedBorderColor: Colors.blue,
      color: Colors.black,
      selectedColor: AppColors.primary40,
      isSelected: _selections,
      onPressed: (int index) {
        setState(
          () {
            _selections[index] = !_selections[index];
          },
        );
      },
      children: [
        ...widget.data.entries.map(
          (item) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.value.icon,
                  color: AppColors.primary60,
                ),
                Text(item.key),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
