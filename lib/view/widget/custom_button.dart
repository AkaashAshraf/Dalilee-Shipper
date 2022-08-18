import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomButtom extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color backgroundColor;
  const CustomButtom(
      {Key? key,
      required this.text,
      this.onPressed,
      this.backgroundColor: primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        color: backgroundColor,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.beveled(BorderRadius.circular(10)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: CustomText(
        alignment: Alignment.center,
        text: text,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        size: 15,
      ),
    );
  }
}
