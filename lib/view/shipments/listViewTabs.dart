import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/in_out_controller.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShipmentListView extends StatefulWidget {
  ShipmentListView(
      {Key? key, required this.type, required this.module, this.attempts = 1})
      : super(key: key);
  final String type;
  final String module;
  final int attempts;

  @override
  State<ShipmentListView> createState() => _ShipmentListView();
}

class _ShipmentListView extends State<ShipmentListView> {
  INOUTController controller = Get.put(INOUTController());
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;

  void _refresh() async {
    await controller.fetchData(
        module: widget.module,
        type: widget.type,
        isRefresh: true,
        attempts: widget.attempts,
        limit: controller.defaultLimit,
        offset: 0);
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
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
    // print(controller.undeliverShipemet[0].toJson());

    // if (controller.loadMoreUndeliver.value) return;
    // if ((controller.dashboardUndeliver.value >
    //         controller.undeliverShipemet.length) &&
    //     scrollController!.position.extentAfter < 100.0) {
    //   // bool isTop = scrollController!.position.pixels == 0;
    //   controller.loadMoreUndeliver.value = true;
    //   await controller.fetchUnDeliverShipemetData();
    //   if (this.mounted)
    //     setState(() {
    //       subTitle = controller.undeliverShipemet.length.toString() +
    //           "/" +
    //           controller.dashboardUndeliver.value.toString();
    //     });
    // }
  }

  String subTitle = '';
  List getList() {
    switch (widget.type) {
      case "all":
        return controller.ordersALL;
      case "OFD":
        return controller.ordersOFD;
      case "delivery_attempts1":
        return controller.ordersDA1;
      case "delivery_attempts2":
        return controller.ordersDA2;
      case "call_attempts1":
        return controller.ordersCA1;
      case "call_attempts2":
        return controller.ordersCA2;
      case "return":
        return controller.ordersOUT;
    }
    return [];
  }

  int getTotal() {
    switch (widget.type) {
      case "all":
        return controller.totalAll.value;
      case "OFD":
        return controller.totalOFD.value;
      case "delivery_attempts1":
        return controller.totalDA1.value;
      case "delivery_attempts2":
        return controller.totalDA2.value;
      case "call_attempts1":
        return controller.totalCA1.value;
      case "call_attempts2":
        return controller.totalCA2.value;
      case "return":
        return controller.totalOUT.value;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<INOUTController>(builder: (controller) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              // height: MediaQuery.of(context).size.height * 0.85,
              child: SmartRefresher(
                header: WaterDropHeader(
                  waterDropColor: primaryColor,
                ),
                controller: refreshController,
                onRefresh: () async {
                  _refresh();
                },
                child: getList().isEmpty
                    ? controller.loading.value
                        ? WaiteImage()
                        : NoDataView(label: "NoData".tr)
                    : ListView.separated(
                        controller: scrollController,
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 15),
                        itemCount: getList().length,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10, top: 5),
                        itemBuilder: (context, i) {
                          return GetBuilder<INOUTController>(
                            builder: (x) => card(getList()[i]!, x),
                          );
                        },
                      ),
              ),
            ),
            loadMoreIndicator(),
          ],
        ),
      );
    });
  }

  loadMoreIndicator() {
    if (controller.loadMore.value) {
      return Positioned(
          bottom: 0, left: 0, right: 0, child: const WaiteImage());
    } else
      return Text('');
  } //all

}

CardBody card(
  Shipment shipment,
  INOUTController x,
) {
  return CardBody(
    shipment: shipment,
    willaya: shipment.wilayaName,
    area: shipment.areaName,
    date: shipment.updatedAt,
    orderId: shipment.orderId,
    customer_name: shipment.customerName,
    Order_current_Status: shipment.orderStatusName,
    number: shipment.customerNo,
    orderNumber: shipment.orderId,
    cod: shipment.cod ?? "0.00",
    cop: shipment.cop ?? "0.00",
    deleiver_image: shipment.undeliverImage,
    undeleiver_image: shipment.undeliverImage2,
    pickup_image: shipment.undeliverImage3,
    shipmentCost: shipment.shippingPrice ?? "0.00",
    totalCharges:
        '${(double.tryParse(shipment.cod.toString()) ?? 0.0) - (double.tryParse(shipment.shippingPrice.toString()) ?? 0.0)}',
    stutaus: shipment.orderActivities,
    icon: Get.put(DashbordController())
        .trackingStatuses
        .map((element) => element.icon.toString())
        .toList(),
    status_key: shipment.orderStatusKey,
    ref: shipment.refId,
    weight: shipment.weight,
    currentStep: shipment.trackingId,
    isOpen: shipment.isOpen,
    onPressedShowMore: () {
      if (shipment.isOpen == false) {
        shipment.isOpen = true;
        // controller.undeliverShipemet
        //     .forEach((element) => element?.isOpen = false);
        // shipment.isOpen = !shipment.isOpen;
        x.update();
      } else {
        shipment.isOpen = false;
        x.update();
      }
    },
  );
}
