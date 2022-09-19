import 'package:dalile_customer/core/server/auth.dart';
import 'package:dalile_customer/helper/binding.dart';
import 'package:dalile_customer/view/widget/splatsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(builder: (context, snapshot) {
      // future:
      // Firebase.initializeApp();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        home: const SplashScreen(),
      );
    });

    //  GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   initialBinding: Binding(),
    //   home: const SplashScreen(),
    // );
  }
}
