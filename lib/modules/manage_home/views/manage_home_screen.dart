import 'package:flutter/material.dart';

class ManageHomeScreen extends StatefulWidget {
  const ManageHomeScreen({super.key});

  @override
  State<ManageHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ManageHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('ManageHomeScreen'),
      ),
    );
  }
}
