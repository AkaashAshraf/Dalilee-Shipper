import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/material.dart';

w3WordsPopup(BuildContext context, String txt) {
  showDialog(
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBoxAl(
          title: "What3Word",
          des: "3 word = $txt",
          icon: Icons.map,
        );
      });
}
