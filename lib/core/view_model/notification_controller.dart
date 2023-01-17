import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/notifications/notification_list.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool loading = false.obs;
  RxList<Notification> notifications = <Notification>[].obs;

  @override
  void onInit() {
    fetchNotications();
    super.onInit();
  }

  fetchNotications({String module = "order-undelivered"}) async {
    try {
      loading(true);

      var response = await post(
          "/notifications", {"module": module, "limit": "500", "offset": "0"});
      // inspect(response);
      if (response != null) {
        var jsonResponse = notificationsFromJson(response?.body);
        notifications.value = jsonResponse?.data?.notifications ?? [];
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(e.toString(), " ",
          backgroundColor: primaryColor, colorText: whiteColor);
    } finally {
      loading(false);
    }
  }
}
