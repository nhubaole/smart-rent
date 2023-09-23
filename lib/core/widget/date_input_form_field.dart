import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateInputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final IconData icon;
  final ValueChanged<DateTime> onDateSelected;
  final double borderWidth;
  final Color borderColor;
  final BorderRadius borderRadius;
  final int firstDate;
  final int lastDate;
  String? Function(String?) onValidate;

  DateInputField({
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.onDateSelected,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.onValidate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(widget.firstDate),
      lastDate: DateTime(widget.lastDate),
    );

    if (picked != null && picked != widget.textEditingController.text) {
      widget.textEditingController.text =
          "${picked.day}/${picked.month}/${picked.year}";
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.onValidate,
      readOnly: true,
      controller: widget.textEditingController,
      decoration: InputDecoration(
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
        prefixIcon: Icon(widget.icon),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: widget.borderColor,
          ),
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }
}
