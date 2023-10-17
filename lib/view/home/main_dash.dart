import 'dart:developer';

import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/controllers/shipment_controller.dart';
import 'package:dalile_customer/controllers/view_order_controller.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/home/MainDashboardListing/unDeliverListing.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/home/item_body.dart';
import 'package:dalile_customer/view/tam-oman-special/items/main-dashboard-large-item-2.dart';
import 'package:dalile_customer/view/tam-oman-special/items/main-dashboard-small-item.dart';
import 'package:dalile_customer/view/tam-oman-special/items/main-dashboard-large-item-1.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainDash extends StatefulWidget {
  MainDash({Key? key, required this.controller}) : super(key: key);
  final DashbordController controller;

  @override
  State<MainDash> createState() => _MainDashState();
}

enum Status { ALL, DELIVERED, RETURNED_SHIPMENTS, CENCELLED_SHIPMENTS, OFD }

class _MainDashState extends State<MainDash> {
  ScrollController? allShipmentScrollController;
  ScrollController? deliveredShipmentScrollController;
  ScrollController? returenedScrollController;
  ScrollController? cancelScrollController;
  ScrollController? ofdScrollController;

  RefreshController mainScreenRefreshController =
      RefreshController(initialRefresh: true);
  RefreshController ofdRefreshController =
      RefreshController(initialRefresh: true);

  RefreshController allShipmentRefreshController =
      RefreshController(initialRefresh: true);
  RefreshController deliveredShipmentRefreshController =
      RefreshController(initialRefresh: true);
  RefreshController toBeDeliveredShipmentRefreshController =
      RefreshController(initialRefresh: true);
  RefreshController toBePickupShipmentRefreshController =
      RefreshController(initialRefresh: true);
  RefreshController returnedShipmentRefreshController =
      RefreshController(initialRefresh: true);

  RefreshController cancelShipmentRefreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    allShipmentScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.ALL);
      });

    deliveredShipmentScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.DELIVERED);
      });

    returenedScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.RETURNED_SHIPMENTS);
      });
    cancelScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.CENCELLED_SHIPMENTS);
      });

    ofdScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.OFD);
      });
  }

  _loadMore({required type}) {
    switch (type) {
      case Status.ALL:
        {
          if (widget.controller.loadMore.value) return;

          if (widget.controller.dashboardAllShiments >
                  widget.controller.allShipemet.length &&
              allShipmentScrollController!.position.extentAfter < 3000.0) {
            widget.controller.loadMore.value = true;

            widget.controller.fetchAllShipmentData(isRefresh: false);
            // }
          }
          break;
        } //ALL
      case Status.DELIVERED:
        {
          if (widget.controller.loadMoreDeliveredShipments.value) return;
          if (widget.controller.dashboardDeliveredShipments >
                  widget.controller.deliverShipemet.length &&
              deliveredShipmentScrollController!.position.extentAfter < 3000) {
            widget.controller.fetchDeliverShipemetData();
            // }
          }
          break;
        } //DELIVERED

      case Status.RETURNED_SHIPMENTS:
        {
          if (widget.controller.loadMoreReturnShipments.value) return;
          if (widget.controller.dashboardReturnedShipment >
                  widget.controller.returnShipemet.length &&
              returenedScrollController!.position.extentAfter < 3000) {
            widget.controller.fetchRetrunShipemetData();
            // }
          }
          break;
        } //RETURNED_SHIPMENTS

      case Status.CENCELLED_SHIPMENTS:
        {
          if (widget.controller.loadMoreCancelShipments.value) return;
          if (widget.controller.dashboardCancelledShiments >
                  widget.controller.cancellShipemet.length &&
              cancelScrollController!.position.extentAfter < 3000) {
            widget.controller.fetchcancellShipemetData();
            // }
          }
          break;
        } //CENCELLED_SHIPMENTS

      case Status.OFD:
        {
          if (widget.controller.loadMoreOFDShipments.value) return;
          if (widget.controller.dashboardOFDShiments >
                  widget.controller.ofdShipemet.length &&
              cancelScrollController!.position.extentAfter < 3000) {
            widget.controller.fetchOFDShipemetData();
            // }
          }
          break;
        } //ofd

    } //switch
  }

  @override
  void dispose() {
    allShipmentScrollController!.removeListener(() {
      _loadMore(type: Status.ALL);
    });
    deliveredShipmentScrollController!.removeListener(() {
      _loadMore(type: Status.DELIVERED);
    });

    returenedScrollController!.removeListener(() {
      _loadMore(type: Status.RETURNED_SHIPMENTS);
    });
    cancelScrollController!.removeListener(() {
      _loadMore(type: Status.CENCELLED_SHIPMENTS);
    });
    cancelScrollController!.removeListener(() {
      _loadMore(type: Status.OFD);
    });

    super.dispose();
  }

  _refresh({required type}) async {
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    inspect({"fcm": token, "test": ""});
    print(token);
    switch (type) {
      case Status.ALL:
        {
          await widget.controller.fetchAllShipmentData(isRefresh: true);
          allShipmentRefreshController.refreshCompleted();
          break;
        } //all

      case Status.DELIVERED:
        {
          await widget.controller.fetchDeliverShipemetData(isRefresh: true);
          deliveredShipmentRefreshController.refreshCompleted();
          break;
        } //delived

      case Status.RETURNED_SHIPMENTS:
        {
          await widget.controller.fetchRetrunShipemetData(isRefresh: true);
          returnedShipmentRefreshController.refreshCompleted();
          break;
        } //RETURNED_SHIPMENTS
      case Status.CENCELLED_SHIPMENTS:
        {
          await widget.controller.fetchcancellShipemetData(isRefresh: true);
          cancelShipmentRefreshController.refreshCompleted();
          break;
        } //CENCELLED_SHIPMENTS
      case Status.OFD:
        {
          await widget.controller.fetchOFDShipemetData(isRefresh: true);
          ofdRefreshController.refreshCompleted();
          break;
        } //OFD
    } //switch
  }

  checkAppExpiry(BuildContext context) {
    if (mounted) Get.put(DashbordController()).checkAppExpiry(context);
  }

  final shipmentViewModel = Get.put(ShipmentViewModel());
  final viewOrderController = Get.put(
    () => ViewOrderController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GetX<DashbordController>(builder: (controller) {
          return SmartRefresher(
            header: WaterDropMaterialHeader(
              backgroundColor: primaryColor,
            ),
            onRefresh: () async {
              await widget.controller.fetchMainDashBoardData();
              mainScreenRefreshController.refreshCompleted();
              checkAppExpiry(context);
            },
            controller: mainScreenRefreshController,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: getDashbordItemSize(context)
                        .mainDashboardLargeItemHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainDashboardSmallItem(
                            image: "assets/images/dashbord_icon1.png",
                            title: "AllShipments".tr,
                            onClick: () => {
                                  Get.to(detailsPage(context,
                                      title: "AllShipments".tr,
                                      shipments: controller.allShipemet,
                                      onRefresh: _refresh(type: Status.ALL),
                                      loading:
                                          controller.inViewLoadingallShipments,
                                      total: controller.dashboardAllShiments,
                                      loadMore: controller.loadMore,
                                      refreshController:
                                          allShipmentRefreshController,
                                      scrollView: allShipmentScrollController))
                                },
                            value:
                                "${widget.controller.dashboardAllShiments.value}",
                            color: dashboardItemColor3),
                        MainDashboardSmallItem(
                          image: "assets/images/dashbord_icon2.png",
                          title: "Un-DeliverednShipments".tr,
                          value:
                              "${widget.controller.dashboardUndeliverdShiments.value}",
                          color: dashboardItemColor4,
                          onClick: () {
                            if (widget.controller.undeliverShipemet.length > 50)
                              widget.controller.undeliverShipemet.value = widget
                                  .controller.undeliverShipemet
                                  .getRange(0, 50)
                                  .toList();
                            Get.to(UndeliverListing());
                          },
                        ),
                      ],
                    ),
                  ),
                  MainDashboardLargeItem1(
                    image: "assets/images/dashbord_icon3.png",
                    title: "DeliveredShipments".tr,
                    value:
                        "${widget.controller.dashboardDeliveredShipments.value}",
                    color: dashboardItemColor2,
                    onClick: () => {
                      Get.to(detailsPage(context,
                          title: "DeliveredShipments".tr,
                          shipments: controller.deliverShipemet,
                          onRefresh: _refresh(type: Status.DELIVERED),
                          loading: controller.inViewLoadingdeliveredShipments,
                          total: controller.dashboardDeliveredShipments,
                          loadMore: controller.loadMoreDeliveredShipments,
                          refreshController: deliveredShipmentRefreshController,
                          scrollView: deliveredShipmentScrollController))
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainDashboardLargeItem2(
                    image: "assets/images/dashbord_icon4.png",
                    title: "CancelShipments".tr,
                    value:
                        "${widget.controller.dashboardCancelledShiments.value}",
                    color: dashboardItemColor1,
                    onClick: () => {
                      Get.to(detailsPage(context,
                          title: "CancelShipments".tr,
                          shipments: controller.cancellShipemet,
                          onRefresh: _refresh(type: Status.CENCELLED_SHIPMENTS),
                          loading: controller.inViewLoadingReturnedShipments,
                          total: controller.dashboardCancelledShiments,
                          loadMore: controller.loadMoreCancelShipments,
                          refreshController: cancelShipmentRefreshController,
                          scrollView: cancelScrollController))
                    },
                  ),
                  Container(
                    height: getDashbordItemSize(context)
                        .mainDashboardLargeItemHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainDashboardSmallItem(
                          image: "assets/images/dashbord_icon5.png",
                          title: "OFD".tr,
                          value:
                              "${widget.controller.dashboardOFDShiments.value}",
                          color: dashboardItemColor2,
                          onClick: () => {
                            Get.to(detailsPage(context,
                                title: "OFD".tr,
                                shipments: controller.ofdShipemet,
                                onRefresh: _refresh(type: Status.OFD),
                                loading: controller.inViewLoadingOFDShipments,
                                total: controller.dashboardOFDShiments,
                                loadMore: controller.loadMoreOFDShipments,
                                refreshController: ofdRefreshController,
                                scrollView: ofdScrollController))
                          },
                        ),
                        MainDashboardSmallItem(
                          image: "assets/images/dashbord_icon6.png",
                          title: "ReturnednShipments".tr,
                          value:
                              "${widget.controller.dashboardReturnedShipment.value}",
                          color: dashboardItemColor3,
                          onClick: () => {
                            Get.to(detailsPage(context,
                                title: "ReturnednShipments".tr,
                                shipments: controller.returnShipemet,
                                onRefresh:
                                    _refresh(type: Status.RETURNED_SHIPMENTS),
                                loading:
                                    controller.inViewLoadingReturnedShipments,
                                total: controller.dashboardReturnedShipment,
                                loadMore: controller.loadMoreReturnShipments,
                                refreshController:
                                    returnedShipmentRefreshController,
                                scrollView: returenedScrollController))
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          );
        }),
      ),
    );
  }

  detailsPage(BuildContext context,
      {required RxList<Shipment?> shipments,
      required dynamic onRefresh,
      required RxBool loading,
      required String title,
      required RxInt total,
      required RxBool loadMore,
      required RefreshController refreshController,
      required ScrollController? scrollView}) {
    return shipments.isEmpty
        ? MainCardBodyView(
            controller: loading.value
                ? WaiteImage()
                : EmptyState(
                    label: 'NoData'.tr,
                  ),
            title: title +
                " (" +
                shipments.length.toString() +
                "/" +
                total.value.toString() +
                ")")
        : Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1,
                      child: MainCardBodyView(
                        title: title +
                            " (" +
                            shipments.length.toString() +
                            "/" +
                            total.value.toString() +
                            ")",
                        controller: SmartRefresher(
                          header: WaterDropHeader(
                            waterDropColor: primaryColor,
                          ),
                          controller: refreshController,
                          onRefresh: () async {
                            onRefresh();
                          },
                          child: ListView.separated(
                            controller: scrollView,
                            separatorBuilder: (context, i) =>
                                const SizedBox(height: 15),
                            itemCount: shipments.length,
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 10, top: 5),
                            itemBuilder: (context, i) {
                              return GetBuilder<DashbordController>(
                                builder: (x) => dashBoardCard(
                                    widget.controller, shipments[i]!, x),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (loadMore.value) bottomLoadingIndicator()
              ],
            ),
          );
  }

  CardBody dashBoardCard(
      DashbordController controller, Shipment shipment, DashbordController x) {
    return CardBody(
      shipment: shipment,
      willaya: shipment.wilayaName,
      area: shipment.areaName,
      date: shipment.updatedAt,
      deleiver_image: shipment.undeliverImage,
      undeleiver_image: shipment.undeliverImage2,
      pickup_image: shipment.undeliverImage3,
      orderId: shipment.orderId,
      status_key: shipment.orderStatusKey,
      customer_name: shipment.customerName,
      Order_current_Status: shipment.orderStatusName,
      number: shipment.customerNo,
      orderNumber: shipment.orderId,
      cod: shipment.cod ?? "0.00",
      cop: shipment.cop ?? "0.00",
      shipmentCost: shipment.shippingPrice ?? "0.00",
      totalCharges:
          '${(double.tryParse(shipment.cod.toString()) ?? 0.0) - (double.tryParse(shipment.shippingPrice.toString()) ?? 0.0)}',
      stutaus: shipment.orderActivities,
      icon: controller.trackingStatuses
          .map((element) => element.icon.toString())
          .toList(),
      ref: shipment.refId,
      weight: shipment.weight,
      currentStep: shipment.trackingId,
      isOpen: shipment.isOpen,
      onPressedShowMore: () {
        if (shipment.isOpen == false) {
          controller.allShipemet.forEach((element) => element?.isOpen = false);
          shipment.isOpen = !shipment.isOpen;
          x.update();
        } else {
          shipment.isOpen = false;
          x.update();
        }
      },
    );
  }
}
