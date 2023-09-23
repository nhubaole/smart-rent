import 'package:flutter/material.dart';

class TextFormFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Icon icon;
  final void Function(String?) onSaved;
  final String? Function(String?) onValidate;
  final bool autoCorrect;
  final TextCapitalization textCapitalization;
  final int? maxLength;

  const TextFormFieldInput({
    super.key,
    this.maxLength,
    required this.textEditingController,
    this.isPassword = false,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.borderRadius,
    required this.borderWidth,
    required this.borderColor,
    required this.icon,
    required this.onSaved,
    required this.onValidate,
    required this.autoCorrect,
    required this.textCapitalization,
  });

  @override
  State<TextFormFieldInput> createState() => _TextFormFieldInputState();
}

class _TextFormFieldInputState extends State<TextFormFieldInput> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      onSaved: widget.onSaved,
      validator: widget.onValidate,
      controller: widget.textEditingController,
      decoration: InputDecoration(
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
        prefixIcon: widget.icon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword,
      autocorrect: widget.autoCorrect,
      textCapitalization: widget.textCapitalization,
    );
  }
}
