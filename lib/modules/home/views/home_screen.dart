import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/button_fill.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
import 'package:smart_rent/core/widget/like_button.dart';
import 'package:smart_rent/core/widget/text_field_input.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/core/widget/toggle_button_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = true;
    final TextEditingController textEditingController = TextEditingController();
    final bool isPass = false;
    final String labelText = 'Label';
    final String hintText = 'Hint';
    final TextInputType textInputType = TextInputType.emailAddress;
    final BorderRadius borderRadius = BorderRadius.circular(8);
    final double borderWidth = 2;
    final Color borderColor = Colors.blue;
    BorderSide(color: Colors.deepPurple, width: 2);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormFieldInput(
                  maxLength: 10,
                  autoCorrect: false,
                  textCapitalization: TextCapitalization.none,
                  onSaved: (value) {},
                  onValidate: (p0) {},
                  icon: Icon(Icons.email),
                  textEditingController: textEditingController,
                  labelText: labelText,
                  hintText: hintText,
                  isPassword: true,
                  textInputType: textInputType,
                  borderRadius: borderRadius,
                  borderWidth: borderWidth,
                  borderColor: borderColor,
                ),
              ),
              Expanded(
                child: ButtonFill(
                  onPressed: () {},
                  icon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  text: Text(
                    'Button',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: primary60,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Expanded(
                child: ButtonOutline(
                  onPressed: () {},
                  icon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                  text: Text(
                    'Button',
                    style: TextStyle(color: Colors.red),
                  ),
                  borderWidth: 3,
                  borderColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const Flexible(
                child: ToggleButtonsCustom(dataLength: 3, data: {
                  'Home': Icon(Icons.home),
                  'Work': Icon(Icons.work),
                  'School': Icon(Icons.school),
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
