//splash page
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/modules/splash/controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(197, 138, 198, 230),
                Color.fromARGB(251, 10, 130, 185)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/ic_splash.svg'),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Smart Rent House',
                style: GoogleFonts.ubuntuCondensed(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.0),
                child: LinearProgressIndicator(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(197, 138, 198, 230),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
