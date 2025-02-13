import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class StepperWidget<T> extends StatefulWidget {
  final List<T> tabs;
  final int initStep;
  final Future<bool> Function(int) onStepTapped;
  final Color selectedColor;
  final Color unselectedColor;
  const StepperWidget({
    super.key,
    required this.tabs,
    required this.initStep,
    required this.onStepTapped,
    required this.selectedColor,
    required this.unselectedColor,
  }) : assert(initStep <= tabs.length);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  late int currentSelected;
  late int length;
  @override
  void initState() {
    length = widget.tabs.length;
    currentSelected = widget.initStep;
    super.initState();
  }

  @override
  void didUpdateWidget(StepperWidget oldWidget) {
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
      children: [
        Expanded(
            flex: 6,
            child: Row(
              children: List.generate(length, (index) {
                return Flexible(
                  fit: index != 0 || index != length - 1
                      ? FlexFit.tight
                      : FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (index > 0 && index <= length - 1)
                        Expanded(
                          child: Divider(
                            color: currentSelected >= index
                                ? widget.selectedColor
                                : widget.unselectedColor,
                            thickness: 2,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: currentSelected >= index
                              ? widget.selectedColor
                              : widget.unselectedColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: currentSelected >= index
                                ? widget.selectedColor
                                : widget.unselectedColor,
                            width: 2,
                          ),
                        ),
                        child: Material(
                          color: AppColors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () async {
                              if (currentSelected == index) return;
                              final shouldChange =
                                  await widget.onStepTapped(index);
                              if (shouldChange) {
                                setState(() {
                                  currentSelected = index;
                                });
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: currentSelected >= index
                                  ? widget.selectedColor
                                  : widget.unselectedColor,
                              radius: 12.px,
                              child: index < widget.initStep
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      '${widget.tabs[index]['counter'] as int}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )),
        const Expanded(
          child: SizedBox.shrink(),
        ),
      ],
    );
  }
}
