import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/home/FinanceListings/FinanceListing.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/controllers/finance_listing_controller.dart';
import 'package:dalile_customer/view/widget/waiting.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FinanceDash extends StatefulWidget {
  const FinanceDash({Key? key, required this.controller}) : super(key: key);
  final DashbordController controller;

  @override
  State<FinanceDash> createState() => _FinanceDashState();
}

class _FinanceDashState extends State<FinanceDash> {
  RefreshController mainScreenRefreshController =
      RefreshController(initialRefresh: true);
  FinanceListingController fController = Get.put(FinanceListingController());
  HelperController helperController = Get.put(HelperController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Obx(
        () => SmartRefresher(
          header: WaterDropMaterialHeader(
            backgroundColor: primaryColor,
          ),
          onRefresh: () async {
            await widget.controller.fetchFinanceDashbordData();

            mainScreenRefreshController.refreshCompleted();
          },
          controller: mainScreenRefreshController,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                Get.to(FinanceDasboradListing(
                    title: "AllOrders".tr,
                    type: Status.ALL,
                    subTitle_: fController.listAll.length.toString() +
                        '/' +
                        fController.totalAll.value.toString()));
              },
              child: buildCard(
                  context,
                  _InsideShape(
                    subtitle:
                        "${widget.controller.totalOrderAmountOrdersCount.value}  ${"Orders".tr}",
                    image: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: whiteColor,
                      size: 50,
                    ),
                    // title: 'Total Orders',
                    title: 'TotalOrdersAmount'.tr,

                    numbers: helperController.getCurrencyInFormat(
                        widget.controller.totalAmount.value),
                  ),
                  15.0,
                  15.0,
                  0.0,
                  0.0),
            ),
            const SizedBox(
              height: 10,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(FinanceDasboradListing(
            //         title: "Paid Orders",
            //         type: Status.PAID,
            //         subTitle_: fController.listPaid.length.toString() +
            //             '/' +
            //             fController.totalPaid.value.toString()));
            //   },
            //   child: buildCard(
            //     context,
            //     _InsideShape(
            //       subtitle: '',
            //       image: Icon(
            //         Icons.paid_outlined,
            //         color: whiteColor,
            //         size: 50,
            //       ),
            //       // title: 'Total to be Paid',
            //       title: 'Paid Amount',
            //       numbers: '${widget.controller.paidAmount.value + " OMR"}',
            //     ),
            //     15.0,
            //     15.0,
            //     15.0,
            //     15.0,
            //   ),
            // ),

            Row(
              children: [
                _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/delivered.png',
                      // title: 'Total collected',
                      title: 'PaidAmount'.tr,
                      middleText:
                          "${widget.controller.paidAmountOrdersCount.value} ${"Orders".tr}",

                      numbers: helperController.getCurrencyInFormat(
                          widget.controller.paidAmount.value),
                    ), () {
                  Get.to(FinanceDasboradListing(
                      title: "PaidOrders".tr,
                      type: Status.PAID,
                      subTitle_: fController.listPaid.length.toString() +
                          '/' +
                          fController.totalPaid.value.toString()));
                }),
                const SizedBox(
                  width: 5,
                ),
                _buildsmallbox(
                    _InsideSmallBox(
                      // image: 'assets/images/tobepickup.png',
                      image: 'assets/images/delivered.png',

                      // title: 'COD Pending',
                      title: 'ShippingCost'.tr,
                      middleText:
                          "${widget.controller.shippingCostOrdersCount.value}  ${"Orders".tr}",
                      numbers: helperController.getCurrencyInFormat(
                          widget.controller.shipmentCost.value),
                    ),
                    () {}),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/tobepickup.png',
                      // title: 'Total collected',
                      title: 'CODPending'.tr,
                      middleText:
                          "${widget.controller.codPendingOrdersCount.value} ${"Orders".tr}",
                      numbers: helperController.getCurrencyInFormat(
                          widget.controller.codPendingAmount.value),
                    ), () {
                  Get.to(FinanceDasboradListing(
                      title: "CODPending".tr,
                      type: Status.COD_PENDING,
                      subTitle_: fController.listCodPending.length.toString() +
                          '/' +
                          fController.totalCodPending.value.toString()));
                }),
                const SizedBox(
                  width: 5,
                ),
                _buildsmallbox(
                    _InsideSmallBox(
                      // image: 'assets/images/tobepickup.png',
                      image: 'assets/images/delivered.png',
                      middleText:
                          "${widget.controller.readyToPayOrdersCount.value} ${"Orders".tr}",
                      // title: 'COD Pending',
                      title: 'ReadyToPay'.tr,

                      numbers: helperController.getCurrencyInFormat(
                          widget.controller.readyToPayAmount.value),
                    ), () {
                  Get.to(FinanceDasboradListing(
                      title: "ReadyToPay".tr,
                      type: Status.READY_TO_PAY,
                      subTitle_: fController.listReadyToPay.length.toString() +
                          '/' +
                          fController.totalReadyToPay.value.toString()));
                }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/tobepickup.png',
                      title: 'CODwithDrivers'.tr,
                      // title: 'Total with Driver',
                      middleText:
                          "${widget.controller.codOfdOrdersCount.value} ${"Orders".tr}",
                      numbers: helperController.getCurrencyInFormat(
                          widget.controller.codWithDriversAmount.value),
                    ), () {
                  Get.to(FinanceDasboradListing(
                      title: "CODwithDrivers".tr,
                      type: Status.COD_WITH_DRIVERS,
                      subTitle_: fController.listCodWithDrivers.length
                              .toString() +
                          '/' +
                          fController.totalCodWithDrivers.value.toString()));
                }),
                const SizedBox(
                  width: 5,
                ),
                _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/delivered.png',
                      title: 'CODReturn'.tr,
                      // title: 'Total Returned',
                      middleText:
                          "${widget.controller.codReturnedOrdersCount.value} ${"Orders".tr}",
                      numbers: helperController.getCurrencyInFormat(
                          widget.controller.codReturn.value),
                    ), () {
                  Get.to(FinanceDasboradListing(
                      title: "CODReturn".tr,
                      type: Status.COD_RETURN,
                      subTitle_: fController.listCodReturn.length.toString() +
                          '/' +
                          fController.totalCodReturn.value.toString()));
                }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

Expanded _buildsmallbox(Widget child, dynamic onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
          height: 125,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(15),
          child: child),
    ),
  );
}

Widget buildCard(BuildContext context, Widget child, a, b, c, d) {
  return Container(
    height: 130,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(a),
        topRight: Radius.circular(b),
        bottomLeft: Radius.circular(c),
        bottomRight: Radius.circular(d),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    child: child,
  );
}

class _InsideSmallBox extends StatelessWidget {
  const _InsideSmallBox({
    Key? key,
    required this.image,
    required this.title,
    this.middleText = "",
    required this.numbers,
  }) : super(key: key);
  final String image, title, numbers, middleText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CustomText(
            text: title,
            color: whiteColor,
            size: 14,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            CustomText(
              text: middleText,
              color: whiteColor,
              size: 12,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 25,
              width: 25,
              //   fit: BoxFit.contain,
            ),
            CustomText(
              text: numbers,
              color: whiteColor,
              size: 14,
            ),
          ],
        )
      ],
    );
  }
}

class _InsideShape extends StatelessWidget {
  const _InsideShape(
      {Key? key,
      required this.image,
      required this.title,
      required this.numbers,
      required this.subtitle})
      : super(key: key);
  final String title, numbers, subtitle;
  final Widget image;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              color: whiteColor,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: subtitle,
              color: Colors.grey.shade200,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: numbers,
              color: Colors.grey.shade200,
              size: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        image
      ],
    );
  }
}
