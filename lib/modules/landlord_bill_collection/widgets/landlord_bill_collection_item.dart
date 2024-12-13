import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/config/app_images.dart';
import 'package:smart_rent/core/enums/bill_status.dart';

class LandlordBillCollectionItem extends StatefulWidget {
  final Object object;
  final Function(Object) onTap;
  final bool isMultipleSelectionMode;
  final bool isSelected;

  const LandlordBillCollectionItem({
    super.key,
    required this.onTap,
    required this.isMultipleSelectionMode,
    this.isSelected = false,
    required this.object,
  });

  @override
  State<LandlordBillCollectionItem> createState() =>
      _LandlordBillCollectionItemState();
}

class _LandlordBillCollectionItemState
    extends State<LandlordBillCollectionItem> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LandlordBillCollectionItem oldWidget) {
    if (widget.isMultipleSelectionMode != oldWidget.isMultipleSelectionMode ||
        widget.isSelected != oldWidget.isSelected) {
      isSelected = widget.isSelected;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _toggleCheckBox() {
    setState(() {
      isSelected = !isSelected;
      widget.onTap(widget.object);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    );
    return Container(
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          splashColor: AppColors.secondary40.withOpacity(0.2),
          onTap: () {
            if (widget.isMultipleSelectionMode) {
              _toggleCheckBox();
            } else {
              widget.onTap(widget.object);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary98 : AppColors.transparent,
            ),
            child: Row(
              children: [
                if (widget.isMultipleSelectionMode)
                  Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          _toggleCheckBox();
                        },
                        checkColor: AppColors.white,
                        activeColor: AppColors.primary40,
                      ),
                      SizedBox(width: 8.px),
                    ],
                  ),
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: CachedNetworkImageProvider(
                    AppImages.demo,
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            BillStatus.unpaid.value,
                            style: textStyle.copyWith(
                              color: BillStatus.unpaid.colorContent,
                            ),
                          ),
                          Text(
                            '2,560,000đ',
                            style: textStyle,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Text(
                        'Phòng số 3',
                        style: textStyle.copyWith(
                          color: AppColors.secondary40,
                        ),
                      ),
                      Text(
                        'Lê Bảo Như',
                        style: textStyle.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.secondary20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
