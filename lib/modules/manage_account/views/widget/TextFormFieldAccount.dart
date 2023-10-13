import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    this.maxLength,
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.borderRadius,
    required this.borderWidth,
    required this.borderColor,
    required this.onSaved,
    required this.onValidate,
    required this.autoCorrect,
    required this.textCapitalization,
    this.isEnable = true,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final void Function(String?) onSaved;
  final String? Function(String?) onValidate;
  final bool autoCorrect;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final bool? isEnable;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            enabled: widget.isEnable,
            style: const TextStyle(
              color: primary40,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
            maxLength: widget.maxLength,
            onSaved: widget.onSaved,
            validator: widget.onValidate,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: secondary40),
              counterText: '',
              focusColor: widget.borderColor,
              fillColor: widget.borderColor,
              hoverColor: widget.borderColor,
              iconColor: widget.borderColor,
              prefixIconColor: widget.borderColor,
              labelText: widget.labelText,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: widget.borderRadius,
                borderSide: BorderSide(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: widget.borderRadius,
                borderSide: BorderSide(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: widget.borderRadius,
                borderSide: BorderSide(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
              ),
            ),
            keyboardType: widget.textInputType,
            autocorrect: widget.autoCorrect,
            textCapitalization: widget.textCapitalization,
          ),
        ],
      ),
    );
  }
}
