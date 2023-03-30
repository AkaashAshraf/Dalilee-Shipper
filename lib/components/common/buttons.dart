// import 'package:alrahma_society/src/config/constants.dart';
// ignore_for_file: use_key_in_widget_constructors

import 'package:dalile_customer/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ButtonPrimary extends StatelessWidget {
  // const CustomButton({Key? key, Text? text}) : super(key: key);
  final String text;
  final dynamic onPress;
  ButtonPrimary(this.text, this.onPress);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: primaryColor,
      ),
      child: MaterialButton(
        onPressed: () {
          onPress();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SignUp()),
          // );
        },
        child: Text(
          text,
          style: TextStyle(
            color: whiteColor,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        // color: ThemeColor,
        elevation: 7.32,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}

Container cart_button(BuildContext context, dynamic onClick) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(5),
      color: whiteColor,
    ),
    child: MaterialButton(
      onPressed: () {
        onClick();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SignUp()),
        // );
      },
      child: Row(
        children: [
          Text(
            'add_to_cart'.tr,
            style: TextStyle(
                color: primaryColor,
                fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
          // Icon(
          //   Icons.shopping_cart,
          //   color: theme_color,
          // ),
        ],
      ),
      // color: ThemeColor,
      elevation: 7.32,
      minWidth: MediaQuery.of(context).size.width * 0.45,
      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}

Container checkOutButton(BuildContext context, dynamic onPress) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: primaryColor,
    ),
    child: MaterialButton(
      onPressed: () {
        onPress();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SignUp()),
        // );
      },
      child: Row(
        children: [
          Text(
            'donate_now'.tr,
            style: TextStyle(
                color: whiteColor,
                fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
          // Icon(
          //   Icons.local_atm,
          //   color: white_color,
          // ),
        ],
      ),
      // color: ThemeColor,
      elevation: 7.32,
      minWidth: MediaQuery.of(context).size.width * 0.45,
      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}

class ButtonSecondary extends StatelessWidget {
  // const CustomButton({Key? key, Text? text}) : super(key: key);
  final String text;
  final dynamic onPress;
  ButtonSecondary(this.text, this.onPress);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: primaryColor,
      ),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          text,
          style: TextStyle(color: primaryColor, fontSize: 20),
        ),
        // color: ThemeColor,
        elevation: 4.32,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}

Container darkButton(
    BuildContext context, String txt, double textSize, dynamic onPress) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: primaryColor,
    ),
    child: MaterialButton(
      onPressed: () {
        onPress();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SignUp()),
        // );
      },
      child: Text(
        txt,
        style: TextStyle(
            color: whiteColor,
            fontSize: MediaQuery.of(context).size.width * textSize),
      ),
      // color: ThemeColor,
      elevation: 7.32,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}

Container lightButton(
    BuildContext context, String txt, double textSize, dynamic onPress) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: whiteColor,
      border: Border.all(color: primaryColor),
    ),
    child: MaterialButton(
      onPressed: () {
        onPress();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SignUp()),
        // );
      },
      child: Text(
        txt,
        style: TextStyle(
            color: primaryColor,
            fontSize: MediaQuery.of(context).size.width * textSize),
      ),
      // color: ThemeColor,
      elevation: 7.32,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}

Container customButtonWithIcon(
    BuildContext context,
    String txt,
    double textSize,
    dynamic onPress,
    double width,
    Color backgroundColor,
    Color textColor,
    dynamic icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: backgroundColor,
    ),
    child: MaterialButton(
      onPressed: () {
        onPress();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SignUp()),
        // );
      },
      child: Text(
        txt,
        style: TextStyle(color: primaryColor, fontSize: textSize),
      ),
      // color: ThemeColor,
      elevation: 7.32,
      minWidth: width,
      // height: height,

      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}

Padding video_button(BuildContext context, String txt, double textSize,
    dynamic onPress, double width, Color background_color, Color text_color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () => {onPress()},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: background_color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                onPress();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const SignUp()),
                // );
              },
              child: Text(
                txt,
                style: TextStyle(color: text_color, fontSize: textSize),
              ),
              // color: ThemeColor,
              elevation: 7.32,
              // minWidth: width,
              // height: height,

              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            new Image.asset(
              'assets/video.png',
              height: width * 0.095,
              width: width * 0.095,
            ),
          ],
        ),
      ),
    ),
  );
}

Container custom_button_for_searchFiled(
    BuildContext context,
    String txt,
    double textSize,
    dynamic onPress,
    double width,
    double height,
    Color background_color,
    Color text_color) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Get.locale.toString() == 'ar'
              ? Radius.circular(5)
              : Radius.circular(0),
          bottomLeft: Get.locale.toString() == 'ar'
              ? Radius.circular(5)
              : Radius.circular(0),
          topRight: Get.locale.toString() == 'en'
              ? Radius.circular(5)
              : Radius.circular(0),
          bottomRight: Get.locale.toString() == 'en'
              ? Radius.circular(5)
              : Radius.circular(0)),
      color: background_color,
    ),
    child: MaterialButton(
      onPressed: () {
        onPress();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SignUp()),
        // );
      },
      child: Text(
        txt,
        style: TextStyle(color: text_color, fontSize: textSize),
      ),
      // color: ThemeColor,
      elevation: 7.32,
      minWidth: width,
      // height: height,

      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}
