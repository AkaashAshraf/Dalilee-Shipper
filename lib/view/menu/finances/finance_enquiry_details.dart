import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:flutter/material.dart';


class FinanceEnquiryDetails extends StatelessWidget {
   FinanceEnquiryDetails(
      {Key? key,
      required this.createAt,
      this.explainEuqrity,
      required this.isOpen})
      : super(key: key);
  final String isOpen;
  final String createAt;
  final String? explainEuqrity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomFormFiledWithTitle(
                  read: true,
                  text: 'Date Created',
                  hintText: createAt,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Status',
                  color: text1Color,
                  fontWeight: FontWeight.w400,
                  size: 13,
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        isOpen != "Closed" ? textRedColor : primaryColor,
                        isOpen != "Closed"
                            ? textRedColor.withOpacity(0.5)
                            : primaryColor.withOpacity(0.5)
                      ],
                      stops: const [0.3, 2],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                    ),
                  ),
                  //alignment: Alignment.center,
                  child: CustomText(
                    text: isOpen == "Closed" ? "Closed" : 'Opened',
                    color: whiteColor,
                    alignment: Alignment.center,

                    // onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomFormFiledWithTitle(
                  read: true,
                  text: 'Explain your enquiry',
                  hintText: 'Order was damaged.',
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Log Details',
                  color: text1Color,
                  fontWeight: FontWeight.w400,
                  size: 13,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: const CustomText(
          text: 'FINANCE ENQUIRY DETAILS',
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w600,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
