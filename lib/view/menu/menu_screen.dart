import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/menu/dispatcher/AddOrder.dart';
import 'package:dalile_customer/view/menu/dispatcher/my_orders.dart';
import 'package:dalile_customer/view/menu/finances/finance.dart';
import 'package:dalile_customer/view/menu/profiles/profile.dart';
import 'package:dalile_customer/view/offices_view.dart/offices_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/iconn.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          foregroundColor: Colors.black,
          title: Text(
            "MENU".tr,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // height: screenHeight(context) * 0.4,
              width: screenWidth(context),
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 1.0,
                      spreadRadius: 2.0,
                      offset:
                          Offset(0.5, 0.1), // shadow direction: bottom right
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildMenu(
                            Icons.apartment_outlined, "Offices".tr, context,
                            () {
                          Get.to(OfficesView());
                        }),
                        // dlv
                        buildMenu(
                            Icons.settings_outlined, "Settings".tr, context,
                            () {
                          Get.to(ProfileView());
                        }),

                        buildMenu(
                            Icons.add_box_outlined, "AddOrder".tr, context, () {
                          // Get.snackbar('soon_available'.tr, " ",
                          //     colorText: Colors.orange);
                          Get.to(AddOrder());
                        }),

                        buildMenu(Icons.my_library_books_outlined,
                            "myOrders".tr, context, () {
                          // Get.snackbar('soon_available'.tr, " ",
                          //     colorText: Colors.orange);
                          // return;
                          Get.put(DispatcherController()).fetchMyOrders();
                          Get.to(MyOrders());
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // buildMenu(Icons.calculate_outlined,
                        //     "Calculate".tr, context, () {
                        //   Get.back();
                        //   _screen = const MenuPageView();
                        //   _screenMenu = const CalculateView();
                        //   update();
                        // }),

                        buildMenu(
                            MyTicket.fontisto_ticket_alt, "Ticket".tr, context,
                            () {
                          {
                            Get.snackbar('soon_available'.tr, " ",
                                colorText: Colors.orange);
                          }
                        }),
                        buildMenu(Icons.logout_outlined, "Logout".tr, context,
                            () {
                          Get.defaultDialog(
                              title: "Logout".tr,
                              titlePadding: const EdgeInsets.all(15),
                              contentPadding: const EdgeInsets.all(5),
                              middleText: 'Areyoulogout'.tr,
                              textCancel: 'Cancel'.tr,
                              textConfirm: 'Ok'.tr,
                              buttonColor: primaryColor,
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.black,
                              radius: 10,
                              backgroundColor: whiteColor,
                              onConfirm: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                prefs.remove("loginData");
                                prefs.remove("token");
                                prefs.clear();
                                Get.deleteAll();
                                Get.offAll(() => LoginView());
                              });
                        }),
                        buildMenu(Icons.delete, "DeleteAccount".tr, context,
                            () {
                          Get.defaultDialog(
                              title: 'DeleteAccount'.tr,
                              titlePadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              contentPadding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 0, bottom: 15),
                              middleText: 'Aredeleteaccount'.tr,
                              textCancel: 'Cancel'.tr,
                              textConfirm: 'Ok'.tr,
                              buttonColor: primaryColor,
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.black,
                              radius: 10,
                              backgroundColor: whiteColor,
                              onConfirm: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                prefs.remove("loginData");
                                prefs.remove("token");
                                prefs.clear();
                                Get.deleteAll();
                                Get.offAll(() => LoginView());
                              });
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ).paddingAll(20),
              ),
            )
          ],
        ));
  }
}

Widget buildMenu(IconData icon, String text, context, void Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: primaryColor,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          height: MediaQuery.of(context).size.width / 7,
          width: MediaQuery.of(context).size.width / 7,
          child: Icon(icon, color: whiteColor, size: 30),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: CustomText(
            text: text,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
