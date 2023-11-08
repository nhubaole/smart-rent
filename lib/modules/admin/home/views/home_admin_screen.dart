import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [],
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Xin chào, ',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondary20,
                      )),
                  TextSpan(
                    text: 'Như',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondary20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
