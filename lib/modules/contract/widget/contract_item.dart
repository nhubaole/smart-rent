import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/values/image_assets.dart';

class ContractItem extends StatelessWidget {
  final VoidCallback onTap;
  final ContractByStatusModel contract;
  const ContractItem({
    super.key,
    required this.onTap,
    required this.contract,
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
                _buildIconContract(),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${'room'.tr} ${contract.roomNumber ?? '--'}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary60,
                            ),
                          ),
                          Text(
                            contract.tenantName ?? '--',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.px),
                      Text.rich(
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary20,
                        ),
                        textAlign: TextAlign.start,
                        TextSpan(
                          text:
                              '${'rental_contract'.tr} ${contract.roomAddress ?? '--'}',
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
                                TextSpan(
                                  text: contract.createdAt?.ddMMyyyy ?? '--',
                                ),
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
                                TextSpan(
                                  text: contract.expiredAt?.ddMMyyyy ?? '--',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildArrow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildArrow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 8.px),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.primary40,
        ),
      ],
    );
  }

  Expanded _buildIconContract() {
    return Expanded(
      child: Center(
        child: SvgPicture.asset(
          ImageAssets.icContract,
          width: 42.px,
          height: 42.px,
        ),
      ),
    );
  }
}
