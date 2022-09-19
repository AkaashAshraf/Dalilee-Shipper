import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/calculable_view.dart';
import 'package:dalile_customer/view/home/home_view.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/menu/calculate/calculate_view.dart';
import 'package:dalile_customer/view/menu/complains/complain_view.dart';
import 'package:dalile_customer/view/menu/finances/finance.dart';
import 'package:dalile_customer/view/menu/profiles/profile.dart';
import 'package:dalile_customer/view/offices_view.dart/offices_view.dart';
import 'package:dalile_customer/view/pickup/pickup_view.dart';
import 'package:dalile_customer/view/shipments/shipments_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/iconn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends GetxController {
  Widget _screen = HomeView();

  get screen => _screen;

  int i = 0;
  ii() {
    if (i == 3) {
      i = 2;
      update();
    }
  }

  void buildProdAlrt(BuildContext context) async {
    return showModalBottomSheet(
        elevation: 0,
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.30,
              builder: (context, controller2) => Container(
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.expand_more_outlined,
                                size: 30, color: text1Color),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenu(Icons.monetization_on_outlined,
                                    "Finance", context, () {
                                  Get.back();
                                  _screen = const MenuPageView();
                                  _screenMenu = FinanceView();

                                  update();
                                }),

                                buildMenu(Icons.apartment_outlined, "Offices",
                                    context, () {
                                  Get.back();
                                  _screen = const MenuPageView();
                                  _screenMenu = OfficesView();
                                  update();
                                }),
                                // dlv
                                buildMenu(Icons.settings_outlined, "Settings",
                                    context, () {
                                  Get.back();
                                  _screen = const MenuPageView();
                                  _screenMenu = const ProfileView();

                                  update();
                                }),

                                buildMenu(MyTicket.fontisto_ticket_alt,
                                    "Ticket", context, () {
                                  Get.back();
                                  _screen = const MenuPageView();
                                  _screenMenu = ComplainView();
                                  update();
                                }),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // buildMenu(Icons.calculate_outlined, "Calculate",
                                //     context, () {
                                //   Get.back();
                                //   _screen = const MenuPageView();
                                //   _screenMenu = const CalculateView();
                                //   update();
                                // }),
                                buildMenu(
                                    Icons.logout_outlined, "Sign out", context,
                                    () {
                                  Get.defaultDialog(
                                      title: 'Sgin Out',
                                      titlePadding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 15),
                                      contentPadding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          top: 0,
                                          bottom: 15),
                                      middleText:
                                          'Are you sure you want to sign out ?',
                                      textCancel: 'Cancel',
                                      textConfirm: 'Ok',
                                      buttonColor: primaryColor,
                                      confirmTextColor: Colors.white,
                                      cancelTextColor: Colors.black,
                                      radius: 10,
                                      backgroundColor: whiteColor,
                                      onConfirm: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        prefs.remove("loginData");
                                        prefs.remove("token");
                                        prefs.clear();
                                        Get.deleteAll();
                                        Get.offAll(() => LoginView());
                                      });
                                }),
                                buildMenu(
                                    Icons.delete, "Delete Account", context,
                                    () {
                                  Get.defaultDialog(
                                      title: 'Delete Account',
                                      titlePadding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 15),
                                      contentPadding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          top: 0,
                                          bottom: 15),
                                      middleText:
                                          'Are you sure you want to delete your account ?',
                                      textCancel: '  Cancel  ',
                                      textConfirm: '  Delete  ',
                                      buttonColor: primaryColor,
                                      confirmTextColor: Colors.white,
                                      cancelTextColor: Colors.black,
                                      radius: 10,
                                      backgroundColor: whiteColor,
                                      onConfirm: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        prefs.remove("loginData");
                                        prefs.remove("token");
                                        prefs.clear();
                                        Get.deleteAll();
                                        Get.offAll(() => LoginView());
                                      });
                                }),
                              ],
                            ),
                          ],
                        )),
                  ));
        });
  }

  Widget buildMenu(
      IconData icon, String text, context, void Function()? onTap) {
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

  onSelectItem(int i, context) {
    switch (i) {
      case 0:
        _screen = HomeView();

        update();
        break;
      case 1:
        _screen = PickupView();
        update();
        break;
      case 2:
        _screen = const ShipmentView();
        update();
        break;
      case 3:
        update();
        buildProdAlrt(context);
        break;
    }
    update();
  }

  Widget _screenMenu = const ProfileView();
  get screenMenu => _screenMenu;
}
