import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomRefButton extends StatelessWidget {
  const CustomRefButton({Key? key, required this.onPressed}) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(5),
      height: 30,
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          CustomText(
            text: 'Updated data ',
            color: Colors.grey,
            alignment: Alignment.center,
            size: 12,
          ),
          Icon(
            Icons.refresh,
            color: Colors.grey,
            size: 17,
          ),
        ],
      ),
    );
  }
}
