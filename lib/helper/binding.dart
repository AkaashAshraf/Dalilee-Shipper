import 'package:dalile_customer/core/view_model/DashbordController.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/core/view_model/financeListingController.dart';
import 'package:dalile_customer/core/view_model/home_view_model.dart';
import 'package:dalile_customer/core/view_model/login_view_model.dart';
import 'package:dalile_customer/core/view_model/profileController.dart';
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
