import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/electricity_payment_method.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';

class ElectricityPaymentMethodSheet extends StatefulWidget {
  final Function(ElectricityPaymentMethod) onChoseElectricityPaymentMethod;
  final List<ElectricityPaymentMethod> electricityPaymentMethods;
  final Function() onSaved;

  const ElectricityPaymentMethodSheet({
    super.key,
    required this.onChoseElectricityPaymentMethod,
    required this.electricityPaymentMethods,
    required this.onSaved,
  });

  @override
  State<ElectricityPaymentMethodSheet> createState() =>
      _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends State<ElectricityPaymentMethodSheet> {
  late ElectricityPaymentMethod selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = widget.electricityPaymentMethods[0];
  }

  void _handlePaymentMethodChange(ElectricityPaymentMethod? value) {
    if (value != null) {
      setState(() {
        selectedPaymentMethod = value;
      });

      widget.onChoseElectricityPaymentMethod(value);

      // // Close the bottom sheet after selection
      // if (Get.isBottomSheetOpen!) {
      //   Get.back<bool>(result: true);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Align(
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
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.px),
              topRight: Radius.circular(20.px),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              SizedBox(height: 16.px),
              Column(
                children: widget.electricityPaymentMethods
                    .map((paymentMethod) =>
                        _buildPaymentMethod(paymentMethod: paymentMethod))
                    .toList(),
              ),
              OutlineButtonWidget(
                margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
                text: 'save'.tr,
                onTap: widget.onSaved,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'select_electricity_payment_method'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () =>
              Get.isBottomSheetOpen! ? Get.back<bool>(result: false) : null,
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod({
    required ElectricityPaymentMethod paymentMethod,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile<ElectricityPaymentMethod>(
          value: paymentMethod,
          groupValue: selectedPaymentMethod,
          activeColor: AppColors.primary40,
          toggleable: true,
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.primary40
                : AppColors.secondary20,
          ),
          onChanged: _handlePaymentMethodChange,
          title: Text(
            paymentMethod.name,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.secondary20,
            ),
          ),
        ),
        const Divider(
          color: AppColors.secondary80,
          thickness: 0.5,
          height: 0,
        ),
      ],
    );
  }
}
