import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/model/Pickup/reference.dart';
import 'package:dalile_customer/view/pickup/details_pickup.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickUpItem extends StatelessWidget {
  PickUpItem({
    Key? key,
    required this.refernce,
  }) : super(key: key);
  final Reference refernce;

  final HelperController helperController = Get.put(HelperController());
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 145,
      ),
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
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Ref'.tr + ' : ${refernce.id}',
                  color: Colors.black,
                  size: Get.locale.toString() == "ar" ? 13 : 16,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: refernce.status ?? "",
                  color:
                      refernce.status == "Pending" ? Colors.red : primaryColor,
                  size: Get.locale.toString() == "ar" ? 13 : 16,
                  fontWeight: FontWeight.w600,
                ),

                // InkWell(
                //   onTap: () {
                //     // Get.put(PickupController()).fetcPickupDetailsData(
                //     //     collectionID: id.toString(), isRefresh: true);
                //     // Get.to(() => PickupDetails(
                //     //       ref: "$id",
                //     //       date: "$date",
                //     //     ));
                //   },
                //   child: Image.asset(
                //     'assets/images/visbilty.png',
                //     width: 22,
                //     height: 22,
                //   ),
                // ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ).paddingAll(10),
          _buildRowText(
              title: "Date",
              value: refernce.collectionDate ?? "",
              width: MediaQuery.of(context).size.width),
          _buildRowText(
              title: "Driver Name",
              value: refernce.driverName ?? "",
              width: MediaQuery.of(context).size.width),
          _buildRowText(
              title: "Quantity",
              value: refernce.totalOrders.toString(),
              width: MediaQuery.of(context).size.width),
          _buildRowText(
              title: "COP",
              value: refernce.cop!.toStringAsFixed(3) + " " + "omr".tr,
              width: MediaQuery.of(context).size.width),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: localButton(
                    onClick: () {},
                    title: "Call",
                    icon: Icon(
                      Icons.call,
                      color: primaryColor,
                      size: 20,
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: localButton(
                    onClick: () {},
                    dark: true,
                    title: "Whatsapp",
                    icon: Icon(
                      Icons.whatsapp,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
            ],
          ).paddingAll(10),
          SizedBox(
            height: 5,
          ),
        ],
      ).paddingOnly(top: 10),
    );
  }

  InkWell localButton(
      {required dynamic onClick,
      required String title,
      Widget? icon,
      bool dark = false}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: dark
                ? [primaryColor, primaryColor]
                : [bgColorDark, bgColorDark],
            stops: const [0, 2],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        //alignment: Alignment.center,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? Container(),
              CustomText(
                text: title,
                color: dark ? whiteColor : primaryColor,
                size: Get.locale.toString() == "ar" ? 12 : 14,
                fontWeight: FontWeight.w700,
                alignment: Alignment.center,

                // onPressed: () {},
              ).paddingSymmetric(vertical: 10, horizontal: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowText(
      {required String title, required String value, required double width}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w400,
              color: text1Color,
              size: Get.locale.toString() == "ar" ? 10 : 13,
            ),
          ),
          SizedBox(
            child: CustomText(
              text: value,
              fontWeight: FontWeight.w800,
              color: text1Color,
              size: Get.locale.toString() == "ar" ? 10 : 13,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 5),
    );
  }
}
