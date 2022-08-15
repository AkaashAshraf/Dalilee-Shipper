import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbord_model_view.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/home/item_body.dart';
import 'package:dalile_customer/view/widget/all_pickup_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
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
  CENCELLED_SHIPMENTS
}

class _MainDashState extends State<MainDash> {
  ScrollController? allShipmentScroll_Controller;
  ScrollController? deliveredShipmentScroll_Controller;
  ScrollController? to_bePickupScroll_Controller;
  ScrollController? to_be_delieveredScroll_Controller;
  ScrollController? returenedScroll_Controller;
  ScrollController? cancelScroll_Controller;

  RefreshController MainScreenRefresh_Controller =
      RefreshController(initialRefresh: true);

  RefreshController allShipmentRefresh_Controller =
      RefreshController(initialRefresh: true);
  RefreshController deliveredShipmentRefresh_Controller =
      RefreshController(initialRefresh: true);
  RefreshController to_be_deliveredShipmentRefresh_Controller =
      RefreshController(initialRefresh: true);
  RefreshController to_be_pickupShipmentRefresh_Controller =
      RefreshController(initialRefresh: true);
  RefreshController returnedShipmentRefresh_Controller =
      RefreshController(initialRefresh: true);

  RefreshController cancelShipmentRefresh_Controller =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    allShipmentScroll_Controller = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.ALL);
      });

    deliveredShipmentScroll_Controller = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.DELIVERED);
      });

    to_be_delieveredScroll_Controller = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.TO_BE_DELIVERED);
      });

    to_bePickupScroll_Controller = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.TO_BE_PICKUP);
      });

    returenedScroll_Controller = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.RETURNED_SHIPMENTS);
      });
    cancelScroll_Controller = ScrollController()
      ..addListener(() {
        _loadMore(type: Status.CENCELLED_SHIPMENTS);
      });
  }

  _loadMore({required type}) {
    switch (type) {
      case Status.ALL:
        {
          // if (widget.controller.inViewLoading_allShipments.value) return;
          if (widget.controller.dashboard_allShiments >
                  widget.controller.limit_allShiments.value &&
              allShipmentScroll_Controller!.position.extentAfter < 10) {
            // Increase _page by 1
            widget.controller.limit_allShiments.value += 10;
            bool isTop = allShipmentScroll_Controller!.position.pixels == 0;
            // if (!isTop) {
            widget.controller.loadMore.value = true;

            widget.controller.fetchAllShipemetData();
            // }
          }
          break;
        } //ALL
      case Status.DELIVERED:
        {
          // if (widget.controller.inViewLoading_deliveredShipments.value) return;
          if (widget.controller.dashboard_deliveredShipments >
                  widget.controller.limit_deliveredShipments.value &&
              deliveredShipmentScroll_Controller!.position.extentAfter < 10) {
            // Increase _page by 1
            bool isTop =
                deliveredShipmentScroll_Controller!.position.pixels == 0;
            // if (!isTop) {
            widget.controller.limit_deliveredShipments.value += 10;
            widget.controller.fetchDeliverShipemetData();
            // }
          }
          break;
        } //DELIVERED

      case Status.TO_BE_DELIVERED:
        {
          // if (widget.controller.inViewLoading_deliveredShipments.value) return;
          if (widget.controller.dashboard_to_b_Delivered >
                  widget.controller.limit_to_b_Delivered.value &&
              to_be_delieveredScroll_Controller!.position.extentAfter < 10) {
            // Increase _page by 1
            bool isTop =
                to_be_delieveredScroll_Controller!.position.pixels == 0;
            // if (!isTop) {
            widget.controller.limit_to_b_Delivered.value += 10;
            widget.controller.fetchToBeDeliveredShipemetData();
            // }
          }
          break;
        } //TO_BE_DELIVERED

      case Status.TO_BE_PICKUP:
        {
          // if (widget.controller.inViewLoading_deliveredShipments.value) return;
          if (widget.controller.dashboard_to_b_Pichup >
                  widget.controller.limit_to_b_Pichup.value &&
              to_bePickupScroll_Controller!.position.extentAfter < 10) {
            // Increase _page by 1
            bool isTop = to_bePickupScroll_Controller!.position.pixels == 0;
            // if (!isTop) {
            widget.controller.limit_to_b_Pichup.value += 10;
            widget.controller.fetchToBePickupData();
            // }
          }
          break;
        } //TO_BE_PICKUP
      case Status.RETURNED_SHIPMENTS:
        {
          // if (widget.controller.inViewLoading_deliveredShipments.value) return;
          if (widget.controller.dashboard_returnedShipment >
                  widget.controller.limit_returnedShipment.value &&
              returenedScroll_Controller!.position.extentAfter < 10) {
            // Increase _page by 1
            bool isTop = returenedScroll_Controller!.position.pixels == 0;
            // if (!isTop) {
            widget.controller.limit_returnedShipment.value += 10;
            widget.controller.fetchRetrunShipemetData();
            // }
          }
          break;
        } //RETURNED_SHIPMENTS

      case Status.CENCELLED_SHIPMENTS:
        {
          // if (widget.controller.inViewLoading_deliveredShipments.value) return;
          if (widget.controller.dashboard_CancelledShiments >
                  widget.controller.limit_CancelledShiments.value &&
              cancelScroll_Controller!.position.extentAfter < 10) {
            bool isTop = cancelScroll_Controller!.position.pixels == 0;
            // if (!isTop) {
            widget.controller.limit_CancelledShiments.value += 10;
            widget.controller.fetchcancellShipemetData();
            // }
          }
          break;
        } //RETURNED_SHIPMENTS

    } //switch
  }

  void _refresh({required type}) async {
    switch (type) {
      case Status.ALL:
        {
          var res =
              await widget.controller.fetchAllShipemetData(isRefresh: true);
          allShipmentRefresh_Controller.refreshCompleted();
          break;
        } //delived
      case Status.DELIVERED:
        {
          var res =
              await widget.controller.fetchDeliverShipemetData(isRefresh: true);
          deliveredShipmentRefresh_Controller.refreshCompleted();
          break;
        } //delived
      case Status.TO_BE_PICKUP:
        {
          var res = await widget.controller
              .fetchToBeDeliveredShipemetData(isRefresh: true);
          to_be_pickupShipmentRefresh_Controller.refreshCompleted();
          break;
        } //to be pickup
      case Status.TO_BE_DELIVERED:
        {
          var res = await widget.controller
              .fetchToBeDeliveredShipemetData(isRefresh: true);
          to_be_deliveredShipmentRefresh_Controller.refreshCompleted();
          break;
        } //tp\o be delived
      case Status.RETURNED_SHIPMENTS:
        {
          var res =
              await widget.controller.fetchRetrunShipemetData(isRefresh: true);
          returnedShipmentRefresh_Controller.refreshCompleted();
          break;
        } //to be delived
      case Status.CENCELLED_SHIPMENTS:
        {
          var res =
              await widget.controller.fetchcancellShipemetData(isRefresh: true);
          cancelShipmentRefresh_Controller.refreshCompleted();
          break;
        } //CENCELLED_SHIPMENTS
    } //switch
  }

  @override
  void dispose() {
    allShipmentScroll_Controller!.removeListener(() {
      _loadMore(type: Status.ALL);
    });
    deliveredShipmentScroll_Controller!.removeListener(() {
      _loadMore(type: Status.DELIVERED);
    });
    to_be_delieveredScroll_Controller!.removeListener(() {
      _loadMore(type: Status.TO_BE_DELIVERED);
    });
    to_bePickupScroll_Controller!.removeListener(() {
      _loadMore(type: Status.TO_BE_PICKUP);
    });
    returenedScroll_Controller!.removeListener(() {
      _loadMore(type: Status.RETURNED_SHIPMENTS);
    });
    cancelScroll_Controller!.removeListener(() {
      _loadMore(type: Status.CENCELLED_SHIPMENTS);
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
            MainScreenRefresh_Controller.refreshCompleted();
          },
          controller: MainScreenRefresh_Controller,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                _refresh(type: Status.ALL);
                Get.to(
                    () => GetX<DashbordController>(builder: (controller) {
                          return controller.allShipemet.isEmpty
                              ? MainCardBodyView(
                                  controller:
                                      controller?.inViewLoading_allShipments ==
                                              true
                                          ? WaiteImage()
                                          : EmptyState(
                                              label: 'No data',
                                            ),
                                  title: "Shipments")
                              : MainCardBodyView(
                                  title: 'All Shipments',
                                  controller: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      children: [
                                        Container(
                                          height:
                                              controller?.loadMore.value == true
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.78
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.82,
                                          child: SmartRefresher(
                                            header: WaterDropMaterialHeader(
                                              backgroundColor: primaryColor,
                                            ),
                                            controller:
                                                allShipmentRefresh_Controller,
                                            onRefresh: () async {
                                              _refresh(type: Status.ALL);
                                            },
                                            child: ListView.separated(
                                              controller:
                                                  allShipmentScroll_Controller,
                                              separatorBuilder: (context, i) =>
                                                  const SizedBox(height: 15),
                                              itemCount:
                                                  controller.allShipemet.length,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 10,
                                                  top: 5),
                                              itemBuilder: (context, i) {
                                                return GetBuilder<
                                                    DashbordController>(
                                                  builder: (x) => CardBody(
                                                    orderId: controller
                                                            .allShipemet[i]
                                                            .orderId ??
                                                        00,
                                                    number: controller
                                                            .allShipemet[i]
                                                            .phone ??
                                                        "+968",
                                                    orderNumber: controller
                                                        .allShipemet[i].orderNo,
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
                                                        .allShipemet[i].isOpen,
                                                    onPressedShowMore: () {
                                                      if (controller
                                                              .allShipemet[i]
                                                              .isOpen ==
                                                          false) {
                                                        controller.allShipemet
                                                            .forEach((element) =>
                                                                element.isOpen =
                                                                    false);
                                                        controller
                                                                .allShipemet[i]
                                                                .isOpen =
                                                            !controller
                                                                .allShipemet[i]
                                                                .isOpen;
                                                        x.update();
                                                      } else {
                                                        print('-------------');
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
                                        if (controller?.loadMore.value == true)
                                          WaiteImage()
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
                    numbers: '${widget.controller.dashboard_allShiments.value}',
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
                                                    ?.inViewLoading_deliveredShipments ==
                                                true
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        title: "Delivered Shipments")
                                    : Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: controller
                                                          ?.loadMore_deliveredShipments
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
                                                title: 'Delivered Shipments',
                                                controller: SmartRefresher(
                                                  header:
                                                      WaterDropMaterialHeader(
                                                    backgroundColor:
                                                        primaryColor,
                                                  ),
                                                  controller:
                                                      deliveredShipmentRefresh_Controller,
                                                  onRefresh: () async {
                                                    _refresh(
                                                        type: Status.DELIVERED);
                                                  },
                                                  child: ListView.separated(
                                                    controller:
                                                        deliveredShipmentScroll_Controller,
                                                    separatorBuilder:
                                                        (context, i) =>
                                                            const SizedBox(
                                                                height: 15),
                                                    itemCount: controller
                                                        .deliverShipemet.length,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 10,
                                                            top: 5),
                                                    itemBuilder: (context, i) {
                                                      return GetBuilder<
                                                          DashbordController>(
                                                        builder: (x) =>
                                                            CardBody(
                                                          orderId: widget
                                                                  .controller
                                                                  .deliverShipemet[
                                                                      i]
                                                                  .orderId ??
                                                              00,
                                                          orderNumber: controller
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
                                                                  element.icon
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
                                                              widget.controller
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
                                            if (controller
                                                    ?.loadMore_deliveredShipments
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
                      image: 'assets/images/delivered.png',
                      title: 'Delivered\nShipments',
                      numbers:
                          '${widget.controller.dashboard_deliveredShipments.value}',
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
                                return widget.controller.tobePickup.isEmpty
                                    ? MainCardBodyView(
                                        controller: controller
                                                    ?.inViewLoading_to_be_pickupShipments ==
                                                true
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        title: "To Be Pickup")
                                    : Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: controller
                                                          ?.loadMore_to_bePickup
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
                                                title: "To Be Pickup",
                                                controller: SmartRefresher(
                                                  header:
                                                      WaterDropMaterialHeader(
                                                    backgroundColor:
                                                        primaryColor,
                                                  ),
                                                  controller:
                                                      to_be_pickupShipmentRefresh_Controller,
                                                  onRefresh: () async {
                                                    _refresh(
                                                        type: Status
                                                            .TO_BE_PICKUP);
                                                  },
                                                  child: ListView.separated(
                                                    controller:
                                                        to_bePickupScroll_Controller,
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
                                                    itemBuilder: (context, i) {
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
                                            if (controller?.loadMore_to_bePickup
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
                      title: 'To Be\nPickup',
                      numbers: ' ${widget.controller.dashboard_to_b_Pichup}',
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
                                return widget.controller.tobeDelShipemet.isEmpty
                                    ? MainCardBodyView(
                                        controller: controller
                                                    .inViewLoading_to_be_deliveredShipments ==
                                                true
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        title: "To Be Delivered")
                                    : Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: controller
                                                          ?.loadMore_to_be_deliveredShipments
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
                                                title: 'To Be Deliver',
                                                controller: SmartRefresher(
                                                  header:
                                                      WaterDropMaterialHeader(
                                                    backgroundColor:
                                                        primaryColor,
                                                  ),
                                                  controller:
                                                      to_be_deliveredShipmentRefresh_Controller,
                                                  onRefresh: () async {
                                                    _refresh(
                                                        type: Status
                                                            .TO_BE_DELIVERED);
                                                  },
                                                  child: ListView.separated(
                                                    controller:
                                                        to_be_delieveredScroll_Controller,
                                                    separatorBuilder:
                                                        (context, i) =>
                                                            const SizedBox(
                                                                height: 15),
                                                    itemCount: controller
                                                        .tobeDelShipemet.length,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 10,
                                                            top: 5),
                                                    itemBuilder: (context, i) {
                                                      return GetBuilder<
                                                          DashbordController>(
                                                        builder: (x) =>
                                                            CardBody(
                                                          orderId: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .orderId ??
                                                              00,
                                                          number: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .phone ??
                                                              "+968",
                                                          cod: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .cod ??
                                                              "0.00",
                                                          cop: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .cop ??
                                                              "0.00",
                                                          orderNumber: controller
                                                              .tobeDelShipemet[
                                                                  i]
                                                              .orderNo,
                                                          shipmentCost: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .shippingPrice ??
                                                              "0.00",
                                                          totalCharges:
                                                              '${double.parse(widget.controller.tobeDelShipemet[i].shippingPrice.toString()) + double.parse(widget.controller.tobeDelShipemet[i].cod.toString())}',
                                                          stutaus: widget
                                                              .controller
                                                              .tobeDelShipemet[
                                                                  i]
                                                              .orderActivities,
                                                          icon: widget
                                                              .controller
                                                              .toBeDelvList
                                                              .map((element) =>
                                                                  element.icon
                                                                      .toString())
                                                              .toList(),
                                                          ref: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .refId ??
                                                              0,
                                                          weight: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .weight ??
                                                              0.00,
                                                          currentStep: widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .currentStatus ??
                                                              1,
                                                          isOpen: widget
                                                              .controller
                                                              .tobeDelShipemet[
                                                                  i]
                                                              .isOpen,
                                                          onPressedShowMore:
                                                              () {
                                                            if (widget
                                                                    .controller
                                                                    .tobeDelShipemet[
                                                                        i]
                                                                    .isOpen ==
                                                                false) {
                                                              widget.controller
                                                                  .tobeDelShipemet
                                                                  .forEach((element) =>
                                                                      element.isOpen =
                                                                          false);
                                                              widget
                                                                      .controller
                                                                      .tobeDelShipemet[
                                                                          i]
                                                                      .isOpen =
                                                                  !widget
                                                                      .controller
                                                                      .tobeDelShipemet[
                                                                          i]
                                                                      .isOpen;
                                                              x.update();
                                                            } else {
                                                              print(
                                                                  '-------------');
                                                              widget
                                                                  .controller
                                                                  .tobeDelShipemet[
                                                                      i]
                                                                  .isOpen = false;
                                                              x.update();
                                                            }

                                                            print(widget
                                                                .controller
                                                                .tobeDelShipemet[
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
                                            if (controller
                                                    ?.loadMore_to_be_deliveredShipments
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
                      image: 'assets/images/tobedelivered.png',
                      title: 'To Be\nDelivered',
                      numbers:
                          '${widget.controller.dashboard_to_b_Delivered.value}',
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
                                                    ?.inViewLoading_returnedShipments ==
                                                true
                                            ? WaiteImage()
                                            : EmptyState(
                                                label: 'No data',
                                              ),
                                        title: "Return Shipments")
                                    : Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: controller
                                                          ?.loadMore_returnShipments
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
                                                title: 'Return Shipments',
                                                controller: SmartRefresher(
                                                  header:
                                                      WaterDropMaterialHeader(
                                                    backgroundColor:
                                                        primaryColor,
                                                  ),
                                                  controller:
                                                      returnedShipmentRefresh_Controller,
                                                  onRefresh: () async {
                                                    _refresh(
                                                        type: Status
                                                            .RETURNED_SHIPMENTS);
                                                  },
                                                  child: ListView.separated(
                                                    controller:
                                                        returenedScroll_Controller,
                                                    separatorBuilder:
                                                        (context, i) =>
                                                            const SizedBox(
                                                                height: 15),
                                                    itemCount: controller
                                                        .returnShipemet.length,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 10,
                                                            top: 5),
                                                    itemBuilder: (context, i) {
                                                      return GetBuilder<
                                                          DashbordController>(
                                                        builder: (x) =>
                                                            CardBody(
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
                                                          orderNumber: controller
                                                              .returnShipemet[i]
                                                              .orderNo,
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
                                                              .returnShipemet[i]
                                                              .orderActivities,
                                                          icon: widget
                                                              .controller
                                                              .returnList
                                                              .map((element) =>
                                                                  element.icon
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
                                                              .returnShipemet[i]
                                                              .isOpen,
                                                          onPressedShowMore:
                                                              () {
                                                            if (widget
                                                                    .controller
                                                                    .returnShipemet[
                                                                        i]
                                                                    .isOpen ==
                                                                false) {
                                                              widget.controller
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
                                            if (controller
                                                    ?.loadMore_returnShipments
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
                                                  ?.inViewLoading_cancelledShipments ==
                                              true
                                          ? WaiteImage()
                                          : EmptyState(
                                              label: 'No data',
                                            ),
                                      title: "Cancel Shipments")
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: controller
                                                        ?.loadMore_cancelShipments
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
                                              title: 'Cancel Shipments',
                                              controller: SmartRefresher(
                                                header: WaterDropMaterialHeader(
                                                  backgroundColor: primaryColor,
                                                ),
                                                controller:
                                                    cancelShipmentRefresh_Controller,
                                                onRefresh: () async {
                                                  _refresh(
                                                      type: Status
                                                          .CENCELLED_SHIPMENTS);
                                                },
                                                child: ListView.separated(
                                                  controller:
                                                      cancelScroll_Controller,
                                                  separatorBuilder:
                                                      (context, i) =>
                                                          const SizedBox(
                                                              height: 15),
                                                  itemCount: controller
                                                      .cancellShipemet.length,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          bottom: 10,
                                                          top: 5),
                                                  itemBuilder: (context, i) {
                                                    return CardBody(
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
                                                      orderNumber: controller
                                                          .cancellShipemet[i]
                                                          .orderNo,
                                                      shipmentCost: controller
                                                              .cancellShipemet[
                                                                  i]
                                                              .shippingPrice ??
                                                          "0.00",
                                                      totalCharges:
                                                          '${double.parse(controller.cancellShipemet[i].shippingPrice.toString()) + double.parse(controller.cancellShipemet[i].cod.toString())}',
                                                      stutaus: controller
                                                          .cancellShipemet[i]
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
                                                          .cancellShipemet[i]
                                                          .isOpen,
                                                      onPressedShowMore: () {
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
                                                          controller.update();
                                                        } else {
                                                          print(
                                                              '-------------');
                                                          controller
                                                              .cancellShipemet[
                                                                  i]
                                                              .isOpen = false;
                                                          controller.update();
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (controller
                                                  ?.loadMore_cancelShipments
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
                  child: _InsideShape(
                    image: 'assets/images/cancell.png',
                    title: 'Cancelled Shipments',
                    numbers:
                        '${widget.controller.dashboard_CancelledShiments.value}',
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
