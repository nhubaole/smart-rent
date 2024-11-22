import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/number_formatter.dart';

class OutlineTextFiledWidget extends StatelessWidget {
  final Function()? onTap;
  final bool? readOnly;
  final String? Function(String?)? onValidate;
  final String? onValidateString;
  final String? textLabel;
  final TextStyle? textLabelStyle;
  final String? hintText;
  final TextStyle? textStyleInput;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final String? suffixUnit;
  final Widget? prefixIcon;
  final int? maxlines;
  final List<TextInputFormatter>? inputFormatters;

  const OutlineTextFiledWidget({
    super.key,
    this.onValidate,
    this.textLabel,
    this.textLabelStyle,
    this.hintText,
    this.textStyleInput,
    this.textInputType = TextInputType.text,
    required this.textEditingController,
    this.onValidateString,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.maxlines,
    this.suffixUnit,
    this.inputFormatters,
  })  : assert((onValidate == null) != (onValidateString == null)),
        assert((readOnly != null && readOnly == true) != (onTap == null)),
        assert(
            (suffixIcon == null && suffixUnit == null) ||
                (suffixIcon == null || suffixUnit == null),
            'Either suffixIcon or suffixUnit should be null, or both should be null, but not both non-null.');

  @override
  Widget build(BuildContext context) {
    return textLabel != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  textLabel!,
                  style: textLabelStyle ??
                      TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondary40,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(height: 8.px),
              _buildTextFormField(),
            ],
          )
        : _buildTextFormField();
  }

  Widget _buildTextFormField() {
    final defaultTextStyle = textStyleInput ??
        TextStyle(
          fontSize: 16.sp,
          color: AppColors.secondary20,
          fontWeight: FontWeight.w400,
        );
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: textEditingController,
      keyboardType: textInputType!,
      textInputAction: TextInputAction.done,
      style: defaultTextStyle,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.px),
          borderSide: const BorderSide(
            color: AppColors.secondary80,
          ),
        ),
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary40,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondary80,
            width: 1,
          ),
        ),
        suffixIcon: suffixIcon ??
            (suffixUnit != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(suffixUnit!, style: defaultTextStyle)],
                    ),
                  )
                : null),
        prefixIcon: prefixIcon,
      ),
      onSaved: (newValue) {},
      validator: onValidate ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'please_enter_electricity_number'.tr;
            }
            return null;
          },
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
    );
  }
}
