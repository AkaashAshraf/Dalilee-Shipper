import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/in_out_controller.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/card_body_new_log.dart';

class InShipments extends StatefulWidget {
  InShipments({Key? key}) : super(key: key);

  @override
  State<InShipments> createState() => _InShipmentsState();
}

class _InShipmentsState extends State<InShipments> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;
  final controller = Get.put(INOUTController(), permanent: true);
  final dashboarDController = Get.put(DashbordController());
  _loadMore() {
    if (controller.loadMore.value) return;
    if (controller.totalIN > controller.ordersIN.length &&
        scrollController!.position.extentAfter < 3000 &&
        controller.ordersIN.length > 0) {
      controller.fetchData(
          module: "return",
          type: "return",
          isRefresh: false,
          offset: controller.ordersIN.length);
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
      // if (controller.loadMore.value) {
      //   return const WaiteImage();
      // }
      if (controller.ordersIN.isNotEmpty) {
        return Stack(
          children: [
            SmartRefresher(
              header: WaterDropHeader(
                waterDropColor: primaryColor,
              ),
              controller: refreshController,
              onRefresh: () async {
                await controller.fetchData(module: "return", type: "return");
                refreshController.refreshCompleted();
              },
              child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, i) => const SizedBox(height: 15),
                itemCount: controller.ordersIN.length,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 10, top: 5),
                itemBuilder: (context, i) {
                  return GetBuilder<INOUTController>(
                    builder: (x) => CardBody(
                      shipment: controller.ordersIN[i],
                      willaya: controller.ordersIN[i].wilayaName,
                      area: controller.ordersIN[i].areaName,
                      date: controller.ordersIN[i].updatedAt,
                      customer_name: controller.ordersIN[i].customerName,
                      deleiver_image: controller.ordersIN[i].orderImage,
                      undeleiver_image: controller.ordersIN[i].undeliverImage,
                      pickup_image: controller.ordersIN[i].undeliverImage2,
                      orderId: controller.ordersIN[i].orderId,
                      number: controller.ordersIN[i].customerNo,
                      cod: controller.ordersIN[i].cod,
                      cop: controller.ordersIN[i].cop,
                      shipmentCost: controller.ordersIN[i].shippingPrice,
                      totalCharges:
                          '${double.parse(controller.ordersIN[i].cod.toString()) - double.parse(controller.ordersIN[i].shippingPrice.toString())}',
                      stutaus: controller.ordersIN[i].orderActivities,
                      orderNumber: controller.ordersIN[i].orderId,
                      icon: dashboarDController.trackingStatuses
                          .map((element) => element.icon.toString())
                          .toList(),
                      ref: controller.ordersIN[i].refId,
                      weight: controller.ordersIN[i].weight,
                      status_key: controller.ordersIN[i].orderStatusKey,
                      Order_current_Status:
                          controller.ordersIN[i].orderStatusName,
                      currentStep: controller.ordersIN[i].trackingId,
                      isOpen: controller.ordersIN[i].isOpen,
                      onPressedShowMore: () {
                        log(controller.ordersIN[i].isOpen.toString());
                        if (controller.ordersIN[i].isOpen == false) {
                          controller.ordersIN
                              .forEach((element) => element.isOpen = false);
                          controller.ordersIN[i].isOpen =
                              !controller.ordersIN[i].isOpen;
                          x.update();
                        } else {
                          controller.ordersIN[i].isOpen = false;
                          x.update();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            if (controller.loadMore.value)
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(child: bottomLoadingIndicator()))
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
              controller.fetchData(
                  module: "return", type: "return", isRefresh: true);
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
