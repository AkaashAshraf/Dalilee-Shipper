import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/DispatcherController.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrders();
}

class _MyOrders extends State<MyOrders> {
  DispatcherController controller = Get.put(DispatcherController());
  DashbordController dashboardController = Get.put(DashbordController());

  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;

  void _refresh() async {
    await controller.fetchMyOrders(isRefresh: true);
    refreshController.refreshCompleted();
    if (this.mounted)
      setState(() {
        subTitle = controller.myOders.length.toString() +
            "/" +
            controller.totalOrder.value.toString();
      });
  }

  @override
  void initState() {
    // controller.fetchMyOrders();
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
    if (this.mounted)
      setState(() {
        subTitle = controller.myOders.length.toString() +
            "/" +
            controller.totalOrder.value.toString();
      });

    super.initState();
  }

  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore();
    });

    super.dispose();
  }

  _loadMore() async {
    // print(controller.totalOrder.value > controller.myOders.length);

    if (controller.loadingMyOrders.value) return;
    if ((controller.totalOrder.value > controller.myOders.length) &&
        scrollController!.position.extentAfter < 100.0) {
      // bool isTop = scrollController!.position.pixels == 0;
      controller.loadingMyOrders.value = true;
      await controller.fetchMyOrders();
      if (this.mounted)
        setState(() {
          subTitle = controller.myOders.length.toString() +
              "/" +
              controller.totalOrder.value.toString();
        });
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: "My Oders".tr + " ($subTitle)",
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }

  String subTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        body: Container(
          padding: EdgeInsets.only(top: 0),
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: GetX<DispatcherController>(builder: (controller) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: controller.myOders.isEmpty
                  ? controller.loadingMyOrders.value
                      ? WaiteImage()
                      : NoDataView(label: "NoData".tr)
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                child: SmartRefresher(
                                  header: WaterDropHeader(
                                    waterDropColor: primaryColor,
                                  ),
                                  controller: refreshController,
                                  onRefresh: () async {
                                    _refresh();
                                  },
                                  child: ListView.separated(
                                    // shrinkWrap: false,
                                    controller: scrollController,
                                    separatorBuilder: (context, i) =>
                                        const SizedBox(height: 15),
                                    itemCount: controller.myOders.length,

                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 10,
                                        top: 5),
                                    itemBuilder: (context, i) {
                                      return GetBuilder<DispatcherController>(
                                        builder: (x) => card(
                                            controller,
                                            controller.myOders[i],
                                            x,
                                            dashboardController,
                                            context,
                                            refreshController:
                                                refreshController),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              loadMoreIndicator(),
                            ],
                          ),
                        ),
                        // loadMoreIndicator(),
                      ],
                    ),
            );
          }),
        ));
  }

  loadMoreIndicator() {
    if (controller.loadingMyOrders.value) {
      return Positioned(
          bottom: 0, left: 0, right: 0, child: const WaiteImage());
    } else
      return Text("");
  } //all

}

CardBody card(
    DispatcherController controller,
    Shipment shipment,
    DispatcherController x,
    DashbordController dashbordController,
    BuildContext context,
    {required RefreshController refreshController}) {
  return CardBody(
    isMyOrder: true,
    onPaymentSuccess: () async {
      Get.snackbar('Successfull', "Payment has been transfered successfully");
      refreshController.requestRefresh();
      // controller.fetchMyOrders(isRefresh: true);

      Navigator.pop(context);
    },
    shipment: shipment,
    willaya: shipment.wilayaName,
    area: shipment.areaName,
    date: shipment.updatedAt,
    orderId: shipment.orderId ?? 00,
    customer_name: shipment.customerName,
    Order_current_Status: shipment.orderStatusName,
    number: shipment.phone ?? "+968",
    orderNumber: shipment.orderNo,
    cod: shipment.cod ?? "0.00",
    cop: shipment.cop ?? "0.00",
    deleiver_image: shipment.orderDeliverImage ?? "",
    undeleiver_image: shipment.orderUndeliverImage ?? "",
    pickup_image: shipment.orderPickupImage ?? "",
    shipmentCost: shipment.shippingPrice ?? "0.00",
    totalCharges:
        '${(double.tryParse(shipment.cod.toString()) ?? 0.0) - (double.tryParse(shipment.shippingPrice.toString()) ?? 0.0)}',
    stutaus: shipment.orderActivities,
    icon: dashbordController.trackingStatuses
        .map((element) => element.icon.toString())
        .toList(),
    status_key: shipment.orderStatusKey,
    ref: shipment.refId ?? 0,
    weight: shipment.weight ?? 0.00,
    currentStep: shipment.currentStatus ?? 1,
    isOpen: shipment.isOpen,
    onPressedShowMore: () {
      if (shipment.isOpen == false) {
        controller.myOders.forEach((element) => element.isOpen = false);
        shipment.isOpen = !shipment.isOpen;
        x.update();
      } else {
        shipment.isOpen = false;
        x.update();
      }
    },
  );
}
