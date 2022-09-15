<<<<<<< HEAD
import 'package:dalile_customer/helper/my_services.dart';
=======
>>>>>>> origin/withDalilee_1
import 'package:dalile_customer/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await initService();
    // Get.put(FinanceListingController());
  } catch (e) {}
  runApp(const MyApp());
}
