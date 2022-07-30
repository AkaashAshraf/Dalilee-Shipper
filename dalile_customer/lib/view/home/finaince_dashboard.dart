import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbord_model_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceDash extends StatelessWidget {
  const FinanceDash({Key? key, required this.controller}) : super(key: key);
  final DashbordController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Obx(
        () => Column(
          
            children: [
              controller.isLoadingf.value
                  ? WaiteImage()
                  : MaterialButton(
                      onPressed: () {
                        controller.fetchAllShipemetData();
    controller.fetchDeliverShipemetData();
    controller.fetchRetrunShipemetData();
    controller.fetchcancellShipemetData();
    controller.fetchToBeDeliveredShipemetData();
    controller.fetchToBePickupData();
    controller.fetchFinanceDashbordData();
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
              buildCard(
                  context,
                  _InsideShape(
                    subtitle: '',
                    image: Icon(
  Icons.account_balance_wallet_outlined,
  color: whiteColor,
  size: 50,
),
                    title: 'Total Orders',
                    numbers:
                        '${controller.dashData.value.totalOrders ?? "0 OMR"}',
                  ),
                  15.0,
                  15.0,
                  0.0,
                  0.0),
                     const SizedBox(
                height: 10,
              ),
                    buildCard(
                  context,
                  _InsideShape(
                    subtitle: '',
                    image: Icon(
  Icons.paid_outlined,
  color: whiteColor,
  size: 50,
),
                    title: 'Total to be Paid',
                    numbers:
                        '${controller.dashData.value.totalToBePaid ?? "0 OMR"}',
                  ),
                  15.0,
                  15.0,
                   15.0,
                  15.0,),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/delivered.png',
                      title: 'Total collected',
                      numbers:
                          '${controller.dashData.value.totalToBeCollected ?? "0"}',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/tobepickup.png',
                      title: 'COD Pending',
                      numbers:
                          '${controller.dashData.value.codPending ?? "0"}',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
                   Row(
                children: [
                  _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/delivered.png',
                      title: 'Total with Driver',
                      numbers:
                          '${controller.dashData.value.totalWithDrivers ?? "0"}',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _buildsmallbox(
                    _InsideSmallBox(
                      image: 'assets/images/tobepickup.png',
                      title: 'Total Returned',
                      numbers:
                          '${controller.dashData.value.totalReturned ?? "0"}',
                    ),
                  ),
                ],
              ),
         
            ]),
      ),
    );
  }
}

Expanded _buildsmallbox(Widget child) {
  return Expanded(
    child: Container(
        height: 100,
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
    height: 130,
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
    padding: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
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
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
            Image.asset(
              image,
              height: 30,
              width: 30,
           //   fit: BoxFit.contain,
            ),
             CustomText(
              text: numbers,
              color: whiteColor,
              size: 14,
            ),
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
      required this.numbers,required this.subtitle})
      : super(key: key);
  final String  title, numbers,subtitle;
  final Widget image;
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
             SizedBox(height: 10,),
              CustomText(
              text: subtitle,
              color:Colors.grey.shade200,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10,),
            CustomText(
              text: numbers,
              color: Colors.grey.shade200,
              size: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        image
      ],
    );
  }
}
