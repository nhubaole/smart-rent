import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class WaitApproveRoomScreen extends StatefulWidget {
  const WaitApproveRoomScreen({super.key});

  @override
  State<WaitApproveRoomScreen> createState() => _WaitApproveRoomScreenState();
}

class _WaitApproveRoomScreenState extends State<WaitApproveRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đang chờ duyêt',
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
