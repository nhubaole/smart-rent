import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class OutlineTextFiledWidget extends StatelessWidget {
  final Function()? onTap;
  final bool? readOnly;
  final String? Function(String?)? onValidate;
  final String? Function(String? value)? onSubmit;
  final String? onValidateString;
  final String? textLabel;
  final TextStyle? textLabelStyle;
  final String? hintText;
  final TextStyle? textStyleInput;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final String? suffixUnit;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? prefix;
  final int? maxlines;
  final int? minlines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? inSideContainer;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final bool? obscureText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final AutovalidateMode autovalidateMode;
  final TextAlign textAlign;

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
    this.suffix,
    this.minlines,
    this.prefix,
    this.onSubmit,
    this.inSideContainer = false,
    this.enabledBorder,
    this.focusedBorder,
    this.border,
    this.obscureText = false,
    this.focusNode,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textAlign = TextAlign.start,
  })  : assert((onValidate == null) != (onValidateString == null)),
        assert((readOnly != null && readOnly == true) != (onTap == null)),
        assert(
            (suffixIcon == null && suffixUnit == null) ||
                (suffixIcon == null || suffixUnit == null),
            'Either suffixIcon or suffixUnit should be null, or both should be null, but not both non-null.');

  @override
  Widget build(BuildContext context) {
    Widget textFormFiled;
    if (onTap == null) {
      textFormFiled = _buildTextFormField();
    } else {
      textFormFiled = GestureDetector(
        onTap: onTap!,
        child: _buildTextFormField(),
      );
    }

    if (inSideContainer!) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
        decoration: BoxDecoration(
          color: AppColors.secondary90,
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: textLabel != null
            ? _buildWithTextLabel(textFormFiled)
            : textFormFiled,
      );
    }

    return textLabel != null
        ? _buildWithTextLabel(textFormFiled)
        : textFormFiled;
  }

  Column _buildWithTextLabel(Widget textFormFiled) {
    return Column(
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
                  fontWeight:
                      !inSideContainer! ? FontWeight.w600 : FontWeight.w400,
                ),
          ),
        ),
        if (!inSideContainer!)
        SizedBox(height: 8.px),
        textFormFiled,
      ],
    );
  }

  Widget _buildTextFormField() {
    final defaultTextStyle = textStyleInput ??
        TextStyle(
          fontSize: 16.sp,
          color: AppColors.secondary20,
          fontWeight: FontWeight.w400,
        );
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: onSubmit,
      enabled: !readOnly!,
      inputFormatters: inputFormatters,
      controller: textEditingController,
      keyboardType: textInputType!,
      minLines: minlines,
      maxLines: maxlines,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction ?? TextInputAction.done,
      style: defaultTextStyle,
      textAlign: textAlign,
      cursorColor: AppColors.primary40,
      cursorErrorColor: AppColors.error,
      mouseCursor: MouseCursor.defer,
      obscureText: obscureText!,
      decoration: InputDecoration(
        border: border ??
            OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.px),
          borderSide: const BorderSide(
            color: AppColors.secondary80,
          ),
        ),
        hintText: hintText,
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary40,
            width: 1,
          ),
        ),
        enabledBorder: enabledBorder ??
            const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondary80,
            width: 1,
          ),
        ),
        suffix: suffix,
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
        prefix: prefix,
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
