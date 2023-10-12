import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_account/views/account_nav_button.dart';
import 'package:smart_rent/modules/manage_account/views/account_show_information.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary40,
                  primary80,
                ],
                begin: Alignment(0, 0),
                end: Alignment(0, 2),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 62, horizontal: 24),
              child: Text(
                'Tài khoản',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  AccountShowInformation(),
                  SizedBox(
                    height: 30,
                  ),
                  AccountNavButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
