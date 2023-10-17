import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/home/FinanceListings/FinanceListing.dart';
import 'package:dalile_customer/view/tam-oman-special/items/finance-dashboard-landscape-item.dart';
import 'package:dalile_customer/view/tam-oman-special/items/finance-dashboard-portrait-item.dart';
import 'package:dalile_customer/view/tam-oman-special/items/finance-dashboard-small-item.dart';
import 'package:dalile_customer/controllers/finance_listing_controller.dart';

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
      child: SmartRefresher(
        header: WaterDropMaterialHeader(
          backgroundColor: primaryColor,
        ),
        onRefresh: () async {
          await widget.controller.fetchFinanceDashbordData();

          mainScreenRefreshController.refreshCompleted();
        },
        controller: mainScreenRefreshController,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FinanceDashboardLandscapeItem(
                image: "assets/images/finance_dashboard_1.png",
                title: "TotalOrdersAmount".tr,
                value:
                    "${widget.controller.totalOrderAmountOrdersCount.value}  ${"Orders".tr}",
                value2: helperController
                    .getCurrencyInFormat(widget.controller.totalAmount.value),
                onClick: () {
                  Get.to(FinanceDasboradListing(
                      title: "AllOrders".tr,
                      type: Status.ALL,
                      subTitle_: fController.listAll.length.toString() +
                          '/' +
                          fController.totalAll.value.toString()));
                },
                color: dashboardItemColor1),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: getDashbordItemSize(context)
                  .financeDashboardPortraitItemHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FinanceDashboardSmallItem(
                          image: "assets/images/finance_dashboard_1.png",
                          title: "PaidAmount".tr,
                          value:
                              "${widget.controller.paidAmountOrdersCount.value} ${"Orders".tr}",
                          value2: helperController.getCurrencyInFormat(
                              widget.controller.paidAmount.value),
                          onClick: () {
                            Get.to(FinanceDasboradListing(
                                title: "PaidOrders".tr,
                                type: Status.PAID,
                                subTitle_: fController.listPaid.length
                                        .toString() +
                                    '/' +
                                    fController.totalPaid.value.toString()));
                          },
                          color: dashboardItemColor3),
                      FinanceDashboardSmallItem(
                          image: "assets/images/finance_dashboard_1.png",
                          title: 'CODwithDrivers'.tr,
                          value:
                              "${widget.controller.codOfdOrdersCount.value} ${"Orders".tr}",
                          value2: helperController.getCurrencyInFormat(
                              widget.controller.codWithDriversAmount.value),
                          onClick: () {
                            Get.to(FinanceDasboradListing(
                                title: "CODwithDrivers".tr,
                                type: Status.COD_WITH_DRIVERS,
                                subTitle_: fController.listCodWithDrivers.length
                                        .toString() +
                                    '/' +
                                    fController.totalCodWithDrivers.value
                                        .toString()));
                          },
                          color: dashboardItemColor4),
                    ],
                  ),
                  FinanceDashboardPortraitItem(
                      image: "assets/images/finance_dashboard_1.png",
                      title: 'ShippingCost'.tr,
                      value:
                          "${widget.controller.shippingCostOrdersCount.value}  ${"Orders".tr}",
                      value2: helperController.getCurrencyInFormat(
                          widget.controller.shipmentCost.value),
                      color: dashboardItemColor2,
                      onClick: () {})
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: getDashbordItemSize(context)
                  .financeDashboardPortraitItemHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FinanceDashboardPortraitItem(
                      image: "assets/images/finance_dashboard_1.png",
                      title: 'CODPending'.tr,
                      value:
                          "${widget.controller.codPendingOrdersCount.value} ${"Orders".tr}",
                      value2: helperController.getCurrencyInFormat(
                          widget.controller.codPendingAmount.value),
                      color: dashboardItemColor1,
                      onClick: () {
                        Get.to(FinanceDasboradListing(
                            title: "CODPending".tr,
                            type: Status.COD_PENDING,
                            subTitle_: fController.listCodPending.length
                                    .toString() +
                                '/' +
                                fController.totalCodPending.value.toString()));
                      }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FinanceDashboardSmallItem(
                          image: "assets/images/finance_dashboard_1.png",
                          title: 'ReadyToPay'.tr,
                          value:
                              "${widget.controller.readyToPayOrdersCount.value} ${"Orders".tr}",
                          value2: helperController.getCurrencyInFormat(
                              widget.controller.readyToPayAmount.value),
                          onClick: () {
                            Get.to(FinanceDasboradListing(
                                title: "ReadyToPay".tr,
                                type: Status.READY_TO_PAY,
                                subTitle_: fController.listReadyToPay.length
                                        .toString() +
                                    '/' +
                                    fController.totalReadyToPay.value
                                        .toString()));
                          },
                          color: dashboardItemColor2),
                      FinanceDashboardSmallItem(
                          image: "assets/images/finance_dashboard_1.png",
                          title: "CODReturn".tr,
                          value:
                              "${widget.controller.codReturnedOrdersCount.value} ${"Orders".tr}",
                          value2: helperController.getCurrencyInFormat(
                              widget.controller.codReturn.value),
                          onClick: () {
                            Get.to(FinanceDasboradListing(
                                title: "CODReturn".tr,
                                type: Status.COD_RETURN,
                                subTitle_: fController.listCodReturn.length
                                        .toString() +
                                    '/' +
                                    fController.totalCodReturn.value
                                        .toString()));
                          },
                          color: dashboardItemColor4),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
