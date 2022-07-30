import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/core/view_model/view_order_view_model.dart';
import 'package:dalile_customer/view/home/card_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewOrderView extends StatelessWidget {
  ViewOrderView({Key? key}) : super(key: key);
  final ViewOrderController controller =
      Get.put(ViewOrderController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        body: Container(
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: Center(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const WaiteImage();
              }
              if (controller.viewOrderData.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const EmptyState(
                      label: 'no Data ',
                    ),
                    MaterialButton(
                      onPressed: () {
                        controller.fetchViewOrderData();
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
              }
              return Column(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        controller.fetchViewOrderData();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CustomText(
                            text: 'Updated data ',
                            color: Colors.grey,
                            alignment: Alignment.center,
                            size: 10,
                          ),
                          Icon(
                            Icons.refresh,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: ListView.separated(
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                      itemCount: controller.viewOrderData.length,
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10, top: 5),
                      itemBuilder: (context, i) {
                        return GetBuilder<ShipmentViewModel>(
                            init: ShipmentViewModel(),
                            builder: (x) {
                              return CardBody(
                                orderId:
                                    controller.viewOrderData[i].orderId ?? "00",
                                number:
                                    controller.viewOrderData[i].phone ?? "+968",
                                cod: controller.viewOrderData[i].cod ?? "0.00",
                                cop: controller.viewOrderData[i].cop ?? "0.00",
                                shipmentCost:
                                    controller.viewOrderData[i].shippingPrice ??
                                        "0.00",
                                totalCharges:
                                    '${double.parse(controller.viewOrderData[i].shippingPrice.toString()) + double.parse(controller.viewOrderData[i].cod.toString())}',
                                stutaus:
                                    controller.viewOrderData[i].orderActivities,
                                icon: controller.viewOrderList
                                    .map((element) => element.icon.toString())
                                    .toList(),
                                ref: controller.viewOrderData[i].refId ?? "0",
                                weight:
                                    controller.viewOrderData[i].weight ??"0.00",
                                currentStep:
                                    controller.viewOrderData[i].currentStatus ??
                                        1,
                                isOpen: controller.viewOrderData[i].isOpen,
                                onPressedShowMore: () {
                                  controller.viewOrderData[i].isOpen =
                                      !controller.viewOrderData[i].isOpen;
                                  x.update();
                                  print(controller.viewOrderData[i].isOpen
                                      .toString());
                                },
                              );
                            });
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: const CustomText(
          text: 'View Orders',
          color: whiteColor,
          size: 18,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
