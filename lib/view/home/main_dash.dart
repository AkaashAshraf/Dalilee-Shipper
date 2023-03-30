import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/account_manager_controller.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/controllers/mange_account_controller.dart';
import 'package:dalile_customer/controllers/profile_controller.dart';
import 'package:dalile_customer/controllers/shipment_controller.dart';
import 'package:dalile_customer/controllers/view_order_controller.dart';
import 'package:dalile_customer/model/aacount_manager/store.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/account_manager/choose_store_view.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
  AccountManagerController accountManagerController =
      Get.put(AccountManagerController());
  @override
  void initState() {
    setState(() {
      selectedStore = accountManagerController.selectedStore.value;
    });
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

  void _refresh({required type}) async {
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

  Stores selectedStore = Stores();

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
              checkAppExpiry(context);
            },
            controller: mainScreenRefreshController,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  Text("Current Store Mobile"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(Get.put(ProfileController())
                                .profile
                                .value
                                .storeMobile ??
                            ""),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: (() => {
                            Get.defaultDialog(
                                title: "Change Store".tr,
                                titlePadding: const EdgeInsets.all(15),
                                contentPadding: const EdgeInsets.all(5),
                                middleText:
                                    "Are you sure you want to logout from this store?",
                                textCancel: 'Cancel'.tr,
                                textConfirm: 'Ok'.tr,
                                buttonColor: primaryColor,
                                confirmTextColor: Colors.white,
                                cancelTextColor: Colors.black,
                                radius: 10,
                                backgroundColor: whiteColor,
                                onConfirm: () async {
                                  // final prefs =
                                  //     await SharedPreferences.getInstance();

                                  // prefs.remove("loginData");
                                  // prefs.remove("token");
                                  // prefs.clear();
                                  // Get.deleteAll();
                                  Get.offAll(ChooseStoreView());
                                })
                          }),
                      child: Icon(Icons.logout, color: primaryColor, size: 35))
                ],
              ),
              // GetX<AccountManagerController>(builder: (controller) {
              //   return Container(
              //       height: 45,
              //       width: MediaQuery.of(context).size.width,
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: DropdownSearch<String>(
              //           label: "Select Store",
              //           autoValidateMode: AutovalidateMode.always,
              //           dropdownBuilder: ((context, item) => Text(item ?? "")),
              //           showSearchBox: true,
              //           showAsSuffixIcons: true,
              //           showSelectedItems: true,
              //           items: controller.stores
              //               .map((element) => element.mobile)
              //               .toList(),
              //           onChanged: (_value) {
              //             print(_value);
              //             Stores currentSelectedStore = controller.stores[
              //                 controller.stores.indexWhere(
              //                     (element) => element.mobile == _value)];
              //             // inspect(currentSelectedStore);
              //             setState(() {
              //               selectedStore = currentSelectedStore;
              //             });
              //           },
              //           selectedItem: selectedStore.mobile,
              //         ),
              //       )
              // dropdownBuilder: ((context, lis) =>
              //     Text(lis.id.toString())),
              // showClearButton: true,
              // popupProps: PopupPropsMultiSelection.menu(
              //     showSelectedItems: true,
              //     disabledItemFn: (String s) => s.startsWith('I'),
              // ),
              // onChanged: (){},
              // selectedItem:  ,
              // );
              // }),
              SizedBox(
                height: 10,
              ),
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
