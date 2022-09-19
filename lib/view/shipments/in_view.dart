import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InShipments extends StatefulWidget {
  InShipments({Key? key}) : super(key: key);

  @override
  State<InShipments> createState() => _InShipmentsState();
}

class _InShipmentsState extends State<InShipments> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;
  final controller = Get.put(ShipmentViewModel(), permanent: true);
  final dashboarDController = Get.put(DashbordController());
  _loadMore() {
    if (controller.inLoadMore.value) return;
    if (controller.total_in > controller.inList.length &&
        scrollController!.position.extentAfter < 3000) {
      controller.fetchInShipemetData(isRefresh: false);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
  }

  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingIN.value) {
        return const WaiteImage();
      }
      if (controller.inList.isNotEmpty) {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                  child: MyInput(
                    keyboardType: TextInputType.text,
                    hintText: 'EnterShipmentNumber'.tr,
                    onChanged: controller.onSearchTextChanged,
                    controller: controller.searchConter,
                    suffixIcon: MaterialButton(
                        minWidth: 5,
                        color: primaryColor,
                        onPressed: () {},
                        child: const Icon(
                          Icons.search,
                          color: whiteColor,
                        )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 12,
                  child: SmartRefresher(
                    header: WaterDropHeader(
                      waterDropColor: primaryColor,
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await controller.fetchInShipemetData(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    child: controller.searchResult.isNotEmpty
                        ? GetX<ShipmentViewModel>(builder: (_controller) {
                            return ListView.separated(
                              controller: scrollController,
                              separatorBuilder: (context, i) =>
                                  const SizedBox(height: 15),
                              itemCount: controller.searchResult.length,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10, top: 5),
                              itemBuilder: (context, i) {
                                return GetBuilder<ShipmentViewModel>(
                                  builder: (x) => CardBody(
                                    willaya:
                                        controller.searchResult[i]!.wilayaName,
                                    area: controller.searchResult[i]!.areaName,
                                    date: controller.searchResult[i]!.updatedAt,
                                    customer_name: controller
                                        .searchResult[i]!.customerName,
                                    deleiver_image: controller
                                        .searchResult[i]!.orderDeliverImage,
                                    undeleiver_image: controller
                                        .searchResult[i]!.orderUndeliverImage,
                                    pickup_image: controller
                                        .searchResult[i]!.orderPickupImage,
                                    orderId:
                                        controller.searchResult[i]!.orderId ??
                                            "00",
                                    number: controller.searchResult[i]!.phone ??
                                        "+968",
                                    cod: controller.searchResult[i]!.cod ??
                                        "0.00",
                                    cop: controller.searchResult[i]!.cop ??
                                        "0.00",
                                    orderNumber:
                                        controller.searchResult[i]!.orderNo,
                                    shipmentCost: controller
                                            .searchResult[i]!.shippingPrice ??
                                        "0.00",
                                    totalCharges:
                                        '${double.parse(controller.searchResult[i]!.cod.toString()) - double.parse(controller.searchResult[i]!.shippingPrice.toString())}',
                                    stutaus: controller
                                        .searchResult[i]!.orderActivities,
                                    status_key: controller
                                        .searchResult[i]!.orderStatusKey,
                                    Order_current_Status: controller
                                        .searchResult[i]!.orderStatusName,
                                    icon: dashboarDController.trackingStatuses
                                        .map((element) =>
                                            element.icon.toString())
                                        .toList(),
                                    ref: controller.searchResult[i]!.refId ??
                                        "0",
                                    weight:
                                        controller.searchResult[i]!.weight ??
                                            "0.00",
                                    currentStep: controller
                                            .searchResult[i]!.currentStatus ??
                                        1,
                                    isOpen: controller.searchResult[i]!.isOpen,
                                    onPressedShowMore: () {
                                      controller.searchResult[i]!.isOpen =
                                          !controller.searchResult[i]!.isOpen;
                                      x.update();
                                      print(controller.searchResult[i]!.isOpen
                                          .toString());
                                    },
                                  ),
                                );
                              },
                            );
                          })
                        : controller.searchResult.isEmpty &&
                                controller.searchConter.text.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EmptyState(
                                    label: 'NoData'.tr,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      controller.fetchInShipemetData();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: 'Updateddata'.tr,
                                          color: Colors.grey,
                                          alignment: Alignment.center,
                                          size: 12,
                                        ),
                                        Icon(
                                          Icons.refresh,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                controller: scrollController,
                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 15),
                                itemCount: controller.inList.length,
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10, top: 5),
                                itemBuilder: (context, i) {
                                  return GetBuilder<ShipmentViewModel>(
                                    builder: (x) => CardBody(
                                      willaya: controller.inList[i]!.wilayaName,
                                      area: controller.inList[i]!.areaName,
                                      date: controller.inList[i]!.updatedAt,
                                      customer_name:
                                          controller.inList[i]!.customerName,
                                      deleiver_image: controller
                                          .inList[i]!.orderDeliverImage,
                                      undeleiver_image: controller
                                          .inList[i]!.orderUndeliverImage,
                                      pickup_image: controller
                                          .inList[i]!.orderPickupImage,
                                      orderId:
                                          controller.inList[i]!.orderId ?? "00",
                                      number:
                                          controller.inList[i]!.phone ?? "+968",
                                      cod: controller.inList[i]!.cod ?? "0.00",
                                      cop: controller.inList[i]!.cop ?? "0.00",
                                      shipmentCost:
                                          controller.inList[i]!.shippingPrice ??
                                              "0.00",
                                      totalCharges:
                                          '${double.parse(controller.inList[i]!.cod.toString()) - double.parse(controller.inList[i]!.shippingPrice.toString())}',
                                      stutaus:
                                          controller.inList[i]!.orderActivities,
                                      orderNumber:
                                          controller.inList[i]!.orderNo,
                                      icon: dashboarDController.trackingStatuses
                                          .map((element) =>
                                              element.icon.toString())
                                          .toList(),
                                      ref: controller.inList[i]!.refId ?? "0",
                                      weight: controller.inList[i]!.weight ??
                                          "0.00",
                                      status_key:
                                          controller.inList[i]!.orderStatusKey,
                                      Order_current_Status:
                                          controller.inList[i]!.orderStatusName,
                                      currentStep:
                                          controller.inList[i]!.currentStatus ??
                                              1,
                                      isOpen: controller.inList[i]!.isOpen,
                                      onPressedShowMore: () {
                                        log(controller.inList[i]!.isOpen
                                            .toString());
                                        if (controller.inList[i]!.isOpen ==
                                            false) {
                                          controller.inList.forEach((element) =>
                                              element!.isOpen = false);
                                          controller.inList[i]!.isOpen =
                                              !controller.inList[i]!.isOpen;
                                          x.update();
                                        } else {
                                          controller.inList[i]!.isOpen = false;
                                          x.update();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),
            if (controller.inLoadMore.value) bottomLoadingIndicator()
          ],
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyState(
            label: 'NoData'.tr,
          ),
          MaterialButton(
            onPressed: () {
              controller.fetchInShipemetData(isRefresh: true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Updateddata'.tr,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  size: 12,
                ),
                Icon(
                  Icons.refresh,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
