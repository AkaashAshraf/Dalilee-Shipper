import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/pickup/details_pickup.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPickupBody extends StatelessWidget {
  AllPickupBody(
      {Key? key,
      this.date,
      this.onPressed,
      this.cod,
      this.name,
      this.qty,
      this.id,
      this.status})
      : super(key: key);
  final dynamic date, cod, name, qty, id;

  final dynamic status;
  final void Function()? onPressed;
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
                  text: 'Ref'.tr + ' : $id',
                  color: primaryColor,
                  size: Get.locale.toString() == "ar" ? 13 : 16,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () {
                    Get.put(PickupController()).fetcPickupDetailsData(
                        collectionID: id.toString(), isRefresh: true);
                    Get.to(() => PickupDetails(
                          ref: "$id",
                          date: "$date",
                        ));
                  },
                  child: Image.asset(
                    'assets/images/visbilty.png',
                    width: 22,
                    height: 22,
                  ),
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
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRowText('Date'.tr + ' : $date', 'Driver'.tr + ' : $name'),
                _buildRowText(
                    'COP'.tr +
                        ' : ${helperController.getCurrencyInFormat(cod)}',
                    'Quantity'.tr + ' : $qty'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: "status".tr + " : ",
                      fontWeight: FontWeight.w400,
                      color: text1Color,
                      size: Get.locale.toString() == "ar" ? 10 : 12,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withOpacity(0.5)],
                          stops: const [0, 2],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                        ),
                      ),
                      //alignment: Alignment.center,
                      child: Center(
                        child: CustomText(
                          text: "$status",
                          color: whiteColor,
                          size: Get.locale.toString() == "ar" ? 10 : 12,

                          alignment: Alignment.center,

                          // onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1.5,
                          color: primaryColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      onPressed: onPressed,
                      child: Image.asset(
                        'assets/images/call.png',
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildRowText(String title, String subTilte) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontWeight: FontWeight.w400,
          color: text1Color,
          size: Get.locale.toString() == "ar" ? 10 : 13,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomText(
          text: subTilte,
          fontWeight: FontWeight.w400,
          color: text1Color,
          size: Get.locale.toString() == "ar" ? 10 : 13,
        ),
      ],
    );
  }
}
