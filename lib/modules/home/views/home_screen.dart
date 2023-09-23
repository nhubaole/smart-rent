import 'package:flutter/material.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
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
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {
            AuthMethods.instance.logout();
          },
          child: const Text('Đăng xuất')),
    ));
  }
}
