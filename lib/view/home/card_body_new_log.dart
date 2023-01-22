import 'package:dalile_customer/components/popups/ImagesViewModal.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/DispatcherController.dart';
import 'package:dalile_customer/core/view_model/complain_view_model.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/stepess.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/popups/ProblemViewModalNewLog.dart';

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
      this.onPaymentSuccess,
      required this.area,
      required this.willaya,
      this.searchText = "",
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
      onPaymentSuccess,
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
  final String searchText;
  final List<String>? icon;
  final void Function()? onPressedShowMore;
  HelperController helperController = Get.put(HelperController());
  @override
  Widget build(BuildContext context) {
    final cod = double.tryParse(shipment.cod.toString()) ?? 0;
    List<OrderImages> images = [];
    if (shipment.pickupImage != "")
      images.add(OrderImages(shipment.pickupImage, 'pickupImage'.tr));
    if (shipment.orderImage != "")
      images.add(OrderImages(shipment.orderImage, 'deliveredImage'.tr));
    if (shipment.undeliverImage != "")
      images.add(OrderImages(shipment.undeliverImage, 'undeliverImage'.tr));
    if (shipment.undeliverImage2 != "")
      images.add(OrderImages(shipment.undeliverImage2, 'undeliverImage'.tr));
    if (shipment.undeliverImage3 != "")
      images.add(OrderImages(shipment.undeliverImage3, 'undeliverImage'.tr));

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
            padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (searchText != "" &&
                        orderNumber
                                .toString()
                                .toUpperCase()
                                .split(searchText.toUpperCase())
                                .length >
                            1)
                      Container(
                        color: Colors.orange,
                        child: CustomText(
                          text: searchText,
                          color: Colors.white,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    CustomText(
                      text: searchText != "" &&
                              orderNumber
                                      .toString()
                                      .toUpperCase()
                                      .split(searchText.toUpperCase())
                                      .length >
                                  1
                          ? orderNumber
                              .toString()
                              .toUpperCase()
                              .split(searchText.toUpperCase())[1]
                          : orderNumber.toString(),
                      color: primaryColor,
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    if (!isMyOrder)
                      InkWell(
                        onTap: () {
                          Get.put(ShipmentViewModel())
                              .callAlert(context, number ?? "0");
                        },
                        child: Icon(
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
                          if (shipment.orderProblem != null &&
                              shipment.orderProblem!.auditorResponse !=
                                  "corect" &&
                              shipment.orderProblem!.id > 0 &&
                              (shipment.orderStatusKey == "F" ||
                                  shipment.orderStatusKey == "intransit" ||
                                  shipment.orderStatusKey == "FW" ||
                                  shipment.orderStatusKey == "canceled" ||
                                  shipment.orderStatusKey ==
                                      "receivedbybranch"))
                            problemViewModal(context, orderNumber,
                                    shipment: shipment)
                                .show();
                          else
                            imagesViewModal(context, orderNumber,
                                    shipment: shipment)
                                .show();
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          color: (shipment.orderStatusKey == "F" ||
                                      shipment.orderStatusKey == "intransit" ||
                                      shipment.orderStatusKey == "FW" ||
                                      shipment.orderStatusKey == "canceled" ||
                                      shipment.orderStatusKey ==
                                          "receivedbybranch") &&
                                  shipment.orderProblem != null &&
                                  shipment.orderProblem!.auditorResponse !=
                                      "corect" &&
                                  shipment.orderProblem!.id > 0
                              ? Colors.red
                              : primaryColor,
                          size: 25,
                        ),
                      )
                    else if (isMyOrder && cod > 0)
                      InkWell(
                        onTap: () async {
                          final _url = '$thawaniPaymentLink${shipment.rId}';
                          // Share.share("Sample Share Text");
                          FlutterShare.share(
                            title: ' ',
                            text: "Click here to pay for your order\n$_url",
                          );
                        },
                        child: Icon(
                          Icons.attachment,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),

                    if (isMyOrder && cod > 0)
                      SizedBox(
                        width: 10,
                      ),
                    if (isMyOrder && cod > 0)
                      InkWell(
                        onTap: () async {
                          final _url = '$thawaniPaymentLink${shipment.rId}';
                          Get.put(DispatcherController())
                              .loadingPaymentView
                              .value = true;
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  color: Colors.white,
                                  child: GetX<DispatcherController>(
                                      builder: (dispatcherController) {
                                    return new Stack(
                                      children: [
                                        WebView(
                                          initialUrl: _url,
                                          onWebViewCreated: (controller) {},
                                          javascriptMode:
                                              JavascriptMode.unrestricted,
                                          gestureNavigationEnabled: true,
                                          onPageFinished: (_) {
                                            dispatcherController
                                                .loadingPaymentView
                                                .value = false;

                                            if (_.contains(
                                                "thawanipage_error")) {
                                              Navigator.pop(context);
                                            } else if (_.contains(
                                                "thawanipage_success")) {
                                              onPaymentSuccess();
                                            }
                                          },
                                        ),
                                        dispatcherController
                                                .loadingPaymentView.value
                                            ? Center(
                                                child: WaiteImage(),
                                              )
                                            : Stack()
                                      ],
                                    );
                                  }));
                            },
                          );
                        },
                        child: Icon(
                          Icons.attach_money_sharp,
                          color: primaryColor,
                          size: 20,
                        ),
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
                      child: Icon(
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
                _buildRowText('Ref'.tr + ' : $ref', 'Phone'.tr + ' : $number',
                    context: context),
                _buildRowText(
                    'COD'.tr +
                        ' : ${helperController.getCurrencyInFormat(cod.toString())}',
                    'Date'.tr + ' : $date ',
                    context: context),
              ],
            ),
          ),
          // if (willaya != "")
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomText(
                    size: Get.locale.toString() == "ar" ? 12 : 12,
                    text: "Address".tr + "  $willaya $area",
                    fontWeight: FontWeight.w400,
                    color: text1Color,
                  ),
                ),
              ],
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
              shipment.orderStatusKey == "F" ||
                      shipment.orderStatusKey == "intransit" ||
                      shipment.orderStatusKey == "FW" ||
                      shipment.orderStatusKey == "canceled" ||
                      shipment.orderStatusKey == "receivedbybranch"
                  ? Get.locale.toString() == "en"
                      ? shipment.orderProblem?.problemReason.title != ""
                          ? shipment.orderProblem?.problemReason.title
                          : Order_current_Status
                      : shipment.orderProblem?.problemReason.titleAr != ""
                          ? shipment.orderProblem?.problemReason.titleAr
                          : Order_current_Status
                  : Order_current_Status ?? "",
              shipment.orderStatusKey == "F" ||
                      shipment.orderStatusKey == "intransit" ||
                      shipment.orderStatusKey == "FW" ||
                      shipment.orderStatusKey == "canceled" ||
                      shipment.orderStatusKey == "receivedbybranch"
                  ? Colors.red
                  : status_key == 'F' || status_key == "FW"
                      ? Colors.orange
                      : status_key == 'completed'
                          ? Colors.green
                          : primaryColor),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
              top: 10,
            ),
            child: StepProgressView(
              icons: icon ?? [],
              curStep: Get.put(HelperController())
                  .getStatusCode(shipment.orderStatusKey),
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
            for (int q = 0; q < shipment.orderActivities.length; q++)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: primaryColor,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(shipment.orderActivities[q]!.date),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int p = 0;
                            p < shipment.orderActivities[q]!.activities.length;
                            p++)
                          Column(
                            children: [
                              if (p > 0)
                                Align(
                                    alignment: Get.locale.toString() == "ar"
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: dottedLine(context)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: primaryColor,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    shipment.orderActivities[q]!.activities[p]!
                                        .acitivityTime
                                        .toString(),
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      shipment.orderActivities[q]!
                                          .activities[p]!.externalText
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  )
                ],
              ),
            _rowWithnameline('PaymentSummary'.tr, primaryColor),
            _buildRowDown(
                text1Color,
                Get.locale.toString() == "ar" ? 11 : 12,
                'ShippingCost'.tr,
                '${helperController.getCurrencyInFormat(shipment.shippingPrice.toString())}'),
            _buildRowDown(
                text1Color,
                Get.locale.toString() == "ar" ? 11 : 12,
                'CC'.tr,
                '${helperController.getCurrencyInFormat(shipment.cc.toString())}'),
            _buildRowDown(
                text1Color,
                Get.locale.toString() == "ar" ? 11 : 12,
                'COD'.tr,
                '${helperController.getCurrencyInFormat(shipment.cod.toString())}'),
            _buildRowDown(
                primaryColor,
                Get.locale.toString() == "ar" ? 11 : 12,
                'TotalCharges'.tr,
                '${helperController.getCurrencyInFormat(((double.tryParse(shipment.cc.toString()) ?? 0.0) + (double.tryParse(totalCharges.toString()) ?? 0.0)).toString())}'),
          ],
        ),
      ),
    );
  }

  Padding dottedLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 2, right: 5),
      child: SizedBox(
        height: 30,
        child: DottedLine(
          lineThickness: 2,
          dashGapRadius: 0.5,
          direction: Axis.vertical,
          dashRadius: 0.5,
          dashColor: Colors.grey.shade500,
          dashGapColor: Colors.grey.shade500,
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
          text: title,
          size: Get.locale.toString() == "ar" ? 10 : 12,
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

  Widget _buildRowText(String title, String subTilte,
      {required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CustomText(
            maxLines: 1,
            size: Get.locale.toString() == "ar" ? 10 : 12,
            text: title,
            fontWeight: FontWeight.w400,
            color: text1Color,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.42,
          child: CustomText(
            // direction: TextDirection.ltr,
            maxLines: 1,
            text: subTilte,
            size: Get.locale.toString() == "ar" ? 10 : 12,
            fontWeight: FontWeight.w400,
            color: text1Color,
          ),
        ),
      ],
    );
  }
}
