import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/stepess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ShipmentBody extends StatelessWidget {
  ShipmentBody(
      {Key? key,
      required this.outList,
      required this.i,
      required this.shipList})
      : super(key: key);
  final Shipment? outList;
  final List<TrackingStatus> shipList;

  final int i;
  final HelperController helperController = Get.put(HelperController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipmentViewModel>(
        init: ShipmentViewModel(),
        builder: (_data) {
          return Container(
            constraints: const BoxConstraints(minHeight: 205),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 5,
                    color: Colors.grey.shade300,
                  ),
                ]),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Bill No : ${outList!.orderId}',
                        color: primaryColor,
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _data.callAlert(context, outList!.customerNo);
                            },
                            child: Icon(
                              Icons.call_outlined,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: 'PDF File',
                                  titlePadding: const EdgeInsets.all(15),
                                  contentPadding: const EdgeInsets.all(5),
                                  middleText:
                                      'Are you sure to download pdf file?',
                                  textCancel: 'Cancel',
                                  textConfirm: 'Ok',
                                  buttonColor: primaryColor,
                                  confirmTextColor: Colors.white,
                                  cancelTextColor: Colors.black,
                                  radius: 10,
                                  backgroundColor: whiteColor,
                                  onConfirm: () {
                                    _data.launchPDF(outList!.orderId);
                                  });
                            },
                            child: Image.asset(
                              'assets/images/pdf.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              _data.menuAlert(context, outList!.customerNo,
                                  outList!.orderId, "", "", "");
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: primaryColor,
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
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10, top: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: _buildRowText('Ref :     ${outList!.refId}',
                            'Customer No :   ${outList!.customerNo}'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildRowText(
                          'COP : ${helperController.getCurrencyInFormat(outList!.cop)} ',
                          'Weight : ${outList!.weight} KG'),
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
                    icons: shipList.map((e) => e.icon.toString()).toList(),
                    curStep: outList!.currentStatus!,
                    color: primaryColor,
                  ),
                ),
                outList!.isOpen
                    ? _buildPayment(context, _data)
                    : const SizedBox(),
                MaterialButton(
                  onPressed: () {
                    outList!.isOpen = !outList!.isOpen;
                    _data.update();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: outList!.isOpen
                            ? 'Hide More Details'
                            : 'Show More Details',
                        color: textRedColor,
                        size: 11,
                        alignment: Alignment.centerRight,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      outList!.isOpen
                          ? Transform.rotate(
                              angle: 3.14, //set the angel
                              child: const Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: textRedColor,
                                size: 15,
                              ),
                            )
                          : const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: textRedColor,
                              size: 15,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildPayment(BuildContext context, ShipmentViewModel _data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: InkWell(
        onTap: () {
          outList!.isOpen = !outList!.isOpen;
          _data.update();
        },
        child: Column(
          children: [
            _rowWithnameline('Shipment Journey'),
            for (int q = 0; q < outList!.orderActivities!.length; q++)
              Padding(
                padding: const EdgeInsets.all(5),
                child: TimelineTile(
                  isFirst: true,
                  isLast: true,
                  endChild: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomText(
                      text: '${outList!.orderActivities![q].updatedAt}',
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  indicatorStyle: IndicatorStyle(
                      width: 13, color: primaryColor, indicatorXY: 0.5),
                  beforeLineStyle: LineStyle(thickness: 1, color: primaryColor),
                  afterLineStyle: LineStyle(thickness: 1, color: primaryColor),
                ),
              ),
            _rowWithnameline('Payment Summary'),
            _buildRowDown(text1Color, 12, 'Shipping Cost ',
                '${helperController.getCurrencyInFormat(outList!.shippingPrice)}  '),
            _buildRowDown(text1Color, 12, 'COD ',
                '${helperController.getCurrencyInFormat(outList!.cod)} '),
            _buildRowDown(primaryColor, 13, 'Total Charges ',
                '${helperController.getCurrencyInFormat(outList!.shippingPrice! + outList!.cod!)}  '),
          ],
        ),
      ),
    );
  }

  Widget _buildRowDown(Color color, double size, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: subTilte,
          fontWeight: FontWeight.w400,
          color: text1Color,
          size: 14,
        ),
      ],
    );
  }
}
