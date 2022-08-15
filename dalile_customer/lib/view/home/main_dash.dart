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

class MainDash extends StatelessWidget {
  MainDash({Key? key, required this.controller}) : super(key: key);
  final DashbordController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Obx(
        () => Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.isLoading.value
                  ? WaiteImage()
                  : MaterialButton(
                      onPressed: () {
                        controller.fetchAllShipemetData();
                        controller.fetchDeliverShipemetData();
                        controller.fetchRetrunShipemetData();
                        controller.fetchcancellShipemetData();
                        controller.fetchToBeDeliveredShipemetData();
                        controller.fetchToBePickupData();
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
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Get.to(
                      () => controller.allShipemet.isEmpty
                          ? MainCardBodyView(
                              controller: EmptyState(
                                label: 'No data',
                              ),
                              title: "Shipmenet")
                          : MainCardBodyView(
                              title: 'All Shipmenet',
                              controller: ListView.separated(
                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 15),
                                itemCount: controller.allShipemet.length,
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10, top: 5),
                                itemBuilder: (context, i) {
                                  return GetBuilder<DashbordController>(
                                    builder: (x) => CardBody(
                                      orderId:
                                          controller.allShipemet[i].orderId ??
                                              00,
                                      number: controller.allShipemet[i].phone ??
                                          "+968",
                                      cod: controller.allShipemet[i].cod ??
                                          "0.00",
                                      cop: controller.allShipemet[i].cop ??
                                          "0.00",
                                      shipmentCost: controller
                                              .allShipemet[i].shippingPrice ??
                                          "0.00",
                                      orderNumber:
                                          controller.allShipemet[i].orderNo,
                                      totalCharges:
                                          '${double.parse(controller.allShipemet[i].shippingPrice.toString()) + double.parse(controller.allShipemet[i].cod.toString())}',
                                      stutaus: controller
                                          .allShipemet[i].orderActivities,
                                      icon: controller.allList
                                          .map((element) =>
                                              element.icon.toString())
                                          .toList(),
                                      ref: controller.allShipemet[i].refId ?? 0,
                                      weight:
                                          controller.allShipemet[i].weight ??
                                              0.00,
                                      currentStep: controller
                                              .allShipemet[i].currentStatus ??
                                          1,
                                      isOpen: controller.allShipemet[i].isOpen,
                                      onPressedShowMore: () {
                                        if (controller.allShipemet[i].isOpen ==
                                            false) {
                                          controller.allShipemet.forEach(
                                              (element) =>
                                                  element.isOpen = false);
                                          controller.allShipemet[i].isOpen =
                                              !controller.allShipemet[i].isOpen;
                                          x.update();
                                        } else {
                                          print('-------------');
                                          controller.allShipemet[i].isOpen =
                                              false;
                                          x.update();
                                        }

                                        print(controller.allShipemet[i].isOpen
                                            .toString());
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 400));
                },
                child: buildCard(
                    context,
                    _InsideShape(
                      image: 'assets/images/allshipment.png',
                      title: 'All Shipments',
                      numbers: '${controller.allShipmentNumber.value}',
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
                            () => controller.deliverShipemet.isEmpty
                                ? MainCardBodyView(
                                    controller: EmptyState(
                                      label: 'No data',
                                    ),
                                    title: "Delivered Shipmenet")
                                : MainCardBodyView(
                                    title: 'Delivered Shipmenet',
                                    controller: ListView.separated(
                                      separatorBuilder: (context, i) =>
                                          const SizedBox(height: 15),
                                      itemCount:
                                          controller.deliverShipemet.length,
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                          top: 5),
                                      itemBuilder: (context, i) {
                                        return GetBuilder<DashbordController>(
                                          builder: (x) => CardBody(
                                            orderId: controller
                                                    .deliverShipemet[i]
                                                    .orderId ??
                                                00,
                                            number: controller
                                                    .deliverShipemet[i].phone ??
                                                "+968",
                                            cod: controller
                                                    .deliverShipemet[i].cod ??
                                                "0.00",
                                            cop: controller
                                                    .deliverShipemet[i].cop ??
                                                "0.00",
                                            shipmentCost: controller
                                                    .deliverShipemet[i]
                                                    .shippingPrice ??
                                                "0.00",
                                            totalCharges:
                                                '${double.parse(controller.deliverShipemet[i].shippingPrice.toString()) + double.parse(controller.deliverShipemet[i].cod.toString())}',
                                            stutaus: controller
                                                .deliverShipemet[i]
                                                .orderActivities,
                                            icon: controller.deliverList
                                                .map((element) =>
                                                    element.icon.toString())
                                                .toList(),
                                            ref: controller
                                                    .deliverShipemet[i].refId ??
                                                0,
                                            weight: controller
                                                    .deliverShipemet[i]
                                                    .weight ??
                                                0.00,
                                            currentStep: controller
                                                    .deliverShipemet[i]
                                                    .currentStatus ??
                                                1,
                                            isOpen: controller
                                                .deliverShipemet[i].isOpen,
                                            onPressedShowMore: () {
                                              if (controller.deliverShipemet[i]
                                                      .isOpen ==
                                                  false) {
                                                controller.deliverShipemet
                                                    .forEach((element) =>
                                                        element.isOpen = false);
                                                controller.deliverShipemet[i]
                                                        .isOpen =
                                                    !controller
                                                        .deliverShipemet[i]
                                                        .isOpen;
                                                x.update();
                                              } else {
                                                print('-------------');
                                                controller.deliverShipemet[i]
                                                    .isOpen = false;
                                                x.update();
                                              }

                                              print(controller
                                                  .deliverShipemet[i].isOpen
                                                  .toString());
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/delivered.png',
                        title: 'Delivered\nShipments',
                        numbers: '${controller.deliverShipmentNumber.value}',
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
                            () => controller.tobePickup.isEmpty
                                ? MainCardBodyView(
                                    controller: EmptyState(
                                      label: 'No data',
                                    ),
                                    title: "To Be Pickup")
                                : MainCardBodyView(
                                    title: "To Be Pickup",
                                    controller: ListView.separated(
                                      separatorBuilder: (context, i) =>
                                          const SizedBox(height: 15),
                                      itemCount: controller.tobePickup.length,
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                          top: 5),
                                      itemBuilder: (context, i) {
                                        return AllPickupBody(
                                          cod:
                                              "${controller.tobePickup[i].cop ?? 0}",
                                          name:
                                              "${controller.tobePickup[i].driver ?? "undefined"}",
                                          qty:
                                              "${controller.tobePickup[i].quantity ?? 0}",
                                          date:
                                              "${controller.tobePickup[i].date ?? "dd-mm-yyyy"}",
                                          id: "${controller.tobePickup[i].id ?? 00}",
                                          onPressed: () {
                                            // controllerClass.makePhoneCall(
                                            //     "${controllerClass.allPickup[i]!.driveMobile}");
                                          },
                                          status:
                                              controller.tobePickup[i].status ??
                                                  '',
                                        );
                                      },
                                    ),
                                  ),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/tobepickup.png',
                        title: 'To Be\nPickup',
                        numbers: ' ${controller.toBePickupNumber}',
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
                            () => controller.tobeDelShipemet.isEmpty
                                ? MainCardBodyView(
                                    controller: EmptyState(
                                      label: 'No data',
                                    ),
                                    title: "To Be Delivered")
                                : MainCardBodyView(
                                    title: 'To Be Deliver',
                                    controller: ListView.separated(
                                      separatorBuilder: (context, i) =>
                                          const SizedBox(height: 15),
                                      itemCount:
                                          controller.tobeDelShipemet.length,
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                          top: 5),
                                      itemBuilder: (context, i) {
                                        return GetBuilder<DashbordController>(
                                          builder: (x) => CardBody(
                                            orderId: controller
                                                    .tobeDelShipemet[i]
                                                    .orderId ??
                                                00,
                                            number: controller
                                                    .tobeDelShipemet[i].phone ??
                                                "+968",
                                            cod: controller
                                                    .tobeDelShipemet[i].cod ??
                                                "0.00",
                                            cop: controller
                                                    .tobeDelShipemet[i].cop ??
                                                "0.00",
                                            shipmentCost: controller
                                                    .tobeDelShipemet[i]
                                                    .shippingPrice ??
                                                "0.00",
                                            totalCharges:
                                                '${double.parse(controller.tobeDelShipemet[i].shippingPrice.toString()) + double.parse(controller.tobeDelShipemet[i].cod.toString())}',
                                            stutaus: controller
                                                .tobeDelShipemet[i]
                                                .orderActivities,
                                            icon: controller.toBeDelvList
                                                .map((element) =>
                                                    element.icon.toString())
                                                .toList(),
                                            ref: controller
                                                    .tobeDelShipemet[i].refId ??
                                                0,
                                            weight: controller
                                                    .tobeDelShipemet[i]
                                                    .weight ??
                                                0.00,
                                            currentStep: controller
                                                    .tobeDelShipemet[i]
                                                    .currentStatus ??
                                                1,
                                            isOpen: controller
                                                .tobeDelShipemet[i].isOpen,
                                            onPressedShowMore: () {
                                              if (controller.tobeDelShipemet[i]
                                                      .isOpen ==
                                                  false) {
                                                controller.tobeDelShipemet
                                                    .forEach((element) =>
                                                        element.isOpen = false);
                                                controller.tobeDelShipemet[i]
                                                        .isOpen =
                                                    !controller
                                                        .tobeDelShipemet[i]
                                                        .isOpen;
                                                x.update();
                                              } else {
                                                print('-------------');
                                                controller.tobeDelShipemet[i]
                                                    .isOpen = false;
                                                x.update();
                                              }

                                              print(controller
                                                  .tobeDelShipemet[i].isOpen
                                                  .toString());
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/tobedelivered.png',
                        title: 'To Be\nDelivered',
                        numbers: '${controller.toBeDelShipmentNumber.value}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _buildsmallbox(
                    InkWell(
                      onTap: () {
                        controller.returnShipemet.isEmpty
                            ? Get.to(() => MainCardBodyView(
                                controller: EmptyState(
                                  label: 'No data',
                                ),
                                title: "Return Shipmenet"))
                            : Get.to(
                                () => MainCardBodyView(
                                      title: 'Return Shipmenet',
                                      controller: ListView.separated(
                                        separatorBuilder: (context, i) =>
                                            const SizedBox(height: 15),
                                        itemCount:
                                            controller.returnShipemet.length,
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            bottom: 10,
                                            top: 5),
                                        itemBuilder: (context, i) {
                                          return GetBuilder<DashbordController>(
                                            builder: (x) => CardBody(
                                              orderId: controller
                                                      .returnShipemet[i]
                                                      .orderId ??
                                                  00,
                                              number: controller
                                                      .returnShipemet[i]
                                                      .phone ??
                                                  "+968",
                                              cod: controller
                                                      .returnShipemet[i].cod ??
                                                  "0.00",
                                              cop: controller
                                                      .returnShipemet[i].cop ??
                                                  "0.00",
                                              shipmentCost: controller
                                                      .returnShipemet[i]
                                                      .shippingPrice ??
                                                  "0.00",
                                              totalCharges:
                                                  '${double.parse(controller.returnShipemet[i].shippingPrice.toString()) + double.parse(controller.returnShipemet[i].cod.toString())}',
                                              stutaus: controller
                                                  .returnShipemet[i]
                                                  .orderActivities,
                                              icon: controller.returnList
                                                  .map((element) =>
                                                      element.icon.toString())
                                                  .toList(),
                                              ref: controller.returnShipemet[i]
                                                      .refId ??
                                                  0,
                                              weight: controller
                                                      .returnShipemet[i]
                                                      .weight ??
                                                  0.00,
                                              currentStep: controller
                                                      .returnShipemet[i]
                                                      .currentStatus ??
                                                  1,
                                              isOpen: controller
                                                  .returnShipemet[i].isOpen,
                                              onPressedShowMore: () {
                                                if (controller.returnShipemet[i]
                                                        .isOpen ==
                                                    false) {
                                                  controller.returnShipemet
                                                      .forEach((element) =>
                                                          element.isOpen =
                                                              false);
                                                  controller.returnShipemet[i]
                                                          .isOpen =
                                                      !controller
                                                          .returnShipemet[i]
                                                          .isOpen;
                                                  x.update();
                                                } else {
                                                  print('-------------');
                                                  controller.returnShipemet[i]
                                                      .isOpen = false;
                                                  x.update();
                                                }

                                                print(controller
                                                    .returnShipemet[i].isOpen
                                                    .toString());
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 400));
                      },
                      child: _InsideSmallBox(
                        image: 'assets/images/returnshipment.png',
                        title: 'Returned\nShipments',
                        numbers: '${controller.returnShipmentNumber.value}',
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
                      controller.cancellShipemet.isEmpty
                          ? Get.to(() => MainCardBodyView(
                              controller: EmptyState(
                                label: 'No data',
                              ),
                              title: "Cancell Shipmenet"))
                          : Get.to(
                              () => MainCardBodyView(
                                    title: 'Cancell Shipmenet',
                                    controller: ListView.separated(
                                      separatorBuilder: (context, i) =>
                                          const SizedBox(height: 15),
                                      itemCount:
                                          controller.cancellShipemet.length,
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                          top: 5),
                                      itemBuilder: (context, i) {
                                        return GetBuilder<DashbordController>(
                                          builder: (x) => CardBody(
                                            orderId: controller
                                                    .cancellShipemet[i]
                                                    .orderId ??
                                                "00",
                                            number: controller
                                                    .cancellShipemet[i].phone ??
                                                "+968",
                                            cod: controller
                                                    .cancellShipemet[i].cod ??
                                                "0.00",
                                            cop: controller
                                                    .cancellShipemet[i].cop ??
                                                "0.00",
                                            shipmentCost: controller
                                                    .cancellShipemet[i]
                                                    .shippingPrice ??
                                                "0.00",
                                            totalCharges:
                                                '${double.parse(controller.cancellShipemet[i].shippingPrice.toString()) + double.parse(controller.cancellShipemet[i].cod.toString())}',
                                            stutaus: controller
                                                .cancellShipemet[i]
                                                .orderActivities,
                                            icon: controller.cancellList
                                                .map((element) =>
                                                    element.icon.toString())
                                                .toList(),
                                            ref: controller
                                                    .cancellShipemet[i].refId ??
                                                0,
                                            weight: controller
                                                    .cancellShipemet[i]
                                                    .weight ??
                                                0.00,
                                            currentStep: controller
                                                    .cancellShipemet[i]
                                                    .currentStatus ??
                                                1,
                                            isOpen: controller
                                                .cancellShipemet[i].isOpen,
                                            onPressedShowMore: () {
                                              if (controller.cancellShipemet[i]
                                                      .isOpen ==
                                                  false) {
                                                controller.cancellShipemet
                                                    .forEach((element) =>
                                                        element.isOpen = false);
                                                controller.cancellShipemet[i]
                                                        .isOpen =
                                                    !controller
                                                        .cancellShipemet[i]
                                                        .isOpen;
                                                x.update();
                                              } else {
                                                print('-------------');
                                                controller.cancellShipemet[i]
                                                    .isOpen = false;
                                                x.update();
                                              }

                                              print(controller
                                                  .cancellShipemet[i].isOpen
                                                  .toString());
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              transition: Transition.downToUp,
                              duration: const Duration(milliseconds: 400));
                    },
                    child: _InsideShape(
                      image: 'assets/images/cancell.png',
                      title: 'Cancelled Shipments',
                      numbers: '${controller.cancellShipmentNumber.value}',
                    ),
                  ),
                  0.0,
                  0.0,
                  15.0,
                  15.0),
            ]),
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
