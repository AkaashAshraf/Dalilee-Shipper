import 'package:dalile_customer/constants.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  SimpleButton(
      {Key? key,
      required this.title,
      required this.onPress,
      this.textSize,
      this.disable = false,
      required this.backgroundColor,
      this.textColor = Colors.white})
      : super(key: key);
  final String title;
  final bool disable;
  final dynamic onPress;
  final Color backgroundColor;
  final Color textColor;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return ElevatedButton(
        onPressed: () {
          if (!disable) {
            onPress();
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: backgroundColor))),
            backgroundColor: MaterialStateProperty.all(backgroundColor)),
        child: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontFamily: "primary",
              fontWeight: FontWeight.w700,
              fontSize: textSize ?? width * 0.045),
        ));
  }
}
