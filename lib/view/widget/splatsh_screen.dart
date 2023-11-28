import 'dart:async';

import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/core/server/auth.dart';
import 'package:dalile_customer/navigation/bottom_navigation.dart';
import 'package:dalile_customer/view/home/notifications/notifications_list.dart';
import 'package:dalile_customer/view/home/search/search_screen.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/controller_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool status = false;
  @override
  void initState() {
    player = VideoPlayerController.asset("assets/images/splash.mp4");

    loginControlfff();
    player.addListener(() {});
    player.setLooping(false);
    player.initialize();
    player.play().then((value) => {
          Timer(const Duration(milliseconds: 1500), () {
            Get.offAll(status ? BottomNavigationScreen() : LoginView());
            setupInteractedMessage();
          })
        });
    // .then((value) => {Get.offAll(status ? ControllerView() : LoginView())});

    super.initState();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((val) {
      if (val.data["body"] != "")
        Get.to(SearchScreen(
          defaultSearch: val.data["body"] ?? "",
        ));
      else
        Get.to(NotificationList());
    });
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // NotificationService.showNotification(message.notification?.title ?? "",
    //     message.notification?.body.toString() ?? "", 'Order Update');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  late VideoPlayerController player;

  loginControlfff() async {
    await AuthController.isLoginUser().whenComplete(() {
      if (AuthController.isL == false) {
        setState(() {
          status = false;
        });
      } else {
        setState(() {
          status = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(status.toString());

    return Container(
        color: Colors.white,
        child: Container(
            child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ).paddingAll(50))

        //  VideoPlayer(player),
        );
  }
}
