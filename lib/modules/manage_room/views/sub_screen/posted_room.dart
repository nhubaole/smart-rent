import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class PostedRoomScreen extends StatefulWidget {
  const PostedRoomScreen({super.key});

  @override
  State<PostedRoomScreen> createState() => _PostedRoomScreenState();
}

class _PostedRoomScreenState extends State<PostedRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phòng đã đăng',
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
