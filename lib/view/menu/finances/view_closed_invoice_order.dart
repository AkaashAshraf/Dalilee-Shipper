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

class ViewClosedInvoiceOrderView extends StatefulWidget {
  ViewClosedInvoiceOrderView({Key? key, required this.invoiceId})
      : super(key: key);
  final String invoiceId;
  @override
  State<ViewClosedInvoiceOrderView> createState() => _ViewOrderViewState();
}

class _ViewOrderViewState extends State<ViewClosedInvoiceOrderView> {
  ScrollController? scrollController;

  final controller = Get.put(ViewOrderController());
  final dashboardController = Get.put(DashbordController());
  bool loading = true;
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
    if (controller.totalClosedOrders.value >
            controller.closedOrderData.length &&
        controller.closedOrderData.length > 0 &&
        scrollController!.position.extentAfter < 100.0) {
      if (!controller.loadMore.value) {
        await controller.fetchClosedInvoiceData(
            isRefresh: false, invoiceID: widget.invoiceId);
        if (mounted)
          setState(() {
            subTitle =
                "(${controller.closedOrderData.length.toString()}/${controller.totalClosedOrders.toString()})";
          });
      }
    }
  } //_loadMore

  void _refresh() async {
    if (!controller.isLoading.value) {
      await controller.fetchClosedInvoiceData(
          isRefresh: true, invoiceID: widget.invoiceId);
      if (mounted)
        setState(() {
          loading = false;
          subTitle =
              "(${controller.closedOrderData.length.toString()}/${controller.totalClosedOrders.toString()})";
        });
    }
    refreshController.refreshCompleted();
  } //_refresh

  String subTitle = "";
  @override
  Widget build(BuildContext context) {
    return GetX<ViewOrderController>(builder: (_controller) {
      return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
            title: CustomText(
                text: 'ViewOrders'.tr +
                    ' (${_controller.closedOrderData.length.toString()})',
                color: whiteColor,
                size: 18,
                alignment: Alignment.center),
            centerTitle: true,
          ),
          body: Container(
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Center(
              child: Obx(() {
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
                        child: _controller.closedOrderData.isEmpty &&
                                loading == false
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EmptyState(
                                    label: 'NoData'.tr,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      controller.isLoading(true);
                                      controller.fetchClosedInvoiceData(
                                          invoiceID: widget.invoiceId);
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
                                itemCount: controller.closedOrderData.length,
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10, top: 5),
                                itemBuilder: (context, i) {
                                  return GetBuilder<ShipmentViewModel>(
                                      init: ShipmentViewModel(),
                                      builder: (x) {
                                        return CardBody(
                                          shipment:
                                              controller.closedOrderData[i],
                                          willaya: controller
                                              .closedOrderData[i].wilayaName,
                                          area: controller
                                              .closedOrderData[i].areaName,
                                          date: controller
                                              .closedOrderData[i].updatedAt,
                                          status_key: controller
                                              .closedOrderData[i]
                                              .orderStatusKey,
                                          deleiver_image: controller
                                              .closedOrderData[i].orderImage,
                                          Order_current_Status: controller
                                              .closedOrderData[i]
                                              .orderStatusKey,
                                          undeleiver_image: controller
                                              .closedOrderData[i]
                                              .undeliverImage,
                                          pickup_image: controller
                                              .closedOrderData[i].pickupImage,
                                          customer_name: controller
                                              .closedOrderData[i].customerName,
                                          orderId: controller
                                              .closedOrderData[i].orderId,
                                          number: controller
                                              .closedOrderData[i].customerNo,
                                          cod: controller
                                                  .closedOrderData[i].cod ??
                                              "0.00",
                                          cop: controller
                                                  .closedOrderData[i].cop ??
                                              "0.00",
                                          shipmentCost: controller
                                                  .closedOrderData[i]
                                                  .shippingPrice ??
                                              "0.00",
                                          orderNumber: controller
                                              .closedOrderData[i].orderId,
                                          totalCharges:
                                              '${(double.tryParse(controller.closedOrderData[i].cod.toString()) ?? 0.0) - (double.tryParse(controller.closedOrderData[i].shippingPrice.toString()) ?? 0.0)}',
                                          stutaus: controller.closedOrderData[i]
                                              .orderActivities,
                                          icon: dashboardController
                                              .trackingStatuses
                                              .map((element) =>
                                                  element.icon.toString())
                                              .toList(),
                                          ref: controller
                                              .closedOrderData[i].refId,
                                          weight: controller
                                              .closedOrderData[i].weight,
                                          currentStep: controller
                                              .closedOrderData[i].trackingId,
                                          isOpen: controller
                                              .closedOrderData[i].isOpen,
                                          onPressedShowMore: () {
                                            controller
                                                    .closedOrderData[i].isOpen =
                                                !controller
                                                    .closedOrderData[i].isOpen;
                                            x.update();
                                            print(controller
                                                .closedOrderData[i].isOpen
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
    });
  }
}
