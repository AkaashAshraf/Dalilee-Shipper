import 'package:dalile_customer/components/popups/ImagesViewModal.dart';
import 'package:dalile_customer/components/popups/ProblemViewModal.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/controllers/complain_controller.dart';
import 'package:dalile_customer/controllers/shipment_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/stepess.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  final List<String>? icon;
  final void Function()? onPressedShowMore;
  HelperController helperController = Get.put(HelperController());
  @override
  Widget build(BuildContext context) {
    final cod = double.tryParse(shipment.cod ?? "") ?? 0;
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
            padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
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
                          Get.put(ShipmentViewModel()).callAlert(
                              context, number ?? "",
                              driverContact: "");
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
                          if (shipment.probllemId! > 0 &&
                              shipment.problemResponse != "corect")
                            problemViewModal(context, orderNumber,
                                    shipment: shipment)
                                .show();
                          // else
                          //   imagesViewModal(context, orderNumber,
                          //           shipment: shipment)
                          //       .show();
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          color: shipment.probllemId! > 0 &&
                                  shipment.problemResponse != "corect"
                              ? Colors.red
                              : primaryColor,
                          size: 25,
                        ),
                      )
                    else if (isMyOrder && cod > 0)
                      InkWell(
                        onTap: () async {
                          final _url = '$thawaniPaymentLink${shipment.orderId}';
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
                          final _url = '$thawaniPaymentLink${shipment.orderId}';
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
                        ' : ${helperController.getCurrencyInFormat(cod)} ',
                    'Date'.tr + ' : $date ',
                    context: context),
              ],
            ),
          ),
          // if (willaya != "")
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
              icons: icon ?? [],
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
                  indicatorStyle: IndicatorStyle(
                      width: 13, color: primaryColor, indicatorXY: 0.5),
                  beforeLineStyle: LineStyle(thickness: 1, color: primaryColor),
                  afterLineStyle: LineStyle(thickness: 1, color: primaryColor),
                ),
              ),
            _rowWithnameline('PaymentSummary'.tr, primaryColor),
            _buildRowDown(text1Color, 12, 'ShippingCost'.tr,
                '${helperController.getCurrencyInFormat(shipmentCost)} '),
            _buildRowDown(text1Color, 12, 'CC'.tr,
                '${helperController.getCurrencyInFormat(cc)} '),
            _buildRowDown(text1Color, 12, 'COD'.tr,
                '${helperController.getCurrencyInFormat(cod)} '),
            _buildRowDown(primaryColor, 13, 'TotalCharges'.tr,
                '${helperController.getCurrencyInFormat((double.tryParse(shipment.cc.toString()) ?? 0.0) + (double.tryParse(totalCharges.toString()) ?? 0.0))}'),
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

  Widget _buildRowText(String title, String subTilte,
      {required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CustomText(
            maxLines: 1,
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
            maxLines: 1,
            text: subTilte,
            fontWeight: FontWeight.w400,
            color: text1Color,
          ),
        ),
      ],
    );
  }
}
