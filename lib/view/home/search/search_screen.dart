import 'dart:async';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/search_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/home/card_body_new_log.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, this.defaultSearch = ""}) : super(key: key);
  final String defaultSearch;

  @override
  State<SearchScreen> createState() => _UndeliverListing();
}

class _UndeliverListing extends State<SearchScreen> {
  SearchController controller = Get.put(SearchController());
  HelperController helperController = Get.put(HelperController());

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? _debounce;

  void _refresh() async {
    await controller.searchData(searchText: searchText, isRefresh: true);
    refreshController.refreshCompleted();
  }

  String searchText = "";
  @override
  void initState() {
    setState(() {
      searchText = widget.defaultSearch;
    });
    if (widget.defaultSearch != "") _refresh();

    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: widget.defaultSearch != ""
              ? "OrderId#".tr + widget.defaultSearch
              : "Search".tr,
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
              // borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // height: 50,
                    child: widget.defaultSearch != ""
                        ? Container()
                        : TextField(
                            controller: widget.defaultSearch == ""
                                ? null
                                : TextEditingController(text: searchText),
                            onChanged: (val) {
                              setState(() {
                                searchText = val;
                              });
                              if (_debounce?.isActive ?? false)
                                _debounce?.cancel();
                              _debounce =
                                  Timer(const Duration(milliseconds: 500), () {
                                if (searchText.isEmpty || searchText.length < 4)
                                  controller.shipments.value = [];
                                else
                                  refreshController.requestRefresh();

                                // do something with query
                              });
                            },
                            textCapitalization: TextCapitalization.characters,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: primaryColor)),
                              hintText: 'Search'.tr,
                              helperText: 'write_order_number'.tr,
                              labelText: 'search_order'.tr,
                              prefixIcon: Icon(
                                Icons.search,
                                color: primaryColor,
                              ),
                              prefixText: ' ',
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: GetX<SearchController>(builder: (controller) {
                    return SmartRefresher(
                        header: WaterDropHeader(
                          waterDropColor: primaryColor,
                        ),
                        controller: refreshController,
                        onRefresh: () async {
                          _refresh();
                        },
                        child: controller.shipments.isEmpty
                            ? controller.loading.value
                                ? WaiteImage()
                                : NoDataView(label: "NoData".tr)
                            : ListView.separated(
                                // shrinkWrap: false,

                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 15),
                                itemCount: controller.shipments.length,
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10, top: 5),
                                itemBuilder: (context, i) {
                                  return GetBuilder<SearchController>(
                                    builder: (x) => card(
                                        controller,
                                        controller.shipments[i],
                                        x,
                                        Get.put(HelperController())
                                            .trackingStatuses,
                                        searchText: searchText),
                                  );
                                },
                              ));
                  }),
                ),
              ],
            )));
  }
}

CardBody card(
  SearchController controller,
  Shipment shipment,
  SearchController x,
  RxList<TrackingStatus> trackingStatuses, {
  String searchText = "",
}) {
  return CardBody(
    searchText: searchText,
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
    icon: trackingStatuses.map((element) => element.icon.toString()).toList(),
    status_key: shipment.orderStatusKey,
    ref: shipment.refId,
    weight: shipment.weight,
    currentStep: shipment.trackingId,
    isOpen: shipment.isOpen,
    onPressedShowMore: () {
      if (shipment.isOpen == false) {
        controller.shipments.forEach((element) => element.isOpen = false);
        shipment.isOpen = !shipment.isOpen;
        x.update();
      } else {
        shipment.isOpen = false;
        x.update();
      }
    },
  );
}
