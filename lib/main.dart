import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_init.dart';
import 'package:smart_rent/core/app_binding.dart';
import 'package:smart_rent/core/routes/app_pages.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'core/config/app_colors.dart';
import 'core/config/app_constant.dart';
import 'package:sizer/sizer.dart';
import 'core/lang/translate_service.dart';

void main() async {
  await AppInit.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (buildContext, orientation, screenType) {
        return GetMaterialApp(
          title: 'Smart Rent House',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary98),
            primaryColor: AppColors.primary40,
            useMaterial3: true,
          ),
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          supportedLocales: AppConstant.appSupportLocale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate
          ],
          initialRoute: AppRoutes.splash,
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 200),
          initialBinding: AppBinding(),
          getPages: AppPages.routes,
        );
      },
    );
  }
}
