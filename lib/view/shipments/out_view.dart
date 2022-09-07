import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dalile_customer/view/widget/empty.dart';

class InShipments extends StatefulWidget {
  InShipments({Key? key}) : super(key: key);

  @override
  State<InShipments> createState() => _InShipmentsState();
}

class _InShipmentsState extends State<InShipments> {
  final controller = Get.put(ShipmentViewModel(), permanent: true);
  @override
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingIN.value) {
        return const WaiteImage();
      }
      if (controller.inList.isNotEmpty) {
        return Column(
          children: [
            SizedBox(
              height: 35,
              child: MaterialButton(
                onPressed: () {
                  controller.fetchShipemetData(isRefresh: true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CustomText(
                      text: 'Updated data ',
                      color: Colors.grey,
                      alignment: Alignment.center,
                      size: 11,
                    ),
                    Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: MyInput(
                keyboardType: TextInputType.number,
                hintText: 'Enter Shipment Number',
                onChanged: controller.onSearchTextChanged,
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
            SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 12,
              child: controller.searchResult.isNotEmpty
                  ? GetX<ShipmentViewModel>(builder: (_controller) {
                      return ListView.separated(
                        controller: controller.controller,
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 15),
                        itemCount: controller.searchResult.length,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10, top: 5),
                        itemBuilder: (context, i) {
                          return GetBuilder<ShipmentViewModel>(
                            builder: (x) => CardBody(
                              customer_name:
                                  controller.searchResult[i]!.customerName,
                              deleiver_image:
                                  controller.searchResult[i]!.orderDeliverImage,
                              undeleiver_image: controller
                                  .searchResult[i]!.orderUndeliverImage,
                              pickup_image:
                                  controller.searchResult[i]!.orderPickupImage,
                              orderId:
                                  controller.searchResult[i]!.orderId ?? "00",
                              number:
                                  controller.searchResult[i]!.phone ?? "+968",
                              cod: controller.searchResult[i]!.cod ?? "0.00",
                              cop: controller.searchResult[i]!.cop ?? "0.00",
                              orderNumber: controller.searchResult[i]!.orderNo,
                              shipmentCost:
                                  controller.searchResult[i]!.shippingPrice ??
                                      "0.00",
                              totalCharges:
                                  '${double.parse(controller.searchResult[i]!.shippingPrice.toString()) + double.parse(controller.searchResult[i]!.cod.toString())}',
                              stutaus:
                                  controller.searchResult[i]!.orderActivities,
                              status_key:
                                  controller.searchResult[i]!.orderStatusKey,
                              Order_current_Status:
                                  controller.searchResult[i]!.orderStatusName,
                              icon: controller.shipList
                                  .map((element) => element.icon.toString())
                                  .toList(),
                              ref: controller.searchResult[i]!.refId ?? "0",
                              weight:
                                  controller.searchResult[i]!.weight ?? "0.00",
                              currentStep:
                                  controller.searchResult[i]!.currentStatus ??
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
                      );
                    })
                  : controller.searchResult.isEmpty &&
                          controller.searchConter.text.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const EmptyState(
                              label: 'no Data ',
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller.fetchShipemetData();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CustomText(
                                    text: 'Updated data ',
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
                          controller: controller.controller,
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 15),
                          itemCount: controller.inList.length,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10, top: 5),
                          itemBuilder: (context, i) {
                            return GetBuilder<ShipmentViewModel>(
                              builder: (x) => CardBody(
                                customer_name:
                                    controller.inList[i]!.customerName,
                                deleiver_image:
                                    controller.inList[i]!.orderDeliverImage,
                                undeleiver_image:
                                    controller.inList[i]!.orderUndeliverImage,
                                pickup_image:
                                    controller.inList[i]!.orderPickupImage,
                                orderId: controller.inList[i]!.orderId ?? "00",
                                number: controller.inList[i]!.phone ?? "+968",
                                cod: controller.inList[i]!.cod ?? "0.00",
                                cop: controller.inList[i]!.cop ?? "0.00",
                                shipmentCost:
                                    controller.inList[i]!.shippingPrice ??
                                        "0.00",
                                totalCharges:
                                    '${double.parse(controller.inList[i]!.shippingPrice.toString()) + double.parse(controller.inList[i]!.cod.toString())}',
                                stutaus: controller.inList[i]!.orderActivities,
                                orderNumber: controller.inList[i]!.orderNo,
                                icon: controller.shipList
                                    .map((element) => element.icon.toString())
                                    .toList(),
                                ref: controller.inList[i]!.refId ?? "0",
                                weight: controller.inList[i]!.weight ?? "0.00",
                                status_key:
                                    controller.inList[i]!.orderStatusKey,
                                Order_current_Status:
                                    controller.inList[i]!.orderStatusName,
                                currentStep:
                                    controller.inList[i]!.currentStatus ?? 1,
                                isOpen: controller.inList[i]!.isOpen,
                                onPressedShowMore: () {
                                  log(controller.inList[i]!.isOpen.toString());
                                  if (controller.inList[i]!.isOpen == false) {
                                    controller.inList.forEach(
                                        (element) => element!.isOpen = false);
                                    controller.inList[i]!.isOpen =
                                        !controller.inList[i]!.isOpen;
                                    x.update();
                                  } else {
                                    print('-------------');
                                    controller.inList[i]!.isOpen = false;
                                    x.update();
                                  }

                                  print(
                                      controller.inList[i]!.isOpen.toString());
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptyState(
            label: 'no Data',
          ),
          MaterialButton(
            onPressed: () {
              controller.fetchShipemetData(isRefresh: true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                CustomText(
                  text: 'Updated data ',
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

class OutShipments extends StatelessWidget {
  OutShipments({Key? key}) : super(key: key);

  final controller = Get.put(ShipmentViewModel(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingOut.value) {
        print("object----> ${controller.outList.length}");
        return const WaiteImage();
      }

      if (controller.outList.isNotEmpty) {
        return Column(
          children: [
            SizedBox(
              height: 35,
              child: MaterialButton(
                onPressed: () {
                  controller.fetchOutShipemetData(isRefresh: true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CustomText(
                      text: 'Updated data',
                      color: Colors.grey,
                      alignment: Alignment.center,
                      size: 11,
                    ),
                    Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: MyInput(
                keyboardType: TextInputType.number,
                hintText: 'Enter Shipment Number',
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
            const SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 12,
              child: controller.searchResult.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                      itemCount: controller.searchResult.length,
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10, top: 5),
                      itemBuilder: (context, i) {
                        return GetBuilder<ShipmentViewModel>(
                          builder: (x) => CardBody(
                            customer_name:
                                controller.searchResult[i]!.customerName,
                            deleiver_image:
                                controller.searchResult[i]!.orderDeliverImage,
                            undeleiver_image:
                                controller.searchResult[i]!.orderUndeliverImage,
                            pickup_image:
                                controller.searchResult[i]!.orderPickupImage,
                            orderId:
                                controller.searchResult[i]!.orderId ?? "00",
                            number: controller.searchResult[i]!.phone ?? "+968",
                            cod: controller.searchResult[i]!.cod ?? "0.00",
                            orderNumber: controller.searchResult[i]!.orderNo,
                            cop: controller.searchResult[i]!.cop ?? "0.00",
                            shipmentCost:
                                controller.searchResult[i]!.shippingPrice ??
                                    "0.00",
                            totalCharges:
                                '${double.parse(controller.searchResult[i]!.shippingPrice.toString()) + double.parse(controller.searchResult[i]!.cod.toString())}',
                            stutaus:
                                controller.searchResult[i]!.orderActivities,
                            icon: controller.outshipList
                                .map((element) => element.icon.toString())
                                .toList(),
                            ref: controller.searchResult[i]!.refId ?? "0",
                            status_key:
                                controller.searchResult[i]!.orderStatusKey,
                            Order_current_Status:
                                controller.searchResult[i]!.orderStatusName,
                            weight:
                                controller.searchResult[i]!.weight ?? "0.00",
                            currentStep:
                                controller.searchResult[i]!.currentStatus ?? 1,
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
                            const EmptyState(
                              label: 'no Data ',
                            ),
                            MaterialButton(
                              onPressed: () {
                                controller.fetchOutShipemetData();
                                print('ok');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CustomText(
                                    text: 'Updated data ',
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
                          controller: controller.controller,
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 15),
                          itemCount: controller.outList.length,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10, top: 5),
                          itemBuilder: (context, i) {
                            return GetBuilder<ShipmentViewModel>(
                              builder: (x) => CardBody(
                                customer_name:
                                    controller.outList[i]!.customerName,
                                deleiver_image:
                                    controller.outList[i]!.orderDeliverImage,
                                undeleiver_image:
                                    controller.outList[i]!.orderUndeliverImage,
                                pickup_image:
                                    controller.outList[i]!.orderPickupImage,
                                orderId: controller.outList[i]!.orderId ?? "00",
                                number: controller.outList[i]!.phone ?? "+968",
                                cod: controller.outList[i]!.cod ?? "0.00",
                                cop: controller.outList[i]!.cop ?? "0.00",
                                orderNumber: controller.outList[i]!.orderNo,
                                shipmentCost:
                                    controller.outList[i]!.shippingPrice ??
                                        "0.00",
                                totalCharges:
                                    '${double.parse(controller.outList[i]!.shippingPrice.toString()) + double.parse(controller.outList[i]!.cod.toString())}',
                                stutaus: controller.outList[i]!.orderActivities,
                                icon: controller.outshipList
                                    .map((element) => element.icon.toString())
                                    .toList(),
                                ref: controller.outList[i]!.refId ?? "0",
                                weight: controller.outList[i]!.weight ?? "0.00",
                                status_key:
                                    controller.outList[i]!.orderStatusKey,
                                Order_current_Status:
                                    controller.outList[i]!.orderStatusName,
                                currentStep:
                                    controller.outList[i]!.currentStatus ?? 1,
                                isOpen: controller.outList[i]!.isOpen,
                                onPressedShowMore: () {
                                  if (controller.outList[i]!.isOpen == false) {
                                    controller.outList.forEach(
                                        (element) => element!.isOpen = false);
                                    controller.outList[i]!.isOpen =
                                        !controller.outList[i]!.isOpen;
                                    x.update();
                                  } else {
                                    controller.outList[i]!.isOpen = false;
                                    x.update();
                                  }
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptyState(
            label: 'no Data ',
          ),
          MaterialButton(
            onPressed: () {
              controller.fetchOutShipemetData();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                CustomText(
                  text: 'Updated data ',
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
