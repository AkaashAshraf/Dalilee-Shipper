import 'package:dalile_customer/constants.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      this.text = '',
      this.size = 12,
      this.color = text1Color,
      this.alignment = Alignment.topLeft,
      this.fontWeight = FontWeight.normal})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  final Alignment alignment;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style:
            TextStyle(fontSize: size, color: color, fontWeight: fontWeight,),
      ),
    );
  }
}
