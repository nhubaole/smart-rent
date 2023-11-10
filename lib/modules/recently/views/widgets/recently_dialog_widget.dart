import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:get/get.dart';

class RecentlyDialogWidget extends StatelessWidget {
  const RecentlyDialogWidget({
    super.key,
    required this.onPressed,
  });
  final Future<void> onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary95,
                      border: Border.all(
                        width: 5,
                        color: Colors.transparent,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cảnh báo xóa',
                      style: TextStyle(
                        color: primary40,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Bạn có muốn xóa hết lịch sử phòng gần đấy không?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Không, đừng xóa'),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      onPressed;
                      Get.back(closeOverlays: true);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondary40,
                    ),
                    child: const Text('Có, xóa ngay'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
