import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/pickup/details_pickup.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPickupBody extends StatelessWidget {
  const AllPickupBody(
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
                  text: 'Ref : $id',
                  color: primaryColor,
                  size: 16,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () {
                    Get.put(PickupController()).fetcPickupDetailsData("$id");
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
            padding: const EdgeInsets.only(left: 15.0, right: 10, top: 10),
            child: Row(
              children: [
                Flexible(
                  child: _buildRowText('Date :     $date', 'Driver :   $name'),
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildRowText('COP : $cod OMR', 'Quantity : $qty'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 10, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CustomText(
                      text: "status : ",
                      fontWeight: FontWeight.w400,
                      color: text1Color,
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
                      child: CustomText(
                        text: "$status",
                        color: whiteColor,
                        alignment: Alignment.center,

                        // onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
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
          size: 14,
        ),
        const SizedBox(
          height: 12,
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
