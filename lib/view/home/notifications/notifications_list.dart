import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/notification_controller.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/home/search/search_screen.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _UndeliverListing();
}

class _UndeliverListing extends State<NotificationList> {
  NotificationController controller = Get.put(NotificationController());
  RefreshController refreshController = RefreshController(initialRefresh: true);

  void _refresh() async {
    await controller.fetchNotications();
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // Get.put(NotificationController()).unreadNotification(0);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: "Notifications".tr,
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
          child: GetX<NotificationController>(builder: (controller) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: SmartRefresher(
                            header: WaterDropHeader(
                              waterDropColor: primaryColor,
                            ),
                            controller: refreshController,
                            onRefresh: () async {
                              _refresh();
                            },
                            child: controller.notifications.isEmpty
                                ? controller.loading.value
                                    ? WaiteImage()
                                    : NoDataView(label: "NoData".tr)
                                : ListView.separated(
                                    separatorBuilder: (context, i) =>
                                        const SizedBox(height: 0),
                                    itemCount: controller.notifications.length,
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, bottom: 3, top: 2),
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(SearchScreen(
                                            defaultSearch: controller
                                                .notifications[i].orderId
                                                .toString(),
                                          ));
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "OrderId#".tr,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        controller
                                                            .notifications[i]
                                                            .orderId
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  DottedLine(
                                                    dashColor: Colors.grey
                                                        .withOpacity(0.8),
                                                    dashGapColor: Colors.grey
                                                        .withOpacity(0.8),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    child: Text(
                                                      controller
                                                          .notifications[i]
                                                          .externalText
                                                          .toString(),
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(),
                                                      Text(
                                                        controller
                                                            .notifications[i]
                                                            .createdAt
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
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
}

CardBody card(
  DashbordController controller,
  Shipment shipment,
  DashbordController x,
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
    icon: controller.trackingStatuses
        .map((element) => element.icon.toString())
        .toList(),
    status_key: shipment.orderStatusKey,
    ref: shipment.refId,
    weight: shipment.weight,
    currentStep: shipment.trackingId,
    isOpen: shipment.isOpen,
    onPressedShowMore: () {
      if (shipment.isOpen == false) {
        controller.undeliverShipemet
            .forEach((element) => element?.isOpen = false);
        shipment.isOpen = !shipment.isOpen;
        x.update();
      } else {
        shipment.isOpen = false;
        x.update();
      }
    },
  );
}
