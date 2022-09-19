
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin? flip;

  static FlutterLocalNotificationsPlugin getFlipInstance() {
    if (flip == null) {
      flip = FlutterLocalNotificationsPlugin();

      // app_icon needs to be a added as a drawable
      // resource to the Android head project.
      var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var ios = const IOSInitializationSettings();

      var settings = InitializationSettings(android: android, iOS: ios);
      flip!.initialize(settings);
    }

    return flip as FlutterLocalNotificationsPlugin;
  }

  static Future showNotification(
      String title, String body, String chanel_id) async {
    // Get.snackbar(title, body, backgroundColor: Colors.red.withOpacity(0.6));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        chanel_id, chanel_id,
        priority: Priority.high,
        autoCancel: true,
        setAsGroupSummary: false,
        fullScreenIntent: true,
        enableLights: true,
        playSound: true);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await getFlipInstance().show(0, title, body, platformChannelSpecifics,
        payload: 'Default_Sound');
  }
}
