import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/contract/template_model.dart';
import 'package:smart_rent/core/widget/common_button.dart';

class ContractSampleItem extends StatelessWidget {
  final Function()? onCreateContract;
  final Function() onTap;
  final TemplateModel template;
  const ContractSampleItem({
    super.key,
    this.onCreateContract,
    required this.onTap,
    required this.template,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary90,
        borderRadius: BorderRadius.circular(16.px),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.px),
          child: Container(
            width: 150.px,
            height: 150.px,
            padding: EdgeInsets.all(8.px),
            // decoration: BoxDecoration(
            //   color: AppColors.secondary90,
            //   borderRadius: BorderRadius.circular(16.px),
            // ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 24.px,
                      ),
                      SizedBox(width: 8.px),
                      Expanded(
                        child: Text.rich(
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.secondary20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          TextSpan(
                              text:
                                  template.address.join(", ")),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: _needToCreateNewContract(),
                  // child: SolidButtonWidget(
                  //   text: 'create_contract_template'.tr,
                  //   textStyle: TextStyle(
                  //     fontSize: 14.sp,
                  //     fontWeight: FontWeight.bold,
                  //     color: AppColors.white,
                  //   ),
                  //   onTap: () {},
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 8.px,
                  //     vertical: 8.px,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _needToCreateNewContract() {
    Widget widget;
    if (template.updatedAt == null) {
      widget = CommonButton(
        height: 42.px,
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.px,
          vertical: 8.px,
        ),
        title: 'create_contract_template'.tr,
        onClick: onCreateContract!,
      );
    } else {
      widget = Text.rich(
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.secondary60,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        TextSpan(children: [
          TextSpan(text: 'last_updated'.tr),
          const TextSpan(text: ' '),
          const TextSpan(text: '13:39'),
          const TextSpan(text: ' '),
          const TextSpan(text: '17/09/2023'),
        ]),
      );
    }

    return widget;
  }
}
