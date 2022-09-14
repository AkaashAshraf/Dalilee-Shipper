import 'package:dalile_customer/core/view_model/DashbordController.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/core/view_model/financeListingController.dart';
import 'package:dalile_customer/core/view_model/home_view_model.dart';
import 'package:dalile_customer/core/view_model/login_view_model.dart';
import 'package:dalile_customer/core/view_model/profileController.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/core/view_model/view_order_view_model.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.put(() => HomeViewModel(), permanent: true);
    Get.put(() => FinanceListingController(), permanent: true);
    Get.put(() => DashbordController(), permanent: true);
    Get.put(ShipmentViewModel(), permanent: true);

    Get.put(() => ProfileController(), permanent: true);
    Get.put(() => DownloadController(), permanent: true);
    Get.put(() => ViewOrderController(), permanent: true);
  }
}
