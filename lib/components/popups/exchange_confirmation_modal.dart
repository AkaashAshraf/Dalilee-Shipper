import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/controllers/exchange_controller.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert exchangeOrderModal(BuildContext context,
    {required String title, required String message, required String orderNo}) {
  // ProfileController controller = Get.put(ProfileController());
  return modal(
    context,
    Column(
      children: [
        Stack(
          children: [
            GetX<ExchangeController>(builder: (controller) {
              return Column(children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: controller.loading.value
                      ? WaiteImage()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.pushExchangeRequest(
                                        context: context, orderNo: orderNo);
                                  },
                                  child: Text("OK".tr)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Cancel".tr)),
                            ),
                          ],
                        ),
                )
              ]);
            }),
          ],
        )
      ],
    ),
  );
}
