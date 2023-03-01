import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/my_lang_controller.dart';
import 'package:dalile_customer/controllers/notification_controller.dart';
import 'package:dalile_customer/helper/binding.dart';
import 'package:dalile_customer/helper/mytranslat.dart';
import 'package:dalile_customer/view/home/notifications/notifications_list.dart';
import 'package:dalile_customer/view/home/search/search_screen.dart';
import 'package:dalile_customer/view/widget/splatsh_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      if (message.notification != null) {
        if (message.data["body"] != "") {
          Get.put(NotificationController()).unreadNotification.value += 1;
          Get.snackbar("", message.notification?.body ?? "",
              colorText: Colors.white, overlayColor: Colors.orange);
          // Get.to(SearchScreen(
          //   defaultSearch: message.data["body"] ?? "",
          // ));
        }
        // else
        //   Get.to(NotificationList());
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      inspect(message);
      RemoteNotification? notification = message?.notification;

      AndroidNotification? android = message?.notification?.android;
      if (notification != null && android != null) {
        // Get.snackbar(" ", notification.body.toString(),
        //     colorText: Colors.orange);

        if (message?.data["body"] != "")
          Get.to(SearchScreen(
            defaultSearch: message?.data["body"] ?? "",
          ));
        else
          Get.to(NotificationList());
      }
    }); // hand
    MyLang controller = Get.put(MyLang());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(builder: (context, snapshot) {
      // future:
      // Firebase.initializeApp();
      return GetMaterialApp(
        translations: MyTranslations(),
        locale: controller.locale,
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
