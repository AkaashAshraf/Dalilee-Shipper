import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/components/popups/ImagesViewModal.dart';
import 'package:dalile_customer/components/popups/ProblemViewModal.dart';
import 'package:dalile_customer/components/popups/edit_order_model.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/complain_view_model.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/menu/dispatcher/EditOrder.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/stepess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CardBody extends StatelessWidget {
  CardBody(
      {Key? key,
      this.cod,
      this.cop,
      this.icon,
      this.number,
      this.orderId,
      this.ref,
      this.shipmentCost,
      this.stutaus,
      this.totalCharges,
      this.weight,
      required this.area,
      required this.willaya,
      required this.date,
      required this.Order_current_Status,
      required this.deleiver_image,
      required this.pickup_image,
      required this.undeleiver_image,
      this.cc: "0",
      required this.status_key,
      required this.customer_name,
      this.orderNumber,
      this.isMyOrder: false,
      required this.currentStep,
      required this.onPressedShowMore,
      required this.shipment,
      required this.isOpen})
      : super(key: key);

  final dynamic orderId,
      ref,
      number,
      cop,
      status_key,
      weight,
      orderNumber,
      shipmentCost,
      totalCharges,
      Order_current_Status,
      deleiver_image,
      undeleiver_image,
      pickup_image,
      cc,
      customer_name,
      date,
      cod,
      willaya,
      isMyOrder,
      area;

  final List<dynamic>? stutaus;
  final Shipment shipment;
  final int currentStep;
  final bool isOpen;
  final List<String>? icon;
  final void Function()? onPressedShowMore;

  @override
  Widget build(BuildContext context) {
    List<OrderImages> images = [];
    if (pickup_image != "")
      images.add(OrderImages(pickup_image, 'Pickup Image'));
    if (deleiver_image != "")
      images.add(OrderImages(deleiver_image, 'Delivered Image'));
    if (undeleiver_image != "")
      images.add(OrderImages(undeleiver_image, 'Undelivered Image'));

    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: primaryColor.withOpacity(0.15),
              offset: Offset(0.0, 4.0),
            ),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '$orderNumber',
                  color: primaryColor,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    if (!isMyOrder)
                      InkWell(
                        onTap: () {
                          Get.put(ShipmentViewModel())
                              .callAlert(context, number ?? "123");
                        },
                        child: const Icon(
                          Icons.call_outlined,
                          color: primaryColor,
                          size: 25,
                        ),
                      ),
                    // else
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(EditOrder(
                    //       order: new Order(),
                    //     ));
                    //   },
                    //   child: const Icon(
                    //     Icons.edit,
                    //     color: primaryColor,
                    //     size: 25,
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (!isMyOrder)
                      InkWell(
                        onTap: () {
                          if (shipment.isProblem)
                            problemViewModal(context, images, orderNumber,
                                    shipment: shipment)
                                .show();
                          else
                            imagesViewModal(
                              context,
                              images,
                              orderNumber,
                            ).show();
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          color: shipment.isProblem == true
                              ? Colors.red
                              : primaryColor,
                          size: 25,
                        ),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.put(ComplainController()).fetchTypeComplainData();

                        await Get.put(ShipmentViewModel()).menuAlert(
                          context,
                          number ?? "000",
                          orderId ?? "2574953",
                          deleiver_image,
                          undeleiver_image,
                          pickup_image,
                        );
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: primaryColor,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 3,
            indent: 0,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRowText('Ref'.tr + ' : $ref', 'Phone'.tr + ' : $number'),
                _buildRowText('CC'.tr + ' : $cc OMR', 'Date'.tr + ' : $date '),
              ],
            ),
          ),
          if (willaya != "")
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8),
              child: CustomText(
                text: "Address: $willaya $area",
                fontWeight: FontWeight.w400,
                color: text1Color,
              ),
            ),
          if (customer_name != "")
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          _rowWithnameline(
              Order_current_Status ?? "",
              status_key == 'return'
                  ? Colors.red
                  : status_key == 'F' || status_key == "FW"
                      ? Colors.orange
                      : status_key == 'completed'
                          ? Colors.green
                          : primaryColor),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 12,
              top: 10,
            ),
            child: StepProgressView(
              icons: icon ??
                  [
                    "https://shaheen-oman.dalilee.om/storage/order-icons/pickup.png",
                    "https://shaheen-oman.dalilee.om/storage/order-icons/send.png",
                    "https://shaheen-oman.dalilee.om/storage/order-icons/received.png",
                    "https://shaheen-oman.dalilee.om/storage/order-icons/assigned.png",
                    "https://shaheen-oman.dalilee.om/storage/order-icons/process.png",
                    "https://shaheen-oman.dalilee.om/storage/order-icons/un-delivered.png",
                    "https://shaheen-oman.dalilee.om/storage/order-icons/delivered.png"
                  ],
              curStep: currentStep > 0 ? currentStep : 1,
              color: primaryColor,
            ),
          ),
          if (isOpen) _buildPayment(context),
          MaterialButton(
            onPressed: onPressedShowMore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: isOpen ? "HideDetails".tr : 'ShowMoreDetails'.tr,
                  color: textRedColor,
                  size: 11,
                  alignment: Alignment.centerRight,
                ),
                const SizedBox(
                  width: 5,
                ),
                isOpen
                    ? Transform.rotate(
                        angle: 3.14,
                        child: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: textRedColor,
                          size: 15,
                        ),
                      )
                    : Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: textRedColor,
                        size: 15,
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPayment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: InkWell(
        onTap: onPressedShowMore,
        child: Column(
          children: [
            _rowWithnameline('ShipmentJourney'.tr, primaryColor),
            for (int q = 0; q < stutaus!.length; q++)
              Padding(
                padding: const EdgeInsets.all(5),
                child: TimelineTile(
                  isFirst: true,
                  isLast: true,
                  endChild: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomText(
                      text: ' ${stutaus![q].externalText} at ' +
                          stutaus![q].updatedAt,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  indicatorStyle: const IndicatorStyle(
                      width: 13, color: primaryColor, indicatorXY: 0.5),
                  beforeLineStyle:
                      const LineStyle(thickness: 1, color: primaryColor),
                  afterLineStyle:
                      const LineStyle(thickness: 1, color: primaryColor),
                ),
              ),
            _rowWithnameline('PaymentSummary'.tr, primaryColor),
            _buildRowDown(
                text1Color, 12, 'ShippingCost'.tr, '$shipmentCost OMR'),
            _buildRowDown(text1Color, 12, 'COD'.tr, '$cod OMR'),
            _buildRowDown(
                primaryColor, 13, 'TotalCharges'.tr, ' $totalCharges OMR'),
          ],
        ),
      ),
    );
  }

  Widget _buildRowDown(Color color, double size, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text1,
            color: color,
            size: size,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            text: text2,
            color: color,
            size: size,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Row _rowWithnameline(String title, Color color) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 3,
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        CustomText(
          text: title ?? "",
          color: color,
          fontWeight: FontWeight.bold,
        ),
        Expanded(
          child: Container(
            height: 3,
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildRowText(String title, String subTilte) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontWeight: FontWeight.w400,
          color: text1Color,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomText(
          text: subTilte,
          fontWeight: FontWeight.w400,
          color: text1Color,
        ),
      ],
    );
  }
}
