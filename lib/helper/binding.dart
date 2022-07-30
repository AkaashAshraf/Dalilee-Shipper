import 'package:dalile_customer/core/view_model/home_view_model.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => HomeViewModel(),permanent: true);
  }
}
