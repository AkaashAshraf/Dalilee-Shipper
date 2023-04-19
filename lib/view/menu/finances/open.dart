import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/enquiry_controller.dart';
import 'package:dalile_customer/controllers/finance_controller.dart';
import 'package:dalile_customer/controllers/view_order_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/menu/finances/finance_enquiry.dart';
import 'package:dalile_customer/view/menu/finances/view_order.dart';
import 'package:dalile_customer/view/menu/finances/manage_accounts.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OpendedView extends StatelessWidget {
  OpendedView({Key? key}) : super(key: key);
  final FinanceController c = Get.find<FinanceController>();
  final HelperController helperController = Get.put(HelperController());

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
        child: Obx(
          () => SmartRefresher(
            header: WaterDropHeader(
              waterDropColor: primaryColor,
            ),
            controller: refreshController,
            onRefresh: () async {
              await c.fetchOpenData();

              // await widget.c.fetchCloseData(isRefresh: true);
              refreshController.refreshCompleted();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 250,
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Column(
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/Groupbody.png',
                            width: MediaQuery.of(context).size.width,
                            height: 90,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: 'StoreRemainingAmount'.tr,
                                    color: whiteColor,
                                    size:
                                        Get.locale.toString() == "ar" ? 15 : 17,
                                    fontWeight: FontWeight.w500,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    direction: TextDirection.ltr,
                                    text: helperController.getCurrencyInFormat(
                                        c.openData.value.remaining),
                                    size:
                                        Get.locale.toString() == "ar" ? 15 : 17,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w800,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  Image.asset(
                                    'assets/images/moneyimg.png',
                                    height: 30,
                                    width: 40,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                      _buildBodyRow('TotalOrdersDelivered'.tr,
                          '${c.openData.value.totalOrdersDelivered ?? 0}     '),
                      _buildBodyRow(
                          'TotalAmountRequest'.tr,
                          helperController.getCurrencyInFormat(
                              c.openData.value.totalAmountRequest)),
                      _buildBodyRow(
                          'TotalCC'.tr,
                          helperController.getCurrencyInFormat(
                              c.openData.value.collectionFee)),
                      _buildBodyRow(
                          'DeliveryFee'.tr,
                          c.openData.value.deliveryFee > 0
                              ? "-" +
                                  helperController.getCurrencyInFormat(
                                      c.openData.value.deliveryFee)
                              : helperController.getCurrencyInFormat(
                                  c.openData.value.deliveryFee)),
                      if (false)
                        _buildBodyRow(
                            'CollectionFee'.tr,
                            helperController.getCurrencyInFormat(
                                c.openData.value.collectionFee)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButtom(
                  text: 'ViewOrders'.tr,
                  onPressed: () {
                    Get.put(ViewOrderController());
                    Get.to(() => ViewOrderView(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 0));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtom(
                  text: 'FinanceInquiry'.tr,
                  onPressed: () {
                    Get.put(EnquiryFinanceController())
                        .fetchEnquiryFinanceData();
                    Get.to(() => FinanceEnquiry(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 400));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtom(
                  text: 'ManageAccounts'.tr,
                  onPressed: () async {
                    // final prefs = await SharedPreferences.getInstance();

                    // String token = prefs.getString('name') ?? '';

                    // Get.snackbar(token, " ", colorText: Colors.orange);
                    // return;
                    Get.to(() => ManageAccountsView(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 400));
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBodyRow(String title, String subtitle) {
    return ListTile(
        contentPadding: const EdgeInsets.only(left: 20),
        leading: Container(
          height: 30,
          width: 4,
          color: primaryColor,
        ),
        title: CustomText(
          text: title,
          fontWeight: FontWeight.w500,
          size: Get.locale.toString() == "ar" ? 12 : 13,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            subtitle,
            textDirection: TextDirection.ltr,
            style:
                const TextStyle(color: text1Color, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
