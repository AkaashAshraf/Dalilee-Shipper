import 'package:dalile_customer/config/localNotificationService.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbord_model_view.dart';
import 'package:dalile_customer/view/home/MainDashboardListing/unDeliverListing.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/home/item_body.dart';
import 'package:dalile_customer/view/widget/all_pickup_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
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

enum Status {
  ALL,
  DELIVERED,
  TO_BE_DELIVERED,
  TO_BE_PICKUP,
  RETURNED_SHIPMENTS,
  CENCELLED_SHIPMENTS,
  OFD
}

class _MainDashState extends State<MainDash> {
  ScrollController? allShipmentScrollController;
  ScrollController? deliveredShipmentScrollController;
  ScrollController? toBePickupScrollController;
  ScrollController? toBeDelieveredScrollController;
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
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener

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

    toBeDelieveredScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.TO_BE_DELIVERED);
      });

    toBePickupScrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.TO_BE_PICKUP);
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
            widget.controller.limitAllShiments.value += 10;
            widget.controller.loadMore.value = true;

            widget.controller.fetchAllShipemetData();
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
            widget.controller.limitDeliveredShipments.value += 10;
            widget.controller.fetchDeliverShipemetData();
            // }
          }
          break;
        } //DELIVERED

      case Status.TO_BE_DELIVERED:
        {
          if (widget.controller.loadMoreToBeDeliveredShipments.value) return;
          if (widget.controller.dashboardToBeDelivered >
                  widget.controller.tobeDelShipemet.length &&
              toBeDelieveredScrollController!.position.extentAfter < 3000.0) {
            widget.controller.limitToBeDelivered.value += 10;
            widget.controller.fetchToBeDeliveredShipemetData();
            // }
          }
          break;
        } //TO_BE_DELIVERED

      case Status.TO_BE_PICKUP:
        {
          if (widget.controller.loadMoreToBePickup.value) return;
          if (widget.controller.dashboardToBePichup >
                  widget.controller.tobePickup.length &&
              toBePickupScrollController!.position.extentAfter < 3000) {
            widget.controller.limitToBePichup.value += 10;
            widget.controller.fetchToBePickupData();
            // }
          }
          break;
        } //TO_BE_PICKUP
      case Status.RETURNED_SHIPMENTS:
        {
          if (widget.controller.loadMoreReturnShipments.value) return;
          if (widget.controller.dashboardReturnedShipment >
                  widget.controller.returnShipemet.length &&
              returenedScrollController!.position.extentAfter < 3000) {
            widget.controller.limitReturnedShipment.value += 10;
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
            widget.controller.limitCancelledShiments.value += 10;
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
            widget.controller.limitOfdShiments.value += 10;
            widget.controller.fetchOFDShipemetData();
            // }
          }
          break;
        } //ofd

    } //switch
  }

  void _refresh({required type}) async {
    switch (type) {
      case Status.ALL:
        {
          await widget.controller.fetchAllShipemetData(isRefresh: true);
          allShipmentRefreshController.refreshCompleted();
          break;
        } //delived
      case Status.DELIVERED:
        {
          await widget.controller.fetchDeliverShipemetData(isRefresh: true);
          deliveredShipmentRefreshController.refreshCompleted();
          break;
        } //delived
      case Status.TO_BE_PICKUP:
        {
          await widget.controller.fetchToBePickupData(isRefresh: true);
          toBePickupShipmentRefreshController.refreshCompleted();
          break;
        } //to be pickup
      case Status.TO_BE_DELIVERED:
        {
          await widget.controller
              .fetchToBeDeliveredShipemetData(isRefresh: true);
          toBeDeliveredShipmentRefreshController.refreshCompleted();
          break;
        } //tp\o be delived
      case Status.RETURNED_SHIPMENTS:
        {
          await widget.controller.fetchRetrunShipemetData(isRefresh: true);
          returnedShipmentRefreshController.refreshCompleted();
          break;
        } //to be delived
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

  @override
  void dispose() {
    allShipmentScrollController!.removeListener(() {
      _loadMore(type: Status.ALL);
    });
    deliveredShipmentScrollController!.removeListener(() {
      _loadMore(type: Status.DELIVERED);
    });
    toBeDelieveredScrollController!.removeListener(() {
      _loadMore(type: Status.TO_BE_DELIVERED);
    });
    toBePickupScrollController!.removeListener(() {
      _loadMore(type: Status.TO_BE_PICKUP);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Obx(
        () => SmartRefresher(
          header: WaterDropMaterialHeader(
            backgroundColor: primaryColor,
          ),
          onRefresh: () async {
            var res = await widget.controller.fetchMainDashBoardData();
            mainScreenRefreshController.refreshCompleted();
          },
          controller: mainScreenRefreshController,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // const DownloadingDialog(
            //   url:
            //       "https://shaheen-oman.dalilee.om/storage/uploads/store/shipments/2022/Aug/shipments1661714131.csv",
            //   format: "csv",
            // ),
            // Text(txt),
            // widget.controller.isLoading.value
            //     ? WaiteImage()
            //     : MaterialButton(
            //         onPressed: () {
            //           widget.controller.fetchMainDashBoardData();
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           mainAxisSize: MainAxisSize.min,
            //           children: const [
            //             CustomText(
            //               text: 'Updated data',
            //               color: Colors.grey,
            //               alignment: Alignment.center,
            //               size: 12,
            //             ),
            //             Icon(
            //               Icons.refresh,
            //               color: Colors.grey,
            //             ),
            //           ],
            //         ),
            //       ),
            // SizedBox(
            //   height: 5,
            // ),
            InkWell(
              onTap: () {
                // flutterLocalNotificationsPlugin.show(
                //     4253,
                //     'title',
                //     " body",
                //     NotificationDetails(
                //         android: AndroidNotificationDetails(
                //             '1213', "chanel.name",
                //             playSound: true)));

                _refresh(type: Status.ALL);
                Get.to(
                    () => GetX<DashbordController>(builder: (controller) {
                          return controller.allShipemet.isEmpty
                              ? MainCardBodyView(
                                  controller:
                                      controller.inViewLoadingallShipments.value
                                          ? WaiteImage()
                                          : EmptyState(
                                              label: 'No data',
                                            ),
                                  title: "Shipments")
                              : MainCardBodyView(
                                  title: 'All Shipments (' +
                                      controller.allShipemet.length.toString() +
                                      "/" +
                                      controller.dashboardAllShiments.value
                                          .toString() +
                                      ")",
                                  controller: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.81,
                                              child: SmartRefresher(
                                                header: WaterDropHeader(
                                                    // backgroundColor: primaryColor,
                                                    ),
                                                controller:
                                                    allShipmentRefreshController,
                                                onRefresh: () async {
                                                  _refresh(type: Status.ALL);
                                                },
                                                child: ListView.separated(
                                                  controller:
                                                      allShipmentScrollController,
                                                  separatorBuilder:
                                                      (context, i) =>
                                                          const SizedBox(
                                                              height: 15),
                                                  itemCount: controller
                                                      .allShipemet.length,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          bottom: 10,
                                                          top: 5),
                                                  itemBuilder: (context, i) {
                                                    return GetBuilder<
                                                        DashbordController>(
                                                      builder: (x) => CardBody(
                                                        deleiver_image: controller
                                                                .allShipemet[i]
                                                                .orderDeliverImage ??
                                                            "",
                                                        undeleiver_image: controller
                                                                .allShipemet[i]
                                                                .orderUndeliverImage ??
                                                            "",
                                                        pickup_image: controller
                                                                .allShipemet[i]
                                                                .orderPickupImage ??
                                                            "",
                                                        orderId: controller
                                                                .allShipemet[i]
                                                                .orderId ??
                                                            00,
                                                        status_key: widget
                                                            .controller
                                                            .allShipemet[i]
                                                            .orderStatusKey,
                                                        customer_name:
                                                            controller
                                                                .allShipemet[i]
                                                                .customerName,
                                                        Order_current_Status:
                                                            controller
                                                                .allShipemet[i]
                                                                .orderStatusName,
                                                        number: controller
                                                                .allShipemet[i]
                                                                .phone ??
                                                            "+968",
                                                        orderNumber: controller
                                                            .allShipemet[i]
                                                            .orderNo,
                                                        cod: controller
                                                                .allShipemet[i]
                                                                .cod ??
                                                            "0.00",
                                                        cop: controller
                                                                .allShipemet[i]
                                                                .cop ??
                                                            "0.00",
                                                        shipmentCost: controller
                                                                .allShipemet[i]
                                                                .shippingPrice ??
                                                            "0.00",
                                                        totalCharges:
                                                            '${double.parse(controller.allShipemet[i].shippingPrice.toString()) + double.parse(controller.allShipemet[i].cod.toString())}',
                                                        stutaus: controller
                                                            .allShipemet[i]
                                                            .orderActivities,
                                                        icon: controller.allList
                                                            .map((element) =>
                                                                element.icon
                                                                    .toString())
                                                            .toList(),
                                                        ref: controller
                                                                .allShipemet[i]
                                                                .refId ??
                                                            0,
                                                        weight: controller
                                                                .allShipemet[i]
                                                                .weight ??
                                                            0.00,
                                                        currentStep: controller
                                                                .allShipemet[i]
                                                                .currentStatus ??
                                                            1,
                                                        isOpen: controller
                                                            .allShipemet[i]
                                                            .isOpen,
                                                        onPressedShowMore: () {
                                                          if (controller
                                                                  .allShipemet[
                                                                      i]
                                                                  .isOpen ==
                                                              false) {
                                                            controller
                                                                .allShipemet
                                                                .forEach((element) =>
                                                                    element.isOpen =
                                                                        false);
                                                            controller
                                                                    .allShipemet[i]
                                                                    .isOpen =
                                                                !controller
                                                                    .allShipemet[
                                                                        i]
                                                                    .isOpen;
                                                            x.update();
                                                          } else {
                                                            controller
                                                                .allShipemet[i]
                                                                .isOpen = false;
                                                            x.update();
                                                          }
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (controller.loadMore.value)
                                          bottomLoadingIndicator()
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
                    title: 'All Shipments',
                    numbers: '${widget.controller.dashboardAllShiments.value}',
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
                      Get.to(
                          () => GetX<DashbordController>(builder: (controller) {
                                return widget.controller.deliverShipemet.isEmpty
                                    ? MainCardBodyView(
                                        controller: controller
                                                .inViewLoadingdeliveredShipments
                                                .value
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        title: 'Delivered Shipments (' +
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
                                                    title: 'Delivered Shipments (' +
                                                        controller
                                                            .deliverShipemet
                                                            .length
                                                            .toString() +
                                                        "/" +
                                                        controller
                                                            .dashboardDeliveredShipments
                                                            .toString() +
                                                        ")",
                                                    controller: SmartRefresher(
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
                                                      child: ListView.separated(
                                                        controller:
                                                            deliveredShipmentScrollController,
                                                        separatorBuilder:
                                                            (context, i) =>
                                                                const SizedBox(
                                                                    height: 15),
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
                                                                CardBody(
                                                              deleiver_image: controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .orderDeliverImage ??
                                                                  "",
                                                              customer_name: controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .customerName ??
                                                                  "",
                                                              undeleiver_image:
                                                                  controller
                                                                          .deliverShipemet[
                                                                              i]
                                                                          .orderUndeliverImage ??
                                                                      "",
                                                              pickup_image: controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .orderPickupImage ??
                                                                  "",
                                                              Order_current_Status:
                                                                  controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .orderStatusName,
                                                              orderId: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .orderId ??
                                                                  00,
                                                              orderNumber:
                                                                  controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .orderNo,
                                                              number: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .phone ??
                                                                  "+968",
                                                              cod: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .cod ??
                                                                  "0.00",
                                                              cop: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .cop ??
                                                                  "0.00",
                                                              shipmentCost: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .shippingPrice ??
                                                                  "0.00",
                                                              status_key: controller
                                                                  .deliverShipemet[
                                                                      i]
                                                                  .orderStatusKey,
                                                              totalCharges:
                                                                  '${double.parse(widget.controller.deliverShipemet[i].shippingPrice.toString()) + double.parse(widget.controller.deliverShipemet[i].cod.toString())}',
                                                              stutaus: widget
                                                                  .controller
                                                                  .deliverShipemet[
                                                                      i]
                                                                  .orderActivities,
                                                              icon: widget
                                                                  .controller
                                                                  .deliverList
                                                                  .map((element) =>
                                                                      element
                                                                          .icon
                                                                          .toString())
                                                                  .toList(),
                                                              ref: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .refId ??
                                                                  0,
                                                              weight: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .weight ??
                                                                  0.00,
                                                              currentStep: widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .currentStatus ??
                                                                  1,
                                                              isOpen: widget
                                                                  .controller
                                                                  .deliverShipemet[
                                                                      i]
                                                                  .isOpen,
                                                              onPressedShowMore:
                                                                  () {
                                                                if (widget
                                                                        .controller
                                                                        .deliverShipemet[
                                                                            i]
                                                                        .isOpen ==
                                                                    false) {
                                                                  widget
                                                                      .controller
                                                                      .deliverShipemet
                                                                      .forEach((element) =>
                                                                          element.isOpen =
                                                                              false);
                                                                  widget
                                                                          .controller
                                                                          .deliverShipemet[
                                                                              i]
                                                                          .isOpen =
                                                                      !widget
                                                                          .controller
                                                                          .deliverShipemet[
                                                                              i]
                                                                          .isOpen;
                                                                  x.update();
                                                                } else {
                                                                  print(
                                                                      '-------------');
                                                                  widget
                                                                      .controller
                                                                      .deliverShipemet[
                                                                          i]
                                                                      .isOpen = false;
                                                                  x.update();
                                                                }

                                                                print(widget
                                                                    .controller
                                                                    .deliverShipemet[
                                                                        i]
                                                                    .isOpen
                                                                    .toString());
                                                              },
                                                            ),
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
                      title: 'Delivered\nShipments',
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
                      Get.to(UndeliverListing());
                      if (false)
                        Get.to(
                            () =>
                                GetX<DashbordController>(builder: (controller) {
                                  return widget.controller.tobePickup.isEmpty
                                      ? MainCardBodyView(
                                          controller: controller
                                                  .inViewLoadingToBePickupShipments
                                                  .value
                                              ? WaiteImage()
                                              : EmptyState(
                                                  label: 'No data',
                                                ),
                                          title: "Un-Delivered Shipments")
                                      : Container(
                                          color: Colors.white,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: controller
                                                            .loadMoreToBePickup
                                                            .value ==
                                                        true
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.93
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        1,
                                                child: MainCardBodyView(
                                                  title:
                                                      "Un-Delivered Shipments",
                                                  controller: SmartRefresher(
                                                    header: WaterDropHeader(
                                                      waterDropColor:
                                                          primaryColor,
                                                    ),
                                                    controller:
                                                        toBePickupShipmentRefreshController,
                                                    onRefresh: () async {
                                                      _refresh(
                                                          type: Status
                                                              .TO_BE_PICKUP);
                                                    },
                                                    child: ListView.separated(
                                                      controller:
                                                          toBePickupScrollController,
                                                      separatorBuilder:
                                                          (context, i) =>
                                                              const SizedBox(
                                                                  height: 15),
                                                      itemCount: controller
                                                          .tobePickup.length,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              bottom: 10,
                                                              top: 5),
                                                      itemBuilder:
                                                          (context, i) {
                                                        return AllPickupBody(
                                                          cod:
                                                              "${widget.controller.tobePickup[i].cop ?? 0}",
                                                          name:
                                                              "${widget.controller.tobePickup[i].driver ?? "undefined"}",
                                                          qty:
                                                              "${widget.controller.tobePickup[i].quantity ?? 0}",
                                                          date:
                                                              "${widget.controller.tobePickup[i].date ?? "dd-mm-yyyy"}",
                                                          id: "${widget.controller.tobePickup[i].id ?? 00}",
                                                          onPressed: () {
                                                            // controllerClass.makePhoneCall(
                                                            //     "${controllerClass.allPickup[i]!.driveMobile}");
                                                          },
                                                          status: widget
                                                                  .controller
                                                                  .tobePickup[i]
                                                                  .status ??
                                                              '',
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (controller?.loadMoreToBePickup
                                                      .value ==
                                                  true)
                                                WaiteImage()
                                            ],
                                          ),
                                        );
                                }),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                    },
                    child: _InsideSmallBox(
                      image: 'assets/images/tobepickup.png',
                      // title: 'To Be\nPickup',
                      title: 'Un-Delivered\nShipments',

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
                      Get.to(
                          () => GetX<DashbordController>(builder: (controller) {
                                return widget.controller.ofdShipemet.isEmpty
                                    ? MainCardBodyView(
                                        controller: controller
                                                .inViewLoadingOFDShipments.value
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        // title: "To Be Delivered")
                                        title: "Out For Delivery OFD (" +
                                            controller.ofdShipemet.length
                                                .toString() +
                                            "/" +
                                            controller.dashboardOFDShiments
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
                                                    title: "Out For Delivery OFD (" +
                                                        controller
                                                            .ofdShipemet.length
                                                            .toString() +
                                                        "/" +
                                                        controller
                                                            .dashboardOFDShiments
                                                            .toString() +
                                                        ")",
                                                    controller: SmartRefresher(
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
                                                      child: ListView.separated(
                                                        controller:
                                                            ofdScrollController,
                                                        separatorBuilder:
                                                            (context, i) =>
                                                                const SizedBox(
                                                                    height: 15),
                                                        itemCount: controller
                                                            .ofdShipemet.length,
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
                                                                CardBody(
                                                              Order_current_Status:
                                                                  controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .orderStatusName,
                                                              customer_name: controller
                                                                  .ofdShipemet[
                                                                      i]
                                                                  .customerName,
                                                              deleiver_image: controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .orderDeliverImage ??
                                                                  "",
                                                              undeleiver_image:
                                                                  controller
                                                                          .ofdShipemet[
                                                                              i]
                                                                          .orderUndeliverImage ??
                                                                      "",
                                                              pickup_image: controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .orderPickupImage ??
                                                                  "",
                                                              orderId: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .orderId ??
                                                                  00,
                                                              status_key: widget
                                                                  .controller
                                                                  .ofdShipemet[
                                                                      i]
                                                                  .orderStatusKey,
                                                              number: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .phone ??
                                                                  "+968",
                                                              cod: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .cod ??
                                                                  "0.00",
                                                              cop: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .cop ??
                                                                  "0.00",
                                                              orderNumber:
                                                                  controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .orderNo,
                                                              shipmentCost: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .shippingPrice ??
                                                                  "0.00",
                                                              totalCharges:
                                                                  '${double.parse(widget.controller.ofdShipemet[i].shippingPrice.toString()) + double.parse(widget.controller.ofdShipemet[i].cod.toString())}',
                                                              stutaus: widget
                                                                  .controller
                                                                  .ofdShipemet[
                                                                      i]
                                                                  .orderActivities,
                                                              icon: widget
                                                                  .controller
                                                                  .ofdlList
                                                                  .map((element) =>
                                                                      element
                                                                          .icon
                                                                          .toString())
                                                                  .toList(),
                                                              ref: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .refId ??
                                                                  0,
                                                              weight: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .weight ??
                                                                  0.00,
                                                              currentStep: widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .currentStatus ??
                                                                  1,
                                                              isOpen: widget
                                                                  .controller
                                                                  .ofdShipemet[
                                                                      i]
                                                                  .isOpen,
                                                              onPressedShowMore:
                                                                  () {
                                                                if (widget
                                                                        .controller
                                                                        .ofdShipemet[
                                                                            i]
                                                                        .isOpen ==
                                                                    false) {
                                                                  widget
                                                                      .controller
                                                                      .ofdShipemet
                                                                      .forEach((element) =>
                                                                          element.isOpen =
                                                                              false);
                                                                  widget
                                                                          .controller
                                                                          .ofdShipemet[
                                                                              i]
                                                                          .isOpen =
                                                                      !widget
                                                                          .controller
                                                                          .ofdShipemet[
                                                                              i]
                                                                          .isOpen;
                                                                  x.update();
                                                                } else {
                                                                  print(
                                                                      '-------------');
                                                                  widget
                                                                      .controller
                                                                      .ofdShipemet[
                                                                          i]
                                                                      .isOpen = false;
                                                                  x.update();
                                                                }

                                                                print(widget
                                                                    .controller
                                                                    .ofdShipemet[
                                                                        i]
                                                                    .isOpen
                                                                    .toString());
                                                              },
                                                            ),
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
                      title: "Out For Delivery OFD ",
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
                      Get.to(
                          () => GetX<DashbordController>(builder: (controller) {
                                return widget.controller.returnShipemet.isEmpty
                                    ? MainCardBodyView(
                                        controller: controller
                                                .inViewLoadingReturnedShipments
                                                .value
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        title: "Return Shipments (" +
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
                                                    title: "Return Shipments (" +
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
                                                                CardBody(
                                                              deleiver_image: controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .orderDeliverImage ??
                                                                  "",
                                                              customer_name: controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .customerName ??
                                                                  "",
                                                              undeleiver_image:
                                                                  controller
                                                                          .returnShipemet[
                                                                              i]
                                                                          .orderUndeliverImage ??
                                                                      "",
                                                              pickup_image: controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .orderPickupImage ??
                                                                  "",
                                                              orderId: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .orderId ??
                                                                  00,
                                                              number: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .phone ??
                                                                  "+968",
                                                              orderNumber:
                                                                  controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .orderNo,
                                                              status_key: widget
                                                                  .controller
                                                                  .returnShipemet[
                                                                      i]
                                                                  .orderStatusKey,
                                                              Order_current_Status:
                                                                  controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .orderStatusName,
                                                              cod: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .cod ??
                                                                  "0.00",
                                                              cop: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .cop ??
                                                                  "0.00",
                                                              shipmentCost: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .shippingPrice ??
                                                                  "0.00",
                                                              totalCharges:
                                                                  '${double.parse(widget.controller.returnShipemet[i].shippingPrice.toString()) + double.parse(widget.controller.returnShipemet[i].cod.toString())}',
                                                              stutaus: widget
                                                                  .controller
                                                                  .returnShipemet[
                                                                      i]
                                                                  .orderActivities,
                                                              icon: widget
                                                                  .controller
                                                                  .returnList
                                                                  .map((element) =>
                                                                      element
                                                                          .icon
                                                                          .toString())
                                                                  .toList(),
                                                              ref: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .refId ??
                                                                  0,
                                                              weight: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .weight ??
                                                                  0.00,
                                                              currentStep: widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .currentStatus ??
                                                                  1,
                                                              isOpen: widget
                                                                  .controller
                                                                  .returnShipemet[
                                                                      i]
                                                                  .isOpen,
                                                              onPressedShowMore:
                                                                  () {
                                                                if (widget
                                                                        .controller
                                                                        .returnShipemet[
                                                                            i]
                                                                        .isOpen ==
                                                                    false) {
                                                                  widget
                                                                      .controller
                                                                      .returnShipemet
                                                                      .forEach((element) =>
                                                                          element.isOpen =
                                                                              false);
                                                                  widget
                                                                          .controller
                                                                          .returnShipemet[
                                                                              i]
                                                                          .isOpen =
                                                                      !widget
                                                                          .controller
                                                                          .returnShipemet[
                                                                              i]
                                                                          .isOpen;
                                                                  x.update();
                                                                } else {
                                                                  print(
                                                                      '-------------');
                                                                  widget
                                                                      .controller
                                                                      .returnShipemet[
                                                                          i]
                                                                      .isOpen = false;
                                                                  x.update();
                                                                }

                                                                print(widget
                                                                    .controller
                                                                    .returnShipemet[
                                                                        i]
                                                                    .isOpen
                                                                    .toString());
                                                              },
                                                            ),
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
                    child: _InsideSmallBox(
                      image: 'assets/images/returnshipment.png',
                      title: 'Returned\nShipments',
                      numbers:
                          '${widget.controller.returnShipmentNumber.value}',
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
                    Get.to(
                        () => GetX<DashbordController>(builder: (controller) {
                              return widget.controller.cancellShipemet.isEmpty
                                  ? MainCardBodyView(
                                      controller: controller
                                              .inViewLoadingCancelledShipments
                                              .value
                                          ? WaiteImage()
                                          : EmptyState(
                                              label: 'No data',
                                            ),
                                      title: "Cancel Shipments (" +
                                          controller.cancellShipemet.length
                                              .toString() +
                                          "/" +
                                          controller
                                              .dashboardCancelledShiments.value
                                              .toString() +
                                          ")")
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Colors.white,
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
                                                  title: "Cancel Shipments (" +
                                                      controller.cancellShipemet
                                                          .length
                                                          .toString() +
                                                      "/" +
                                                      controller
                                                          .dashboardCancelledShiments
                                                          .value
                                                          .toString() +
                                                      ")",
                                                  controller: SmartRefresher(
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
                                                    child: ListView.separated(
                                                      controller:
                                                          cancelScrollController,
                                                      separatorBuilder:
                                                          (context, i) =>
                                                              const SizedBox(
                                                                  height: 15),
                                                      itemCount: controller
                                                          .cancellShipemet
                                                          .length,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              bottom: 10,
                                                              top: 5),
                                                      itemBuilder:
                                                          (context, i) {
                                                        return CardBody(
                                                          deleiver_image: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .orderDeliverImage ??
                                                              "",
                                                          customer_name: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .customerName ??
                                                              "",
                                                          undeleiver_image: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .orderUndeliverImage ??
                                                              "",
                                                          pickup_image: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .orderPickupImage ??
                                                              "",
                                                          orderId: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .orderId ??
                                                              "00",
                                                          number: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .phone ??
                                                              "+968",
                                                          cod: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .cod ??
                                                              "0.00",
                                                          cop: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .cop ??
                                                              "0.00",
                                                          status_key: controller
                                                              .cancellShipemet[
                                                                  i]
                                                              .orderStatusKey,
                                                          orderNumber: controller
                                                              .cancellShipemet[
                                                                  i]
                                                              .orderNo,
                                                          shipmentCost: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .shippingPrice ??
                                                              "0.00",
                                                          totalCharges:
                                                              '${double.parse(controller.cancellShipemet[i].shippingPrice.toString()) + double.parse(controller.cancellShipemet[i].cod.toString())}',
                                                          stutaus: controller
                                                              .cancellShipemet[
                                                                  i]
                                                              .orderActivities,
                                                          icon: controller
                                                              .cancellList
                                                              .map((element) =>
                                                                  element.icon
                                                                      .toString())
                                                              .toList(),
                                                          ref: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .refId ??
                                                              0,
                                                          weight: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .weight ??
                                                              0.00,
                                                          currentStep: controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .currentStatus ??
                                                              1,
                                                          isOpen: controller
                                                              .cancellShipemet[
                                                                  i]
                                                              .isOpen,
                                                          Order_current_Status:
                                                              controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .orderStatusName,
                                                          onPressedShowMore:
                                                              () {
                                                            if (controller
                                                                    .cancellShipemet[
                                                                        i]
                                                                    .isOpen ==
                                                                false) {
                                                              controller
                                                                  .cancellShipemet
                                                                  .forEach((element) =>
                                                                      element.isOpen =
                                                                          false);
                                                              controller
                                                                      .cancellShipemet[
                                                                          i]
                                                                      .isOpen =
                                                                  !controller
                                                                      .cancellShipemet[
                                                                          i]
                                                                      .isOpen;
                                                              // x.update();
                                                              controller
                                                                  .update();
                                                            } else {
                                                              print(
                                                                  '-------------');
                                                              controller
                                                                  .cancellShipemet[
                                                                      i]
                                                                  .isOpen = false;
                                                              controller
                                                                  .update();
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (controller
                                              .loadMoreCancelShipments.value)
                                            bottomLoadingIndicator()
                                        ],
                                      ),
                                    );
                            }),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 400));
                  },
                  child: _InsideShape(
                    image: 'assets/images/cancell.png',
                    title: 'Cancelled Shipments',
                    numbers:
                        '${widget.controller.dashboardCancelledShiments.value}',
                  ),
                ),
                0.0,
                0.0,
                15.0,
                15.0),
          ]),
        ),
      ),
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
      boxShadow: [
        BoxShadow(
            // spreadRadius: 1,
            // blurRadius: 1,
            // offset: Offset(0.0, 1.0),
            )
      ],
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
              height: 32,
              width: 32,
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
          height: 50,
          width: 50,
        )
      ],
    );
  }
}
