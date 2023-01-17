import 'package:dalile_customer/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      this.text = '',
      this.size = 12,
      this.direction,
      this.maxLines = 2,
      this.color = text1Color,
      this.alignment = Alignment.topLeft,
      this.fontWeight = FontWeight.normal})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  final int maxLines;
  final Alignment alignment;
  final FontWeight? fontWeight;
  final TextDirection? direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: alignment,
      child: Text(
        text,
        textDirection: direction != null
            ? direction
            : Get.locale.toString() == "ar"
                ? TextDirection.rtl
                : TextDirection.ltr,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: fontWeight,
            fontFamily: "Montserrat"),
      ),
    );
  }
}
