import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/controllers/download_controller.dart';
import 'package:dalile_customer/controllers/finance_listing_controller.dart';
import 'package:dalile_customer/controllers/home_controller.dart';
import 'package:dalile_customer/controllers/login_controller.dart';
import 'package:dalile_customer/controllers/profile_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    try {
      Get.lazyPut(() => LoginController(), fenix: true);
    } catch (e) {}
    try {
      Get.put(() => HomeViewModel(), permanent: true);
    } catch (e) {}
    try {
      Get.put(() => FinanceListingController(), permanent: true);
    } catch (e) {}
    try {
      Get.put(() => DashbordController(), permanent: true);
    } catch (e) {}
    try {
      Get.put(() => ProfileController(), permanent: true);
    } catch (e) {}
    try {
      Get.put(() => DownloadController(), permanent: true);
    } catch (e) {}

    // Get.put(() => ViewOrderController(), permanent: true);
  }
}
