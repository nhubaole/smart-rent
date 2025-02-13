import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class PostRoomStepper<T> extends StatefulWidget {
  final List<T> tabs;
  final int initStep;
  final Future<bool> Function(int) onStepTapped;
  final Color selectedColor;
  final Color unselectedColor;

  const PostRoomStepper({
    super.key,
    this.initStep = 0,
    required this.onStepTapped,
    required this.selectedColor,
    required this.unselectedColor,
    required this.tabs,
  }) : assert(initStep <= tabs.length);

  @override
  State<PostRoomStepper> createState() => _PostRoomStepperState();
}

class _PostRoomStepperState extends State<PostRoomStepper> {
  late int currentSelected;
  late int length;
  @override
  void initState() {
    length = widget.tabs.length;
    currentSelected = widget.initStep;
    super.initState();
  }

  @override
  void didUpdateWidget(PostRoomStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initStep != widget.initStep) {
      setState(() {
        currentSelected = widget.initStep;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Row(
            children: List.generate(
              length,
              (index) {
                return Flexible(
                  fit: index != 0 || index != length - 1
                      ? FlexFit.tight
                      : FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (index > 0 && index <= length - 1)
                        Expanded(
                          child: Column(
                            children: [
                              Divider(
                                color: currentSelected >= index
                                    ? widget.selectedColor
                                    : widget.unselectedColor,
                                thickness: 2,
                                indent: 5,
                                endIndent: 5,
                              ),
                              SizedBox(height: 20.px),
                            ],
                          ),
                        ),
                      _buildIndexIcon(
                          index: index,
                          onTap: () async {
                            if (currentSelected == index) return;
                            final shouldChange =
                                await widget.onStepTapped(index);
                            if (shouldChange) {
                              setState(() {
                                currentSelected = index;
                              });
                            }
                          }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const Expanded(
          child: SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildIndexIcon({
    required int index,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: AppColors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4.px),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: currentSelected == index
                        ? AppColors.primary60
                        : currentSelected > index
                            ? widget.selectedColor
                            : widget.unselectedColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Icon(
                    applyTextScaling: true,
                    weight: 1,
                    widget.tabs[index]['iconData'],
                    size: 24.px,
                    color: currentSelected == index
                        ? AppColors.primary60
                        : currentSelected > index
                            ? widget.selectedColor
                            : widget.unselectedColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.px),
          Text(
            widget.tabs[index]['title'] as String,
            style: TextStyle(
              color: currentSelected == index
                  ? AppColors.primary60
                  : currentSelected > index
                      ? widget.selectedColor
                      : widget.unselectedColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
