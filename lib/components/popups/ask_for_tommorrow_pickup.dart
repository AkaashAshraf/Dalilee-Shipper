import 'dart:developer';

import 'package:dalile_customer/components/common/simple_button.dart';
import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/model/Pickup/create_pickup.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Alert minimumAmountModal(String text, lat, lng,
    {required String url,
    required String time,
    bool isTommorow = false,
    required double screenWidth,
    required isAutoDailyPickup,
    required BuildContext context}) {
  return modal(
    context,
    GetX<PickupController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  text,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "primary",
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 1,
          //   width: MediaQuery.of(context).size.width,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.craetePickupLoading.value == false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.39,
                      child: SimpleButton(
                        title: "cancel".tr,
                        onPress: () {
                          Get.back();
                          // Navigator.pop(context);
                        },
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.39,
                      child: SimpleButton(
                        title: "Yes".tr,
                        onPress: () async {
                          var pickupController = Get.find<PickupController>();

                          try {
                            pickupController.craetePickupLoading(true);

                            var _url = "$like$url";
                            final prefs = await SharedPreferences.getInstance();
                            String token = prefs.getString('token') ?? '';
                            var response =
                                await http.post(Uri.parse(_url), headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            }, body: {
                              "lat": "$lat",
                              "pickup_time": "$time",
                              "lng": "$lng",
                              "create_next_day": "1",
                              "is_cron_active": Get.put(PickupController())
                                      .isAutoDailyPickup
                                      .value
                                  ? "1"
                                  : "0"
                              // "is_cron_active": "${time != "" ? 1 : 0}"
                            });
                            // pickupController.craetePickupLoading(false);
                            // inspect(response);
                            if (response.statusCode == 200) {
                              var res = createPickFromJson(response.body);
                              // Get.back();
                              {
                                if (res.status == "success") {
                                  Get.back();
                                  // Get.to(PickupView());
                                  Get.snackbar('Successful', "${res.message}",
                                      colorText: whiteColor,
                                      backgroundColor:
                                          primaryColor.withOpacity(0.7));
                                  pickupController.fetchAllPickupData();
                                  pickupController.fetchTodayPickupData();
                                } else {
                                  Get.snackbar('Failed', "${res.message}",
                                      colorText: whiteColor,
                                      backgroundColor: Colors.red[800]);
                                }
                                // showDialog(
                                //     barrierDismissible: true,
                                //     barrierColor: Colors.transparent,
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return CustomDialogBoxAl(
                                //         title: res.status == "warning"
                                //             ? "Warning"
                                //             : res.status == "error"
                                //                 ? "Failed"
                                //                 : "Done !!",
                                //         warning: res.status == "warning"
                                //             ? true
                                //             : false,
                                //         error: res.status == "errot"
                                //             ? true
                                //             : false,
                                //         des: res.message,
                                //         icon: Icons.priority_high_outlined,
                                //       );
                                //     });
                              }
                              // var data = json.decode(response.body);

                            } else {}
                          } catch (e) {
                          } finally {
                            pickupController.craetePickupLoading(false);
                          }
                        },
                        backgroundColor: primaryColor,
                      ),
                    )
                  ],
                )
              else
                WaiteImage()
            ],
          ),
        ],
      );
    }),
  );
}
