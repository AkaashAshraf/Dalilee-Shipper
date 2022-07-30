import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/view_order_view_model.dart';
import 'package:dalile_customer/model/view_orders_model.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/stepess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ViewOrderBody extends StatelessWidget {
  const ViewOrderBody(
      {Key? key,
      required this.i,
      required this.list,
      required this.callList,
      required this.menuList})
      : super(key: key);
  final int i;
  final ViewOrderData list;
  final void Function()? callList;
  final void Function()? menuList;

  final List<String> icon = const [
    'pickup.png',
    'pickup.png',
    'pickup.png',
    'pickup.png',
    'pickup.png',
    'pickup.png',
  ];
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
      child: GetBuilder<ViewOrderController>(builder: (_controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Order ID : ${list.orders![i].orderId}',
                    color: primaryColor,
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: callList,
                        child: const Icon(
                          Icons.call_outlined,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.file_download_outlined,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.print_outlined,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: menuList,
                        child: const Icon(
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
              padding: const EdgeInsets.only(left: 15.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildRowText('Ref : ${list.orders![i].refId}',
                        'Customer No : ${list.orders![i].customerNo}'),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Expanded(
                      flex: 3,
                      child: _buildRowText(
                          'COP : ${list.orders![i].cop ?? 0.00} OMR',
                          'Weight : ${list.orders![i].weight} KG')),
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
                icons: list.trackingStatuses!
                    .map((k) => k.icon.toString())
                    .toList(),
                curStep: list.orders![i].currentStatus ?? 1,
                color: primaryColor,
              ),
            ),
            if (list.orders![i].isOpen) _buildPayment(context),
            MaterialButton(
              onPressed: () {
                list.orders![i].isOpen = !list.orders![i].isOpen;
                _controller.update();
                print(list.orders![i].isOpen.toString());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: list.orders![i].isOpen
                        ? 'Hide More Details'
                        : 'Show More Details',
                    color: textRedColor,
                    size: 11,
                    alignment: Alignment.centerRight,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  list.orders![i].isOpen
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
        );
      }),
    );
  }

  Widget _buildPayment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        children: [
          _rowWithnameline('Shipment Journey'),
          for (int q = 0; q < list.orders![i].orderActivities!.length; q++)
            Padding(
              padding: const EdgeInsets.all(5),
              child: TimelineTile(
                isFirst: true,
                isLast: true,
                endChild: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomText(
                    text: ' ${list.orders![i].orderActivities![q].updatedAt}',
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
          _buildRowDown(text1Color, 12, 'Shipping Cost ',
              '${list.orders![i].shippingPrice} OMR'),
          _buildRowDown(
              text1Color, 12, 'COD ', '${list.orders![i].cod} OMR'),
          _buildRowDown(primaryColor, 13, 'Total Charges ',
              ' ${list.orders![i].cod} OMR'),
        ],
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
