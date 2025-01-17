import 'package:flutter/material.dart';
import 'package:valid_airtech/Screens/Appointment/View/appointment_screen.dart';
import 'package:valid_airtech/Screens/attendance_screen.dart';
import 'package:valid_airtech/Screens/home_page.dart';
import 'package:valid_airtech/Screens/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:valid_airtech/Screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,

        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // supportedLocales: localizationDelegate.supportedLocales,
            // locale: localizationDelegate.currentLocale,
            title: 'Aroma',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            home: SplashScreen(),

            // home: const LatestHomepageTest(),

            // home: MyHomePage(title: "Mine Astro",),
            //  home: const ListScreen(),

            //  home: const HealthPackageDetailPage(),
          );
        });
  }
}


