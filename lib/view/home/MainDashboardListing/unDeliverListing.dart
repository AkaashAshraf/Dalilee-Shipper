import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbord_model_view.dart';
import 'package:dalile_customer/model/all_shipment.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UndeliverListing extends StatefulWidget {
  UndeliverListing({Key? key}) : super(key: key);

  @override
  State<UndeliverListing> createState() => _UndeliverListing();
}

class _UndeliverListing extends State<UndeliverListing> {
  DashbordController controller = Get.put(DashbordController());
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;

  void _refresh() async {
    await controller.fetchUnDeliverShipemetData(isRefresh: true);
    refreshController.refreshCompleted();
    if (this.mounted)
      setState(() {
        subTitle = controller.undeliverShipemet.length.toString() +
            "/" +
            controller.dashboardUndeliver.value.toString();
      });
  }

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
    if (this.mounted)
      setState(() {
        subTitle = controller.undeliverShipemet.length.toString() +
            "/" +
            controller.dashboardUndeliver.value.toString();
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
    print(controller.dashboardUndeliver.value >
        controller.undeliverShipemet.length);

    if (controller.loadMoreUndeliver.value) return;
    if ((controller.dashboardUndeliver.value >
            controller.undeliverShipemet.length) &&
        scrollController!.position.extentAfter < 100.0) {
      // bool isTop = scrollController!.position.pixels == 0;
      controller.loadMoreUndeliver.value = true;
      await controller.fetchUnDeliverShipemetData();
      if (this.mounted)
        setState(() {
          subTitle = controller.undeliverShipemet.length.toString() +
              "/" +
              controller.dashboardUndeliver.value.toString();
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
          text: "Un-Delivered Orders ($subTitle)",
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
          child: GetX<DashbordController>(builder: (controller) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: controller.undeliverShipemet.isEmpty
                  ? controller.inViewLoadingUndeliver.value
                      ? WaiteImage()
                      : NoDataView(label: "Un Deliver Data")
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
                                    itemCount:
                                        controller.undeliverShipemet.length,

                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 10,
                                        top: 5),
                                    itemBuilder: (context, i) {
                                      return GetBuilder<DashbordController>(
                                        builder: (x) => card(controller,
                                            controller.undeliverShipemet[i], x),
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
    if (controller.loadMoreUndeliver.value) {
      return Positioned(
          bottom: 0, left: 0, right: 0, child: const WaiteImage());
    } else
      return Text('');
  } //all

}

CardBody card(
  DashbordController controller,
  Shipment shipment,
  DashbordController x,
) {
  return CardBody(
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
        '${double.parse(shipment.shippingPrice.toString()) + double.parse(shipment.cod.toString())}',
    stutaus: shipment.orderActivities,
    icon: controller.unDeliverStatuses
        .map((element) => element.icon.toString())
        .toList(),
    status_key: shipment.orderStatusKey,
    ref: shipment.refId ?? 0,
    weight: shipment.weight ?? 0.00,
    currentStep: shipment.currentStatus ?? 1,
    isOpen: shipment.isOpen,
    onPressedShowMore: () {
      if (shipment.isOpen == false) {
        controller.undeliverShipemet
            .forEach((element) => element.isOpen = false);
        shipment.isOpen = !shipment.isOpen;
        x.update();
      } else {
        shipment.isOpen = false;
        x.update();
      }
    },
  );
}
