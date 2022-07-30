import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDialogBoxAl extends StatelessWidget {
  const CustomDialogBoxAl(
      {Key? key, required this.title, required this.des, required this.icon})
      : super(key: key);
  final String title, des;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.8,
            padding:
                const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 7,
                      spreadRadius: 2),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CustomText(
                  text: title,
                  fontWeight: FontWeight.w600,
                  alignment: Alignment.center,
                  size: 27,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomText(
                  text: des,
                  size: 15,
                  color: Colors.grey,
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            child: Image.asset(
              'assets/images/done.png',
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}
