import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

Future<void> initService() async {
  await Get.putAsync(() => MyService().init());
}
