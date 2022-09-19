import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/financeListingController.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum Status {
  ALL,
  PAID,
  COD_PENDING,
  READY_TO_PAY,
  COD_WITH_DRIVERS,
  COD_RETURN
}

class FinanceDasboradListing extends StatefulWidget {
  FinanceDasboradListing(
      {Key? key,
      this.onUplod,
      required this.title,
      required this.type,
      this.subTitle_: "0/0"})
      : super(key: key);
  final String title;
  final String subTitle_;
  final Enum type;

  final void Function()? onUplod;

  @override
  State<FinanceDasboradListing> createState() => _FinanceDasboradListingState();
}

class _FinanceDasboradListingState extends State<FinanceDasboradListing> {
  FinanceListingController controller = Get.put(FinanceListingController());
  RefreshController refreshController = RefreshController(initialRefresh: true);
  var dashboardController = Get.put(DashbordController());

  ScrollController? scrollController;

  void _refresh({required type}) async {
    switch (type) {
      case Status.ALL:
        {
          await controller.getAllOrders(isRefresh: true);
          refreshController.refreshCompleted();
          if (this.mounted)
            setState(() {
              subTitle = controller.listAll.length.toString() +
                  "/" +
                  controller.totalAll.toString();
            });
          break;
        } //delived
      case Status.PAID:
        {
          await controller.getPaidOrders(isRefresh: true);
          refreshController.refreshCompleted();
          if (this.mounted)
            setState(() {
              subTitle = controller.listPaid.length.toString() +
                  "/" +
                  controller.totalPaid.toString();
            });
          break;
        } //delived
      case Status.COD_PENDING:
        {
          await controller.getCodPendingOrders(isRefresh: true);
          refreshController.refreshCompleted();
          if (this.mounted)
            setState(() {
              subTitle = controller.listCodPending.length.toString() +
                  "/" +
                  controller.totalCodPending.toString();
            });
          break;
        } //to be pickup
      case Status.READY_TO_PAY:
        {
          await controller.getReadyToPayOrders(isRefresh: true);
          refreshController.refreshCompleted();
          if (this.mounted)
            setState(() {
              subTitle = controller.listReadyToPay.length.toString() +
                  "/" +
                  controller.totalReadyToPay.toString();
            });
          break;
        } //tp\o be delived
      case Status.COD_WITH_DRIVERS:
        {
          await controller.getCodWithDriversOrders(isRefresh: true);
          refreshController.refreshCompleted();
          if (this.mounted)
            setState(() {
              subTitle = controller.listCodWithDrivers.length.toString() +
                  "/" +
                  controller.totalCodWithDrivers.toString();
            });
          break;
        } //to be delived
      case Status.COD_RETURN:
        {
          await controller.getCodReturnOrders(isRefresh: true);
          refreshController.refreshCompleted();
          if (this.mounted)
            setState(() {
              subTitle = controller.listCodReturn.length.toString() +
                  "/" +
                  controller.totalCodReturn.toString();
            });
          break;
        } //CENCELLED_SHIPMENTS
    } //switch
  }

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore(type: widget.type);
      });
    if (this.mounted)
      setState(() {
        subTitle = widget.subTitle_;
      });

    super.initState();
  }

  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore(type: widget.type);

      _loadMore(type: Status.COD_RETURN);
    });

    super.dispose();
  }

  _loadMore({required type}) async {
    switch (type) {
      case Status.ALL:
        {
          if (controller.loadMoreAll.value) return;
          if ((controller.listAll.length <= controller.totalAll.value) &&
              scrollController!.position.extentAfter < 1000.0) {
            controller.loadMoreAll.value = true;
            await controller.getAllOrders();
            if (this.mounted)
              setState(() {
                subTitle = controller.listAll.length.toString() +
                    "/" +
                    controller.totalAll.toString();
              });
          }
          break;
        } //ALL
      case Status.PAID:
        {
          if (controller.loadMorePaid.value) return;
          if ((controller.listPaid.length <= controller.totalPaid.value) &&
              scrollController!.position.extentAfter < 1000.0) {
            controller.loadMorePaid.value = true;
            await controller.getPaidOrders();
            if (this.mounted)
              setState(() {
                subTitle = controller.listPaid.length.toString() +
                    "/" +
                    controller.totalPaid.toString();
              });
          }
          break;
        } //paid

      case Status.COD_PENDING:
        {
          if (controller.loadMoreCodPending.value) return;
          if ((controller.listCodPending.length <=
                  controller.totalCodPending.value) &&
              scrollController!.position.extentAfter < 1000.0) {
            controller.loadMoreCodPending.value = true;
            await controller.getCodPendingOrders();
            if (this.mounted)
              setState(() {
                subTitle = controller.listCodPending.length.toString() +
                    "/" +
                    controller.totalCodPending.toString();
              });
          }
          break;
        } //COD PENDING

      case Status.READY_TO_PAY:
        {
          if (controller.loadMoreReadyToPay.value) return;
          if ((controller.listReadyToPay.length <=
                  controller.totalReadyToPay.value) &&
              scrollController!.position.extentAfter < 1000.0) {
            // bool isTop = scrollController!.position.pixels == 0;
            controller.loadMoreReadyToPay.value = true;
            // controller.listReadyToPay += controller.listReadyToPay;
            await controller.getReadyToPayOrders();
            if (this.mounted)
              setState(() {
                subTitle = controller.listReadyToPay.length.toString() +
                    "/" +
                    controller.totalReadyToPay.toString();
              });
          }
          break;
        } //READY TO PAY
      case Status.COD_WITH_DRIVERS:
        {
          if (controller.loadMoreCodWithDrivers.value) return;
          if ((controller.listCodWithDrivers.length <=
                  controller.totalCodWithDrivers.value) &&
              scrollController!.position.extentAfter < 1000.0) {
            // bool isTop = scrollController!.position.pixels == 0;
            controller.loadMoreCodWithDrivers.value = true;
            await controller.getCodWithDriversOrders();
            if (this.mounted)
              setState(() {
                subTitle = controller.listCodWithDrivers.length.toString() +
                    "/" +
                    controller.totalCodWithDrivers.toString();
              });
          }
          break;
        } //COD_WITH_DRIVERS

      case Status.COD_RETURN:
        {
          if (controller.loadMoreCodReturn.value) return;
          if ((controller.listCodReturn.length <=
                  controller.totalCodReturn.value) &&
              scrollController!.position.extentAfter < 1000.0) {
            // bool isTop = scrollController!.position.pixels == 0;
            controller.loadMoreCodReturn.value = true;
            await controller.getCodReturnOrders();
            if (this.mounted)
              setState(() {
                subTitle = controller.listCodReturn.length.toString() +
                    "/" +
                    controller.totalCodReturn.toString();
              });
          }
          break;
        } //COD_RETURN

    } //switch
  }

  String subTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        body: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: GetX<FinanceListingController>(builder: (controller) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  // NoDataView(label: "No Data" + widget.type.toString()),
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
                              _refresh(type: widget.type);
                            },
                            child: widget.type == Status.ALL &&
                                    controller.inViewLoadingAll.value &&
                                    controller.listAll.isEmpty
                                ? WaiteImage()
                                : widget.type == Status.ALL &&
                                        controller.listAll.isEmpty
                                    ? NoDataView(label: "No Data")
                                    : widget.type == Status.COD_PENDING &&
                                            controller.inViewLoadingCodPending
                                                .value &&
                                            controller.listCodPending.isEmpty
                                        ? WaiteImage()
                                        : widget.type == Status.COD_PENDING &&
                                                controller
                                                    .listCodPending.isEmpty
                                            ? NoDataView(label: "No Data")
                                            : widget.type == Status.COD_RETURN &&
                                                    controller
                                                        .inViewLoadingCodReturn
                                                        .value &&
                                                    controller
                                                        .listCodReturn.isEmpty
                                                ? WaiteImage()
                                                : widget.type == Status.COD_RETURN &&
                                                        controller.listCodReturn
                                                            .isEmpty
                                                    ? NoDataView(
                                                        label: "No Data")
                                                    : widget.type == Status.COD_WITH_DRIVERS &&
                                                            controller
                                                                .inViewLoadingCodWithDrivers
                                                                .value &&
                                                            controller
                                                                .listCodWithDrivers
                                                                .isEmpty
                                                        ? WaiteImage()
                                                        : widget.type == Status.COD_WITH_DRIVERS &&
                                                                controller
                                                                    .listCodWithDrivers
                                                                    .isEmpty
                                                            ? NoDataView(
                                                                label:
                                                                    "No Data")
                                                            : widget.type == Status.PAID &&
                                                                    controller.inViewLoadingPaid.value &&
                                                                    controller.listPaid.isEmpty
                                                                ? WaiteImage()
                                                                : widget.type == Status.PAID && controller.listPaid.isEmpty
                                                                    ? NoDataView(label: "No Data")
                                                                    : widget.type == Status.READY_TO_PAY && controller.inViewLoadingReadyToPay.value && controller.listReadyToPay.isEmpty
                                                                        ? WaiteImage()
                                                                        : widget.type == Status.READY_TO_PAY && controller.listReadyToPay.isEmpty
                                                                            ? NoDataView(label: "No Data")
                                                                            : ListView.separated(
                                                                                // shrinkWrap: false,
                                                                                controller: scrollController,
                                                                                separatorBuilder: (context, i) => const SizedBox(height: 15),
                                                                                itemCount: widget.type == Status.ALL
                                                                                    ? controller.listAll.length
                                                                                    : widget.type == Status.PAID
                                                                                        ? controller.listPaid.length
                                                                                        : widget.type == Status.COD_PENDING
                                                                                            ? controller.listCodPending.length
                                                                                            : widget.type == Status.READY_TO_PAY
                                                                                                ? controller.listReadyToPay.length
                                                                                                : widget.type == Status.COD_WITH_DRIVERS
                                                                                                    ? controller.listCodWithDrivers.length
                                                                                                    : controller.listCodReturn.length,
                                                                                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
                                                                                itemBuilder: (context, i) {
                                                                                  return GetBuilder<FinanceListingController>(
                                                                                    builder: (x) => card(
                                                                                      controller,
                                                                                      widget.type == Status.ALL
                                                                                          ? controller.listAll[i]
                                                                                          : widget.type == Status.PAID
                                                                                              ? controller.listPaid[i]
                                                                                              : widget.type == Status.COD_PENDING
                                                                                                  ? controller.listCodPending[i]
                                                                                                  : widget.type == Status.READY_TO_PAY
                                                                                                      ? controller.listReadyToPay[i]
                                                                                                      : widget.type == Status.COD_WITH_DRIVERS
                                                                                                          ? controller.listCodWithDrivers[i]
                                                                                                          : controller.listCodReturn[i],
                                                                                      x,
                                                                                      dashboardController.trackingStatuses,
                                                                                    ),
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
    switch (widget.type) {
      case Status.ALL:
        {
          if (controller.loadMoreAll.value) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const bottomLoadingIndicator());
          } else
            return Text('');
        } //all

      case Status.PAID:
        {
          if (controller.loadMorePaid.value) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const bottomLoadingIndicator());
          } else
            return Text('');
        } //paid

      case Status.COD_PENDING:
        {
          if (controller.loadMoreCodPending.value) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const bottomLoadingIndicator());
          } else
            return Text('');
        } //cod pending
      case Status.READY_TO_PAY:
        {
          if (controller.loadMoreReadyToPay.value) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const bottomLoadingIndicator());
          } else
            return Text('');
        } //  ready to pay
      case Status.COD_WITH_DRIVERS:
        {
          if (controller.loadMoreCodWithDrivers.value) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const bottomLoadingIndicator());
          } else
            return Text('');
        } //cod reaturn
      case Status.COD_RETURN:
        {
          if (controller.loadMoreCodReturn.value) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const bottomLoadingIndicator());
          } else
            return Text('');
        } //cod reaturn
      default:
        {
          return Text('');
        }
    }
  }

  CardBody card(
    FinanceListingController controller,
    Shipment shipment,
    FinanceListingController x,
    List<TrackingStatus> trackingStatus,
  ) {
    return CardBody(
      willaya: shipment.wilayaName,
      area: shipment.areaName,
      orderId: shipment.orderId ?? 00,
      date: shipment.updatedAt,
      customer_name: shipment.customerName,
      Order_current_Status: shipment.orderStatusName,
      number: shipment.phone ?? "+968",
      orderNumber: shipment.orderNo.toString(),
      cod: shipment.cod ?? "0.00",
      cop: shipment.cop ?? "0.00",
      shipmentCost: shipment.shippingPrice ?? "0.00",
      deleiver_image: shipment.orderDeliverImage ?? "",
      undeleiver_image: shipment.orderUndeliverImage ?? "",
      pickup_image: shipment.orderPickupImage ?? "",
      totalCharges:
          '${(double.tryParse(shipment.cod.toString()) ?? 0.0) - (double.tryParse(shipment.shippingPrice.toString()) ?? 0.0)}',
      stutaus: shipment.orderActivities,
      icon: trackingStatus.map((element) => element.icon.toString()).toList(),
      status_key: shipment.orderStatusKey,
      ref: shipment.refId ?? 0,
      weight: shipment.weight ?? 0.00,
      currentStep: shipment.currentStatus ?? 1,
      isOpen: shipment.isOpen,
      onPressedShowMore: () {
        if (shipment.isOpen == false) {
          controller.listAll.forEach((element) => element.isOpen = false);
          shipment.isOpen = !shipment.isOpen;
          x.update();
        } else {
          print('-------------');
          shipment.isOpen = false;
          x.update();
        }
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: widget.title + ' ($subTitle)',
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
