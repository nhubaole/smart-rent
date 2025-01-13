import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';

class AlertExitPostPageDialog extends StatelessWidget {
  final Function() onConfirm;
  final Function() onCancel;
  final String titleConfirm;
  final String titleCancel;
  const AlertExitPostPageDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.titleConfirm,
    required this.titleCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.px),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              size: 40.px,
              color: AppColors.red,
            ),
            SizedBox(height: 16.px),
            Text(
              'Bạn có muốn thoát khỏi quá trình đăng bài không?',
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 16.px,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.px),
            Container(
              padding: EdgeInsets.all(8.px),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5.px),
                border: Border.all(
                    color: AppColors.red.withOpacity(0.5), width: 1.px),
              ),
              child: Text(
                '* Điều này sẽ khiến thao tác đăng bài của bạn bị hủy.',
                style: TextStyle(
                  color: AppColors.red.withOpacity(0.7),
                  fontSize: 12.px,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    padding: EdgeInsets.symmetric(vertical: 8.px),
                    text: titleCancel,
                    onTap: onCancel,
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: SolidButtonWidget(
                    padding: EdgeInsets.symmetric(vertical: 8.px),
                    text: titleConfirm,
                    onTap: onConfirm,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
