import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Icon icon;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPassword = false,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.borderRadius,
    required this.borderWidth,
    required this.borderColor,
    required this.icon,
  });

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
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
      obscureText: _obscureText,
    );
  }
}
