import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/payment_method.dart';

class PaymentMethodSheet extends StatelessWidget {
  final PaymentMethod methodSelected;
  final Function(PaymentMethod method) onTap;

  const PaymentMethodSheet({
    super.key,
    required this.methodSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          padding: EdgeInsets.only(
            top: 10.px,
            right: 16.px,
            left: 16.px,
            bottom: 16.px,
          ),
          constraints: BoxConstraints(minHeight: Get.height / 3),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.px),
              topRight: Radius.circular(20.px),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 16.px),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PaymentMethod.values.length,
                itemBuilder: (context, index) {
                  final method = PaymentMethod.values[index];
                  return _radioItem(
                    method,
                    onTap: (method) => onTap(method),
                  );
                },
              ),
            ],
          )),
    );
  }

  Widget _radioItem(
    PaymentMethod method, {
    required Function(PaymentMethod method) onTap,
  }) {
    return RadioListTile<PaymentMethod>(
      activeColor: AppColors.primary60,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        method.name,
        style: const TextStyle(color: AppColors.secondary20, fontSize: 16),
      ),
      value: method,
      groupValue: methodSelected,
      onChanged: (PaymentMethod? value) {
        onTap(method);
        Get.back();
      },
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Chọn phương thức thanh toán'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () => Get.isBottomSheetOpen! ? Get.back() : null,
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }
}
