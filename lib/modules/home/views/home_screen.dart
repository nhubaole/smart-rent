import 'package:flutter/material.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';

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
