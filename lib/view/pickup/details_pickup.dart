import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/card_body_new_log.dart';

class PickupDetails extends StatelessWidget {
  PickupDetails({Key? key, required this.ref, required this.date})
      : super(key: key);
  final String ref, date;
  final controller = Get.put(PickupController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: CustomText(
            text: 'DetailsPickup'.tr,
            color: whiteColor,
            size: 20,
            fontWeight: FontWeight.w500,
            alignment: Alignment.center,
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: 25,
                left: 2,
                right: 2,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: 'Ref'.tr + ' : $ref',
                      size: Get.locale.toString() == "ar" ? 12 : 15,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: 'Date'.tr + ' : $date',
                      size: Get.locale.toString() == "ar" ? 12 : 15,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Divider(),
                Obx(() {
                  if (controller.isLoadingDetails.value) return WaiteImage();
                  return controller.pickupShipments.isEmpty
                      ? Expanded(
                          child:
                              Center(child: new NoDataView(label: "NoData".tr)))
                      : Expanded(
                          child: ListView.builder(
                              itemCount: controller.pickupShipments.length,
                              itemBuilder: (_, i) =>
                                  GetBuilder<PickupController>(
                                    builder: (x) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: card(
                                          controller,
                                          controller.pickupShipments[i],
                                          controller,
                                          Get.put(DashbordController())
                                              .trackingStatuses),
                                    ),
                                  )));
                })
              ]),
            ),
          ),
        ]));
  }

  CardBody card(
    PickupController controller,
    Shipment shipment,
    PickupController x,
    List<TrackingStatus> trackingStatus,
  ) {
    return CardBody(
      shipment: shipment,
      willaya: shipment.wilayaName,
      area: shipment.areaName,
      orderId: shipment.orderId,
      date: shipment.updatedAt,
      customer_name: shipment.customerName,
      Order_current_Status: shipment.orderStatusName,
      number: shipment.customerNo,
      orderNumber: shipment.orderId,
      cod: shipment.cod ?? "0.00",
      cop: shipment.cop ?? "0.00",
      shipmentCost: shipment.shippingPrice ?? "0.00",
      deleiver_image: shipment.orderImage,
      undeleiver_image: shipment.undeliverImage,
      pickup_image: shipment.pickupImage,
      totalCharges:
          '${(double.tryParse(shipment.cod.toString()) ?? 0.0) - (double.tryParse(shipment.shippingPrice.toString()) ?? 0.0)}',
      stutaus: shipment.orderActivities,
      icon: trackingStatus.map((element) => element.icon.toString()).toList(),
      status_key: shipment.orderStatusKey,
      ref: shipment.refId,
      weight: shipment.weight,
      currentStep: shipment.trackingId,
      isOpen: shipment.isOpen,
      onPressedShowMore: () {
        if (shipment.isOpen == false) {
          controller.pickupShipments
              .forEach((element) => element.isOpen = false);
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
}
