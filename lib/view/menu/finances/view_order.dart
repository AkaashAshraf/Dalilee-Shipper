import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/controllers/shipment_controller.dart';
import 'package:dalile_customer/controllers/view_order_controller.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ViewOrderView extends StatefulWidget {
  ViewOrderView({Key? key}) : super(key: key);

  @override
  State<ViewOrderView> createState() => _ViewOrderViewState();
}

class _ViewOrderViewState extends State<ViewOrderView> {
  ScrollController? scrollController;

  final controller = Get.put(ViewOrderController());
  final dashboardController = Get.put(DashbordController());

  RefreshController refreshController = RefreshController(initialRefresh: true);
  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore();
    });
    super.dispose();
  }

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
    super.initState();
  }

  void _loadMore() async {
    if (controller.totalOrders.value > controller.viewOrderData.length &&
        scrollController!.position.extentAfter < 100.0) {
      if (!controller.loadMore.value) {
        await controller.fetchViewOrderData(isRefresh: false);
        if (mounted)
          setState(() {
            subTitle =
                "(${controller.viewOrderData.length.toString()}/${controller.totalOrders.toString()})";
          });
      }
    }
  } //_loadMore

  void _refresh() async {
    if (!controller.isLoading.value) {
      await controller.fetchViewOrderData(isRefresh: true);
      if (mounted)
        setState(() {
          subTitle =
              "(${controller.viewOrderData.length.toString()}/${controller.totalOrders.toString()})";
        });
    }
    refreshController.refreshCompleted();
  } //_refresh

  String subTitle = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
          title: GetX<ViewOrderController>(builder: (_controller) {
            return CustomText(
                text: 'ViewOrders'.tr +
                    ' (${_controller.viewOrderData.length.toString()}/${_controller.totalOrders.value.toString()})',
                color: whiteColor,
                size: 18,
                alignment: Alignment.center);
          }),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: Center(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const WaiteImage();
              }
              if (controller.viewOrderData.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmptyState(
                      label: 'NoData'.tr,
                    ),
                    MaterialButton(
                      onPressed: () {
                        controller.isLoading(true);
                        controller.fetchViewOrderData();
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
              }
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 14,
                    child: SmartRefresher(
                      header: WaterDropHeader(
                        waterDropColor: primaryColor,
                      ),
                      controller: refreshController,
                      onRefresh: _refresh,
                      child: ListView.separated(
                        controller: scrollController,
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 15),
                        itemCount: controller.viewOrderData.length,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10, top: 5),
                        itemBuilder: (context, i) {
                          return GetBuilder<ShipmentViewModel>(
                              init: ShipmentViewModel(),
                              builder: (x) {
                                return CardBody(
                                  shipment: controller.viewOrderData[i],
                                  willaya:
                                      controller.viewOrderData[i].wilayaName,
                                  area: controller.viewOrderData[i].areaName,
                                  date: controller.viewOrderData[i].updatedAt,
                                  status_key: controller
                                      .viewOrderData[i].orderStatusKey,
                                  deleiver_image:
                                      controller.viewOrderData[i].orderImage,
                                  Order_current_Status: controller
                                      .viewOrderData[i].orderStatusKey,
                                  undeleiver_image: controller
                                      .viewOrderData[i].undeliverImage,
                                  pickup_image:
                                      controller.viewOrderData[i].pickupImage,
                                  customer_name:
                                      controller.viewOrderData[i].customerName,
                                  orderId: controller.viewOrderData[i].orderId,
                                  number:
                                      controller.viewOrderData[i].customerNo,
                                  cod:
                                      controller.viewOrderData[i].cod ?? "0.00",
                                  cop:
                                      controller.viewOrderData[i].cop ?? "0.00",
                                  shipmentCost: controller
                                          .viewOrderData[i].shippingPrice ??
                                      "0.00",
                                  orderNumber:
                                      controller.viewOrderData[i].orderId,
                                  totalCharges:
                                      '${(double.tryParse(controller.viewOrderData[i].cod.toString()) ?? 0.0) - (double.tryParse(controller.viewOrderData[i].shippingPrice.toString()) ?? 0.0)}',
                                  stutaus: controller
                                      .viewOrderData[i].orderActivities,
                                  icon: dashboardController.trackingStatuses
                                      .map((element) => element.icon.toString())
                                      .toList(),
                                  ref: controller.viewOrderData[i].refId,
                                  weight: controller.viewOrderData[i].weight,
                                  currentStep:
                                      controller.viewOrderData[i].trackingId,
                                  isOpen: controller.viewOrderData[i].isOpen,
                                  onPressedShowMore: () {
                                    controller.viewOrderData[i].isOpen =
                                        !controller.viewOrderData[i].isOpen;
                                    x.update();
                                    print(controller.viewOrderData[i].isOpen
                                        .toString());
                                  },
                                );
                              });
                        },
                      ),
                    ),
                  ),
                  if (controller.loadMore.value) bottomLoadingIndicator()
                ],
              );
            }),
          ),
        ));
  }
}
