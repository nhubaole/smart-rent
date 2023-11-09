import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class PostReviewScreen extends StatelessWidget {
  const PostReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary98,
          title: const Text(
            'Thông tin chủ nhà',
            style: TextStyle(
              color: primary40,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        body: SizedBox());
  }
}
