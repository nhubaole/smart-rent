import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/chat/views/home_screen.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/manage_account/views/manage_account_screen.dart';
import 'package:smart_rent/modules/manage_home/views/manage_home_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedPage = 0;
  void changeScreen(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    if (selectedPage == 0) {
      activePage = const HomeScreen();
    } else if (selectedPage == 1) {
      activePage = const ManageHomeScreen();
    } else if (selectedPage == 2) {
      activePage = const ChatScreen();
    } else if (selectedPage == 3) {
      activePage = const ManageAccountScreen();
    }
    return Scaffold(
      body: activePage,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primary95,
        foregroundColor: Colors.black,
        elevation: 24,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Colors.blue,
            width: 1.0,
            style: BorderStyle.none,
          ),
        ),
        mini: true,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
          child: GNav(
            tabActiveBorder: Border.all(color: primary60, width: 1),
            haptic: true,
            //curve: Curves.easeOut,
            //duration: const Duration(milliseconds: 200),
            backgroundColor: Colors.white,
            gap: 15,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            activeColor: primary60,
            rippleColor: Colors.red,
            hoverColor: Colors.yellow,
            tabBackgroundColor: primary98,
            onTabChange: (index) {
              changeScreen(index);
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Trang Chủ'),
              GButton(icon: Icons.manage_search, text: 'Phòng của bạn'),
              GButton(icon: Icons.chat_bubble_outline, text: 'Tin Nhắn'),
              GButton(icon: Icons.manage_accounts, text: 'Tài Khoản'),
            ],
          ),
        ),
      ),
    );
  }
}
