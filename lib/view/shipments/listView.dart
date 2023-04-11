import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/controllers/in_out_controller.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShipmentListView extends StatefulWidget {
  ShipmentListView({Key? key}) : super(key: key);

  @override
  State<ShipmentListView> createState() => _ShipmentListView();
}

class _ShipmentListView extends State<ShipmentListView> {
  int attempts = 1;
  List<ShipmentStatus> statusList = [
    ShipmentStatus(label: "all".tr, value: "ALL", module: "all", attempt: 1),
    ShipmentStatus(
        label: "Delivered".tr,
        value: "completedDA1",
        module: "completed",
        attempt: 1),
    ShipmentStatus(
        label: "Un-Delivered".tr, value: "completed", module: "F", attempt: 1),
    // ShipmentStatus(
    //     label: "ca1".tr, module: "call_attempts", value: "CA1", attempt: 1),
    // ShipmentStatus(
    //     label: "ca2".tr, module: "call_attempts", value: "CA2", attempt: 2),
    ShipmentStatus(label: 'OFD'.tr, value: "OFD", module: "OFD", attempt: 1),
  ];
  DateTime to = new DateTime.now();
  DateTime from = new DateTime(DateTime.now().year, DateTime.now().month - 1,
      DateTime.now().day); // new DateTime.now();
  ShipmentStatus? selectedStatus;
  INOUTController controller = Get.put(INOUTController());
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;

  void _refresh() async {
    await controller.fetchData(
        module: selectedStatus?.module ?? "all",
        type: "all",
        isRefresh: true,
        to: to.toString().split(' ')[0],
        from: from.toString().split(' ')[0],
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
    setState(() {
      selectedStatus = statusList[0];
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

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: to,
        firstDate: from,
        lastDate: DateTime.now());
    if (picked != null && picked != to) {
      setState(() {
        to = picked;
      });
      refreshController.requestRefresh();
    }
  }

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: from,
        firstDate: DateTime(2022, 10),
        lastDate: DateTime.now());
    if (picked != null && picked != from) {
      setState(() {
        from = picked;
        to = DateTime.now();
      });
      refreshController.requestRefresh();
    }
  }

  _loadMore() {
    if (controller.loadMore.value || controller.loading.value) return;
    if (controller.totalOUT > controller.ordersOUT.length &&
        scrollController!.position.extentAfter < 3000 &&
        controller.ordersOUT.length > 0) {
      controller.fetchData(
          module: selectedStatus?.module ?? "all",
          type: selectedStatus?.module ?? "all",
          isRefresh: false,
          offset: controller.ordersOUT.length);
    }
  }
  // _loadMore() async {
  //   // print(controller.undeliverShipemet[0].toJson());

  //   // if (controller.loadMoreUndeliver.value) return;
  //   // if ((controller.dashboardUndeliver.value >
  //   //         controller.undeliverShipemet.length) &&
  //   //     scrollController!.position.extentAfter < 100.0) {
  //   //   // bool isTop = scrollController!.position.pixels == 0;
  //   //   controller.loadMoreUndeliver.value = true;
  //   //   await controller.fetchUnDeliverShipemetData();
  //   //   if (this.mounted)
  //   //     setState(() {
  //   //       subTitle = controller.undeliverShipemet.length.toString() +
  //   //           "/" +
  //   //           controller.dashboardUndeliver.value.toString();
  //   //     });
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetX<INOUTController>(builder: (controller) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(width: width * 0.45, child: Text("status".tr)),
                      Container(
                        width: width * 0.47,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: primaryColor, // Set border color
                              width: 1.0), // Set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0)), // Set rounded corner radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: DropdownButton<ShipmentStatus>(
                            value: selectedStatus,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: TextStyle(color: primaryColor),
                            underline: Container(),
                            onChanged: (ShipmentStatus? value) async {
                              setState(() {
                                selectedStatus = value;
                              });

                              refreshController.requestRefresh();
                            },
                            items: statusList
                                .map<DropdownMenuItem<ShipmentStatus>>(
                                    (ShipmentStatus value) {
                              return DropdownMenuItem<ShipmentStatus>(
                                value: value,
                                child: Text(
                                  value.label,
                                  style: TextStyle(color: primaryColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.22,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Text("From".tr),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => selectFromDate(context),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                          child: Text(
                            "${from.toLocal()}".split(' ')[0],
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.22,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Text("To".tr),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => selectToDate(context),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                          child: Text(
                            "${to.toLocal()}".split(' ')[0],
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                child: controller.ordersOUT.isEmpty
                    ? controller.loading.value
                        ? WaiteImage()
                        : NoDataView(label: "NoData".tr)
                    : ListView.separated(
                        controller: scrollController,
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 15),
                        itemCount: controller.ordersOUT.length,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10, top: 5),
                        itemBuilder: (context, i) {
                          return GetBuilder<INOUTController>(
                            builder: (x) => card(controller.ordersOUT()[i], x),
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

class ShipmentStatus {
  ShipmentStatus(
      {required this.label,
      required this.value,
      this.attempt = 1,
      required this.module});
  final String label;
  final String value;
  final String module;

  final int attempt;
}
