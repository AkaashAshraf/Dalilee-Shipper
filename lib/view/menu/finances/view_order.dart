import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/core/view_model/view_order_view_model.dart';
import 'package:dalile_customer/view/home/card_body.dart';
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

  final ViewOrderController controller =
      Get.put(ViewOrderController(), permanent: true);
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
    if (controller.total_orders.value > controller.limit.value &&
        scrollController!.position.extentAfter < 10) {
      if (!controller.loadMore.value) {
        controller.limit.value += 10;
        controller.fetchViewOrderData(isRefresh: false);
      }
    }
  } //_loadMore

  void _refresh() async {
    if (!controller.isLoading.value) {
      var res = await controller.fetchViewOrderData(isRefresh: true);
    }
    refreshController.refreshCompleted();
  } //_refresh

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
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
                    const EmptyState(
                      label: 'no Data ',
                    ),
                    MaterialButton(
                      onPressed: () {
                        controller.fetchViewOrderData();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CustomText(
                            text: 'Updated data ',
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: controller.loadMore.value
                            ? MediaQuery.of(context).size.height * 0.75
                            : MediaQuery.of(context).size.height * 0.8,
                        child: Expanded(
                          flex: 14,
                          child: SmartRefresher(
                            header: WaterDropMaterialHeader(
                              backgroundColor: primaryColor,
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
                                        status_key: controller
                                            .viewOrderData[i].orderStatusKey,
                                        deleiver_image: controller
                                            .viewOrderData[i].orderDeliverImage,
                                        Order_current_Status: controller
                                            .viewOrderData[i].orderStatusKey,
                                        undeleiver_image: controller
                                            .viewOrderData[i]
                                            .orderUndeliverImage,
                                        pickup_image: controller
                                            .viewOrderData[i].orderPickupImage,
                                        customer_name: controller
                                            .viewOrderData[i].customerName,
                                        orderId: controller
                                                .viewOrderData[i].orderId ??
                                            "00",
                                        number:
                                            controller.viewOrderData[i].phone ??
                                                "+968",
                                        cod: controller.viewOrderData[i].cod ??
                                            "0.00",
                                        cop: controller.viewOrderData[i].cop ??
                                            "0.00",
                                        shipmentCost: controller
                                                .viewOrderData[i]
                                                .shippingPrice ??
                                            "0.00",
                                        orderNumber:
                                            controller.viewOrderData[i].orderNo,
                                        totalCharges:
                                            '${double.parse(controller.viewOrderData[i].shippingPrice.toString()) + double.parse(controller.viewOrderData[i].cod.toString())}',
                                        stutaus: controller
                                            .viewOrderData[i].orderActivities,
                                        icon: controller.viewOrderList
                                            .map((element) =>
                                                element.icon.toString())
                                            .toList(),
                                        ref:
                                            controller.viewOrderData[i].refId ??
                                                "0",
                                        weight: controller
                                                .viewOrderData[i].weight ??
                                            "0.00",
                                        currentStep: controller.viewOrderData[i]
                                                .currentStatus ??
                                            1,
                                        isOpen:
                                            controller.viewOrderData[i].isOpen,
                                        onPressedShowMore: () {
                                          controller.viewOrderData[i].isOpen =
                                              !controller
                                                  .viewOrderData[i].isOpen;
                                          x.update();
                                          print(controller
                                              .viewOrderData[i].isOpen
                                              .toString());
                                        },
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                      if (controller.loadMore.value) WaiteImage()
                    ],
                  ),
                ],
              );
            }),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: const CustomText(
          text: 'View Orders',
          color: whiteColor,
          size: 18,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
