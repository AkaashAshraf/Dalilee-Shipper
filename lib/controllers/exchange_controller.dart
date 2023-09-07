import 'package:dalile_customer/components/popups/info_modal.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/exchange/error422.dart';
import 'package:dalile_customer/model/exchange/exchange_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeController extends GetxController {
  RxBool loading = false.obs;

  Future<bool> pushExchangeRequest(
      {required String orderNo, required BuildContext context}) async {
    try {
      // Get.snackbar('Failed', "test");

      // return true;
      loading(true);
      var res =
          await post("/exchange-order/create", {"prev_order_id": orderNo});
      if (res != null) {
        if (res.statusCode == 200) {
          var jsonData = exchangeOrderFromJson(res.body);
          Get.back();
          Get.back();

          infoModal(context, title: "Successfully", message: jsonData.message)
              .show();

          return true;
        } else if (res.statusCode == 422) {
          var jsonData = error422ResponseFromJson(res.body);
          Get.back();
          Get.back();

          infoModal(context,
                  title: "Failed", message: jsonData.message, isError: true)
              .show();
          return false;
        }
      } else {
        Get.back();
        Get.back();
        infoModal(context,
                title: "Failed",
                message: "Something went wrong. Please try again.",
                isError: true)
            .show();
        return false;
      }
      return true;
    } finally {
      loading(false);
    }
  }
}
