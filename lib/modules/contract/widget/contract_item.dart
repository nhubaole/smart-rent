import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/values/image_assets.dart';

class ContractItem extends StatelessWidget {
  final VoidCallback onTap;
  const ContractItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        // border: Border(
        //   bottom: BorderSide(color: AppColors.secondary80, width: 0.5),
        // ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(
                      ImageAssets.icContract,
                      width: 42.px,
                      height: 42.px,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 4,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phòng 3.11',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary60,
                            ),
                          ),
                          Text(
                            'Nguyễn Phương Phương',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.px),
                      const Text.rich(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary20,
                        ),
                        TextSpan(
                          text:
                              'Hợp đồng thuê trọ 97 đường số 11, phường Trường Thọ, TP Thủ Đức',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.px),
                      Row(
                        children: [
                          Text.rich(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.secondary40,
                            ),
                            textDirection: TextDirection.ltr,
                            TextSpan(
                              children: [
                                TextSpan(text: 'creation_date'.tr),
                                const TextSpan(text: ': '),
                                const TextSpan(text: '04/12/2023'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.px),
                      Row(
                        children: [
                          Text.rich(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.red,
                            ),
                            textDirection: TextDirection.ltr,
                            TextSpan(
                              children: [
                                TextSpan(text: 'expried_date'.tr),
                                const TextSpan(text: ': '),
                                const TextSpan(text: '04/12/2023'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
