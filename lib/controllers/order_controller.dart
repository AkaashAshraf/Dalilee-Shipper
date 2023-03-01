import 'package:get/get.dart';

class ShopController extends GetxController {
  RxList notificationList = [].obs;
  RxList<String> orders = ["Order", "Order2", "Order3"].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getSeenNotificationCount() {}
}
