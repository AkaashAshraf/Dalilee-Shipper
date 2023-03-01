
import 'package:dalile_customer/helper/my_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLang extends GetxController {
  late Locale locale;
  MyService myService = Get.find();

  changeLang(String lang) {
    Locale locale = Locale(lang);
    myService.sharedPreferences.setString("lang", lang);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? shared = myService.sharedPreferences.getString('lang');
    if (shared == null) {
      locale = Locale(Get.deviceLocale!.languageCode);
    } else if (shared == "ar") {
      locale = const Locale("ar");
    }else{
        locale = const Locale("en");
    }
    super.onInit();
  }
}
