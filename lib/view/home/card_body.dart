import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/complain_view_model.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
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
      required this.icon,
      this.number,
      this.orderId,
      this.ref,
      this.shipmentCost,
      this.stutaus,
      this.totalCharges,
      this.weight,
      this.orderNumber,
      required this.currentStep,
      required this.onPressedShowMore,
      required this.isOpen})
      : super(key: key);

  final dynamic orderId,
      ref,
      number,
      cop,
      weight,
      orderNumber,
      shipmentCost,
      totalCharges,
      cod;

  final List<dynamic>? stutaus;
  final int currentStep;
  final bool isOpen;
  final List<String> icon;
  final void Function()? onPressedShowMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: primaryColor.withOpacity(0.2),
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
                  text: 'Order # : $orderNumber',
                  color: primaryColor,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
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
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'PDF File',
                            titlePadding: const EdgeInsets.all(15),
                            contentPadding: const EdgeInsets.all(5),
                            middleText: 'Are you sure to download pdf file?',
                            textCancel: 'Cancel',
                            textConfirm: 'Ok',
                            buttonColor: primaryColor,
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            radius: 10,
                            backgroundColor: whiteColor,
                            onConfirm: () {
                              Get.put(ShipmentViewModel())
                                  .launchPDF("$orderId");
                            });
                      },
                      child: Image.asset(
                        'assets/images/pdf.png',
                        width: 23,
                        height: 23,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.put(ComplainController()).fetchTypeComplainData();
                        Get.put(ShipmentViewModel()).menuAlert(
                            context, number ?? "000", orderId ?? "0");
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
            padding: const EdgeInsets.only(left: 15.0, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: _buildRowText('Ref : $ref', 'Customer No : $number'),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                    flex: 3,
                    child:
                        _buildRowText('COP : $cop OMR', 'Weight : $weight KG')),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _rowWithnameline('Order Status'),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              top: 10,
            ),
            child: StepProgressView(
              icons: icon,
              curStep: currentStep,
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
                  text: 'Show More Details',
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
            _rowWithnameline('Shipment Journey'),
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
            _rowWithnameline('Payment Summary'),
            _buildRowDown(
                text1Color, 12, 'Shipping Cost ', '$shipmentCost OMR'),
            _buildRowDown(text1Color, 12, 'COD ', '$cod OMR'),
            _buildRowDown(
                primaryColor, 13, 'Total Charges ', ' $totalCharges OMR'),
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

  Row _rowWithnameline(String title) {
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
          color: primaryColor,
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
          height: 10,
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
