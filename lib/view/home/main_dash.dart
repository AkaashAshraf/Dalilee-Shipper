import 'package:dalile_customer/config/localNotificationService.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/core/view_model/view_order_view_model.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/home/MainDashboardListing/unDeliverListing.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/home/item_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

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

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((val) {
      Get.to(UndeliverListing());
    });
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    NotificationService.showNotification(message.notification!.title.toString(),
        message.notification!.body.toString(), 'Order Update');
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
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

  void _refresh({required type}) async {
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

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  print_r() async {
    await bluetoothPrint.disconnect();

    var devices = await bluetoothPrint.startScan(timeout: Duration(seconds: 6));

    var res = await bluetoothPrint.connect(devices[0]);

    // return;
    Map<String, dynamic> config = Map();
    List<LineText> list = [];
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'A Title',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'this is conent left',
        weight: 0,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'this is conent right',
        align: LineText.ALIGN_RIGHT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_BARCODE,
        content: 'A12312112',
        size: 10,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_QRCODE,
        content: 'qrcode i',
        size: 10,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));

    await bluetoothPrint.printReceipt(config, list);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ShipmentViewModel());
    Get.put(
      () => ViewOrderController(),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () => SmartRefresher(
            header: WaterDropMaterialHeader(
              backgroundColor: primaryColor,
            ),
            onRefresh: () async {
              await widget.controller.fetchMainDashBoardData();
              mainScreenRefreshController.refreshCompleted();
            },
            controller: mainScreenRefreshController,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                onTap: () {
                  // print_r();
                  // return;
                  if (widget.controller.allShipemet.length > 50)
                    widget.controller.allShipemet.value =
                        widget.controller.allShipemet.getRange(0, 50).toList();
                  _refresh(type: Status.ALL);
                  Get.to(
                      () => GetX<DashbordController>(builder: (controller) {
                            return controller.allShipemet.isEmpty
                                ? MainCardBodyView(
                                    controller: controller
                                            .inViewLoadingallShipments.value
                                        ? WaiteImage()
                                        : EmptyState(
                                            label: 'NoData'.tr,
                                          ),
                                    title: "Shipments".tr)
                                : MainCardBodyView(
                                    title: 'AllShipments'.tr +
                                        ' (' +
                                        controller.allShipemet.length
                                            .toString() +
                                        "/" +
                                        controller.dashboardAllShiments.value
                                            .toString() +
                                        ")",
                                    controller: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.81,
                                            child: SmartRefresher(
                                              header: WaterDropHeader(),
                                              controller:
                                                  allShipmentRefreshController,
                                              onRefresh: () async {
                                                _refresh(type: Status.ALL);
                                              },
                                              child: ListView.separated(
                                                controller:
                                                    allShipmentScrollController,
                                                separatorBuilder: (context,
                                                        i) =>
                                                    const SizedBox(height: 15),
                                                itemCount: controller
                                                    .allShipemet.length,
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 10,
                                                    top: 5),
                                                itemBuilder: (context, i) {
                                                  return GetBuilder<
                                                      DashbordController>(
                                                    builder: (x) =>
                                                        dashBoardCard(
                                                            controller,
                                                            controller
                                                                .allShipemet[i]!,
                                                            x),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          if (controller.loadMore.value)
                                            bottomLoadingIndicator(),
                                        ],
                                      ),
                                    ),
                                  );
                          }),
                      transition: Transition.upToDown,
                      duration: const Duration(milliseconds: 400));
                },
                child: buildCard(
                    context,
                    _InsideShape(
                      image: 'assets/images/allshipment.png',
                      title: 'AllShipments'.tr,
                      numbers:
                          '${widget.controller.dashboardAllShiments.value}',
                    ),
                    15.0,
                    15.0,
                    0.0,
                    0.0),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  _buildsmallbox(
                    InkWell(
                      onTap: () {
                        if (widget.controller.deliverShipemet.length > 50)
                          widget.controller.deliverShipemet.value = widget
                              .controller.deliverShipemet
                              .getRange(0, 50)
                              .toList();
                        Get.to(
                            () =>
                                GetX<DashbordController>(builder: (controller) {
                                  return widget
                                          .controller.deliverShipemet.isEmpty
                                      ? MainCardBodyView(
                                          controller: controller
                                                  .inViewLoadingdeliveredShipments
                                                  .value
                                              ? WaiteImage()
                                              : EmptyState(
                                                  label: 'NoData'.tr,
                                                ),
                                          title: 'DeliveredShipments'.tr +
                                              ' (' +
                                              controller.deliverShipemet.length
                                                  .toString() +
                                              "/" +
                                              controller
                                                  .dashboardDeliveredShipments
                                                  .toString() +
                                              ")",
                                        )
                                      : Container(
                                          color: Colors.white,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1,
                                                    child: MainCardBodyView(
                                                      title: 'DeliveredShipments'
                                                              .tr +
                                                          ' (' +
                                                          controller
                                                              .deliverShipemet
                                                              .length
                                                              .toString() +
                                                          "/" +
                                                          controller
                                                              .dashboardDeliveredShipments
                                                              .toString() +
                                                          ")",
                                                      controller:
                                                          SmartRefresher(
                                                        header: WaterDropHeader(
                                                          waterDropColor:
                                                              primaryColor,
                                                        ),
                                                        controller:
                                                            deliveredShipmentRefreshController,
                                                        onRefresh: () async {
                                                          _refresh(
                                                              type: Status
                                                                  .DELIVERED);
                                                        },
                                                        child:
                                                            ListView.separated(
                                                          controller:
                                                              deliveredShipmentScrollController,
                                                          separatorBuilder:
                                                              (context, i) =>
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                          itemCount: controller
                                                              .deliverShipemet
                                                              .length,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  bottom: 10,
                                                                  top: 5),
                                                          itemBuilder:
                                                              (context, i) {
                                                            return GetBuilder<
                                                                DashbordController>(
                                                              builder: (x) =>
                                                                  dashBoardCard(
                                                                      controller,
                                                                      controller
                                                                          .deliverShipemet[i]!,
                                                                      x),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (controller
                                                  .loadMoreDeliveredShipments
                                                  .value)
                                                bottomLoadingIndicator()
                                            ],
                                          ),
                                        );
                                }),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/delivered.png',
                        title: 'DeliverednShipments'.tr,
                        numbers:
                            '${widget.controller.dashboardDeliveredShipments.value}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _buildsmallbox(
                    InkWell(
                      onTap: () {
                        if (widget.controller.undeliverShipemet.length > 50)
                          widget.controller.undeliverShipemet.value = widget
                              .controller.undeliverShipemet
                              .getRange(0, 50)
                              .toList();
                        Get.to(UndeliverListing());
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/tobepickup.png',
                        // title: 'To Be\nPickup',
                        title: 'Un-DeliverednShipments'.tr,

                        // numbers: ' ${widget.controller.dashboard_to_b_Pichup}',
                        numbers:
                            ' ${widget.controller.dashboardUndeliverdShiments}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _buildsmallbox(
                    InkWell(
                      onTap: () {
                        if (widget.controller.ofdShipemet.length > 50)
                          widget.controller.ofdShipemet.value = widget
                              .controller.ofdShipemet
                              .getRange(0, 50)
                              .toList();
                        Get.to(
                            () =>
                                GetX<DashbordController>(builder: (controller) {
                                  return widget.controller.ofdShipemet.isEmpty
                                      ? MainCardBodyView(
                                          controller: controller
                                                  .inViewLoadingOFDShipments
                                                  .value
                                              ? WaiteImage()
                                              : EmptyState(
                                                  label: 'NoData'.tr,
                                                ),
                                          // title: "To Be Delivered")
                                          title: "OFD".tr +
                                              " (" +
                                              controller.ofdShipemet.length
                                                  .toString() +
                                              "/" +
                                              controller.dashboardOFDShiments
                                                  .toString() +
                                              ")")
                                      : Container(
                                          color: Colors.white,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1,
                                                    child: MainCardBodyView(
                                                      title: "OFD".tr +
                                                          " (" +
                                                          controller.ofdShipemet
                                                              .length
                                                              .toString() +
                                                          "/" +
                                                          controller
                                                              .dashboardOFDShiments
                                                              .toString() +
                                                          ")",
                                                      controller:
                                                          SmartRefresher(
                                                        header: WaterDropHeader(
                                                          waterDropColor:
                                                              primaryColor,
                                                        ),
                                                        controller:
                                                            ofdRefreshController,
                                                        onRefresh: () async {
                                                          _refresh(
                                                              type: Status.OFD);
                                                        },
                                                        child:
                                                            ListView.separated(
                                                          controller:
                                                              ofdScrollController,
                                                          separatorBuilder:
                                                              (context, i) =>
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                          itemCount: controller
                                                              .ofdShipemet
                                                              .length,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  bottom: 10,
                                                                  top: 5),
                                                          itemBuilder:
                                                              (context, i) {
                                                            return GetBuilder<
                                                                DashbordController>(
                                                              builder: (x) =>
                                                                  dashBoardCard(
                                                                      controller,
                                                                      controller
                                                                          .ofdShipemet[i]!,
                                                                      x),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (controller
                                                  .loadMoreOFDShipments.value)
                                                bottomLoadingIndicator()
                                            ],
                                          ),
                                        );
                                }),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/tobedelivered.png',
                        title: "OFD".tr,
                        numbers:
                            // '${widget.controller.dashboard_to_b_Delivered.value}',
                            '${widget.controller.dashboardOFDShiments.value}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _buildsmallbox(
                    InkWell(
                      onTap: () {
                        if (widget.controller.cancellShipemet.length > 50)
                          widget.controller.cancellShipemet.value = widget
                              .controller.cancellShipemet
                              .getRange(0, 50)
                              .toList();
                        Get.to(
                            () =>
                                GetX<DashbordController>(builder: (controller) {
                                  return widget
                                          .controller.cancellShipemet.isEmpty
                                      ? MainCardBodyView(
                                          controller: controller
                                                  .inViewLoadingCancelledShipments
                                                  .value
                                              ? WaiteImage()
                                              : EmptyState(
                                                  label: 'NoData'.tr,
                                                ),
                                          title: "CancelShipments".tr +
                                              " (" +
                                              controller.cancellShipemet.length
                                                  .toString() +
                                              "/" +
                                              controller
                                                  .dashboardCancelledShiments
                                                  .value
                                                  .toString() +
                                              ")")
                                      : Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          color: Colors.white,
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1,
                                                    child: MainCardBodyView(
                                                      title: "CancelShipments"
                                                              .tr +
                                                          " (" +
                                                          controller
                                                              .cancellShipemet
                                                              .length
                                                              .toString() +
                                                          "/" +
                                                          controller
                                                              .dashboardCancelledShiments
                                                              .value
                                                              .toString() +
                                                          ")",
                                                      controller:
                                                          SmartRefresher(
                                                        header: WaterDropHeader(
                                                          waterDropColor:
                                                              primaryColor,
                                                        ),
                                                        controller:
                                                            cancelShipmentRefreshController,
                                                        onRefresh: () async {
                                                          _refresh(
                                                              type: Status
                                                                  .CENCELLED_SHIPMENTS);
                                                        },
                                                        child:
                                                            ListView.separated(
                                                          controller:
                                                              cancelScrollController,
                                                          separatorBuilder:
                                                              (context, i) =>
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                          itemCount: controller
                                                              .cancellShipemet
                                                              .length,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  bottom: 10,
                                                                  top: 5),
                                                          itemBuilder:
                                                              (context, i) {
                                                            return GetBuilder<
                                                                DashbordController>(
                                                              builder: (x) =>
                                                                  dashBoardCard(
                                                                      controller,
                                                                      controller
                                                                          .cancellShipemet[i]!,
                                                                      x),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (controller
                                                  .loadMoreCancelShipments
                                                  .value)
                                                bottomLoadingIndicator()
                                            ],
                                          ),
                                        );
                                }),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/cancell.png',
                        title: 'CancelShipments'.tr,
                        numbers:
                            '${widget.controller.dashboardCancelledShiments.value}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              buildCard(
                  context,
                  InkWell(
                    onTap: () {
                      if (widget.controller.returnShipemet.length > 50)
                        widget.controller.returnShipemet.value = widget
                            .controller.returnShipemet
                            .getRange(0, 50)
                            .toList();
                      Get.to(
                          () => GetX<DashbordController>(builder: (controller) {
                                return widget.controller.returnShipemet.isEmpty
                                    ? MainCardBodyView(
                                        controller: controller
                                                .inViewLoadingReturnedShipments
                                                .value
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'NoData'.tr,
                                              ),
                                        title: "ReturnShipments".tr +
                                            " (" +
                                            controller.returnShipemet.length
                                                .toString() +
                                            "/" +
                                            controller
                                                .dashboardReturnedShipment.value
                                                .toString() +
                                            ")")
                                    : Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      1,
                                                  child: MainCardBodyView(
                                                    title: "ReturnShipments"
                                                            .tr +
                                                        " (" +
                                                        controller
                                                            .returnShipemet
                                                            .length
                                                            .toString() +
                                                        "/" +
                                                        controller
                                                            .dashboardReturnedShipment
                                                            .value
                                                            .toString() +
                                                        ")",
                                                    controller: SmartRefresher(
                                                      header: WaterDropHeader(
                                                        waterDropColor:
                                                            primaryColor,
                                                      ),
                                                      controller:
                                                          returnedShipmentRefreshController,
                                                      onRefresh: () async {
                                                        _refresh(
                                                            type: Status
                                                                .RETURNED_SHIPMENTS);
                                                      },
                                                      child: ListView.separated(
                                                        controller:
                                                            returenedScrollController,
                                                        separatorBuilder:
                                                            (context, i) =>
                                                                const SizedBox(
                                                                    height: 15),
                                                        itemCount: controller
                                                            .returnShipemet
                                                            .length,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                bottom: 10,
                                                                top: 5),
                                                        itemBuilder:
                                                            (context, i) {
                                                          return GetBuilder<
                                                              DashbordController>(
                                                            builder: (x) =>
                                                                dashBoardCard(
                                                                    controller,
                                                                    controller
                                                                        .returnShipemet[i]!,
                                                                    x),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (controller
                                                .loadMoreReturnShipments.value)
                                              bottomLoadingIndicator()
                                          ],
                                        ),
                                      );
                              }),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 400));
                    },
                    child: _InsideShape(
                        image: 'assets/images/returnshipment.png',
                        title: 'ReturnednShipments'.tr,
                        numbers:
                            '${widget.controller.dashboardReturnedShipment}'),
                  ),
                  0.0,
                  0.0,
                  15.0,
                  15.0),
            ]),
          ),
        ),
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

Expanded _buildsmallbox(Widget child) {
  return Expanded(
    child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(17),
        child: child),
  );
}

Widget buildCard(BuildContext context, Widget child, a, b, c, d) {
  return Container(
    height: 120,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: primaryColor,
      boxShadow: [BoxShadow()],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(a),
        topRight: Radius.circular(b),
        bottomLeft: Radius.circular(c),
        bottomRight: Radius.circular(d),
      ),
    ),
    padding: const EdgeInsets.all(20),
    child: child,
  );
}

class _InsideSmallBox extends StatelessWidget {
  const _InsideSmallBox(
      {Key? key,
      required this.image,
      required this.title,
      required this.numbers})
      : super(key: key);
  final String image, title, numbers;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          color: whiteColor,
          size: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: numbers,
              color: whiteColor,
              size: 14,
            ),
            Image.asset(
              image,
              height: 25,
              width: 25,
            )
          ],
        )
      ],
    );
  }
}

class _InsideShape extends StatelessWidget {
  const _InsideShape(
      {Key? key,
      required this.image,
      required this.title,
      required this.numbers})
      : super(key: key);
  final String image, title, numbers;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              color: whiteColor,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: numbers,
              color: whiteColor,
              size: 17,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        Image.asset(
          image,
          height: 40,
          width: 40,
        )
      ],
    );
  }
}
