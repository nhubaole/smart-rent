import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class RequestRentScreen extends StatefulWidget {
  const RequestRentScreen({super.key});

  @override
  State<RequestRentScreen> createState() => _RequestRentScreenState();
}

class _RequestRentScreenState extends State<RequestRentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng yêu cầu thuê',
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
