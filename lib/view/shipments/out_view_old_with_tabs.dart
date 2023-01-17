import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/shipments/listViewTabs.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OutShipments extends StatefulWidget {
  OutShipments({Key? key}) : super(key: key);

  @override
  State<OutShipments> createState() => _OutShipmentsState();
}

class _OutShipmentsState extends State<OutShipments> {
  final dashboardController = Get.put(DashbordController());

  final controller = Get.put(ShipmentViewModel(), permanent: true);
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;
  final dashboarDController = Get.put(DashbordController());
  _loadMore() {
    if (controller.outLoadMore.value) return;
    if (controller.total_out > controller.outList.length &&
        scrollController!.position.extentAfter < 3000) {
      controller.fetchOutShipemetData(isRefresh: false);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
  }

  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore();
    });

    super.dispose();
  }

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ALL'.tr),
    Tab(text: 'OFD'),
    Tab(text: 'DA1'.tr),
    Tab(text: 'DA2'.tr),
    Tab(text: 'CA1'.tr),
    Tab(text: 'CA2'.tr),
  ];
  final List<Widget> myWidgets = <Widget>[
    ShipmentListView(
      type: "all",
      module: "all",
      attempts: 1,
    ),
    ShipmentListView(
      type: "OFD",
      module: "OFD",
      attempts: 1,
    ),
    ShipmentListView(
      type: "delivery_attempts1",
      module: "delivery_attempts",
      attempts: 1,
    ),
    ShipmentListView(
      type: "delivery_attempts2",
      module: "delivery_attempts",
      attempts: 2,
    ),
    ShipmentListView(
      type: "call_attempts1",
      module: "call_attempts",
      attempts: 1,
    ),
    ShipmentListView(
      type: "call_attempts2",
      module: "call_attempts",
      attempts: 2,
    )
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Obx(() {
      if (controller.isLoadingOut.value) {
        return const WaiteImage();
      }

      if (true) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ShipmentListView(
                    type: "all",
                    module: "all",
                    attempts: 1,
                  ),
                ),
                if (false)
                  Flexible(
                    child: DefaultTabController(
                      length: myTabs.length,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          ButtonsTabBar(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            backgroundColor: primaryColor,
                            unselectedBackgroundColor: Colors.grey.shade300,
                            unselectedLabelStyle:
                                TextStyle(color: Colors.black),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            tabs: myTabs,
                          ),
                          Expanded(
                            child: TabBarView(children: myWidgets),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (false)
                  SizedBox(
                    height: 40,
                    child: MyInput(
                      keyboardType: TextInputType.number,
                      hintText: 'EnterShipmentNumber'.tr,
                      onChanged: controller.onSearchTextChanged2,
                      controller: controller.searchConter,
                      suffixIcon: MaterialButton(
                          minWidth: 5,
                          color: primaryColor,
                          onPressed: () {},
                          child: const Icon(
                            Icons.search,
                            color: whiteColor,
                          )),
                    ),
                  ),
                if (false)
                  const SizedBox(
                    height: 5,
                  ),
                if (false)
                  Expanded(
                    flex: 12,
                    child: SmartRefresher(
                      header: WaterDropHeader(
                        waterDropColor: primaryColor,
                      ),
                      controller: refreshController,
                      onRefresh: () async {
                        await controller.fetchOutShipemetData(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      child: controller.searchResult.isNotEmpty
                          ? ListView.separated(
                              controller: scrollController,
                              separatorBuilder: (context, i) =>
                                  const SizedBox(height: 15),
                              itemCount: controller.searchResult.length,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10, top: 5),
                              itemBuilder: (context, i) {
                                return GetBuilder<ShipmentViewModel>(
                                  builder: (x) => CardBody(
                                    shipment: controller.searchResult[i]!,
                                    willaya:
                                        controller.searchResult[i]!.wilayaName,
                                    area: controller.searchResult[i]!.areaName,
                                    date: controller.searchResult[i]!.updatedAt,
                                    customer_name: controller
                                        .searchResult[i]!.customerName,
                                    deleiver_image: controller
                                        .searchResult[i]!.orderDeliverImage,
                                    undeleiver_image: controller
                                        .searchResult[i]!.orderUndeliverImage,
                                    pickup_image: controller
                                        .searchResult[i]!.orderPickupImage,
                                    orderId:
                                        controller.searchResult[i]!.orderId ??
                                            "00",
                                    number: controller.searchResult[i]!.phone ??
                                        "+968",
                                    cod: controller.searchResult[i]!.cod ??
                                        "0.00",
                                    orderNumber:
                                        controller.searchResult[i]!.orderNo,
                                    cop: controller.searchResult[i]!.cop ??
                                        "0.00",
                                    shipmentCost: controller
                                            .searchResult[i]!.shippingPrice ??
                                        "0.00",
                                    totalCharges:
                                        '${double.parse(controller.searchResult[i]!.cod.toString()) - double.parse(controller.searchResult[i]!.shippingPrice.toString())}',
                                    stutaus: controller
                                        .searchResult[i]!.orderActivities,
                                    icon: dashboardController.trackingStatuses
                                        .map((element) =>
                                            element.icon.toString())
                                        .toList(),
                                    ref: controller.searchResult[i]!.refId ??
                                        "0",
                                    status_key: controller
                                        .searchResult[i]!.orderStatusKey,
                                    Order_current_Status: controller
                                        .searchResult[i]!.orderStatusName,
                                    weight:
                                        controller.searchResult[i]!.weight ??
                                            "0.00",
                                    currentStep: controller
                                            .searchResult[i]!.currentStatus ??
                                        1,
                                    isOpen: controller.searchResult[i]!.isOpen,
                                    onPressedShowMore: () {
                                      controller.searchResult[i]!.isOpen =
                                          !controller.searchResult[i]!.isOpen;
                                      x.update();
                                      print(controller.searchResult[i]!.isOpen
                                          .toString());
                                    },
                                  ),
                                );
                              },
                            )
                          : controller.searchResult.isEmpty &&
                                  controller.searchConter.text.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    EmptyState(
                                      label: 'noData'.tr,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        controller.fetchOutShipemetData();
                                        print('ok');
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomText(
                                            text: 'Updateddata'.tr,
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
                                )
                              : ListView.separated(
                                  controller: scrollController,
                                  separatorBuilder: (context, i) =>
                                      const SizedBox(height: 15),
                                  itemCount: controller.outList.length,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 10, top: 5),
                                  itemBuilder: (context, i) {
                                    return GetBuilder<ShipmentViewModel>(
                                      builder: (x) => CardBody(
                                        shipment: controller.outList[i]!,
                                        willaya:
                                            controller.outList[i]!.wilayaName,
                                        area: controller.outList[i]!.areaName,
                                        customer_name:
                                            controller.outList[i]!.customerName,
                                        deleiver_image: controller
                                            .outList[i]!.orderDeliverImage,
                                        undeleiver_image: controller
                                            .outList[i]!.orderUndeliverImage,
                                        pickup_image: controller
                                            .outList[i]!.orderPickupImage,
                                        orderId:
                                            controller.outList[i]!.orderId ??
                                                "00",
                                        number: controller.outList[i]!.phone ??
                                            "+968",
                                        cod: controller.outList[i]!.cod ??
                                            "0.00",
                                        cop: controller.outList[i]!.cop ??
                                            "0.00",
                                        orderNumber:
                                            controller.outList[i]!.orderNo,
                                        shipmentCost: controller
                                                .outList[i]!.shippingPrice ??
                                            "0.00",
                                        date: controller.outList[i]!.updatedAt,
                                        totalCharges:
                                            '${double.parse(controller.outList[i]!.cod.toString()) - double.parse(controller.outList[i]!.shippingPrice.toString())}',
                                        stutaus: controller
                                            .outList[i]!.orderActivities,
                                        icon: dashboardController
                                            .trackingStatuses
                                            .map((element) =>
                                                element.icon.toString())
                                            .toList(),
                                        ref:
                                            controller.outList[i]!.refId ?? "0",
                                        weight: controller.outList[i]!.weight ??
                                            "0.00",
                                        status_key: controller
                                            .outList[i]!.orderStatusKey,
                                        Order_current_Status: controller
                                            .outList[i]!.orderStatusName,
                                        currentStep: controller
                                                .outList[i]!.currentStatus ??
                                            1,
                                        isOpen: controller.outList[i]!.isOpen,
                                        onPressedShowMore: () {
                                          if (controller.outList[i]!.isOpen ==
                                              false) {
                                            controller.outList.forEach(
                                                (element) =>
                                                    element!.isOpen = false);
                                            controller.outList[i]!.isOpen =
                                                !controller.outList[i]!.isOpen;
                                            x.update();
                                          } else {
                                            controller.outList[i]!.isOpen =
                                                false;
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
            if (false && controller.outLoadMore.value) bottomLoadingIndicator()
          ],
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyState(
            label: 'NoData'.tr,
          ),
          MaterialButton(
            onPressed: () {
              controller.fetchOutShipemetData(isRefresh: true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Updateddata'.tr,
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
    });
  }
}
