import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class ReturnRentScreen extends StatefulWidget {
  const ReturnRentScreen({super.key});

  @override
  State<ReturnRentScreen> createState() => _ReturnRentScreenState();
}

class _ReturnRentScreenState extends State<ReturnRentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng yêu cầu trả',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 28,
        ),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => const Text('data'),
        ),
      ),
    );
  }
}
