import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/finance_view_model.dart';
import 'package:dalile_customer/view/menu/finances/finance_enquiry.dart';
import 'package:dalile_customer/view/menu/finances/view_order.dart';
import 'package:dalile_customer/view/menu/finances/manage_accounts.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpendedView extends StatelessWidget {
  const OpendedView({Key? key, required this.c}) : super(key: key);
  final FinanceController c;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                !c.isLoading.value
                    ? MaterialButton(
                        onPressed: () {
                          c.fetchOpenData();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            CustomText(
                              text: 'Updated data ',
                              color: Colors.grey,
                              alignment: Alignment.center,
                              size: 10,
                            ),
                            Icon(
                              Icons.refresh,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(5), child: WaiteImage()),
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
                              const CustomText(
                                text: 'Store Remaining Amount',
                                color: whiteColor,
                                size: 17,
                                fontWeight: FontWeight.w500,
                                alignment: Alignment.centerLeft,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text:
                                        '${c.openData.value.remaining ?? 0.00} OMR',
                                    size: 20,
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
                      _buildBodyRow('Total Orders Delivered',
                          '${c.openData.value.totalOrdersDelivered ?? 0}     '),
                      _buildBodyRow('Total Amount of Request',
                          '${c.openData.value.totalAmountRequest ?? 0.00} OMR'),
                      _buildBodyRow('Delivery Fee',
                          '${c.openData.value.deliveryFee ?? 0.00} OMR'),
                      _buildBodyRow('Collection Fee',
                          '${c.openData.value.collectionFee ?? 0.00} OMR'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButtom(
                  text: 'View Orders',
                  onPressed: () {
                    Get.to(() => ViewOrderView(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 400));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtom(
                  text: 'Finance Inquiry',
                  onPressed: () {
                    Get.to(() => FinanceEnquiry(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 400));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtom(
                  text: 'Manage Accounts',
                  onPressed: () {
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
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          height: 30,
          width: 4,
          color: primaryColor,
        ),
        title: CustomText(
          text: title,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.w500,
          size: 13,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            subtitle,
            style:
                const TextStyle(color: text1Color, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
