import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert modal(BuildContext context, Column content) {
  return Alert(
      style: AlertStyle(
          isOverlayTapDismiss: true,
          alertPadding: EdgeInsets.all(8),
          // alertAlignment: Alignment.center,
          // alertElevation: 5.0,
          overlayColor: Colors.black54),
      context: context,
      // type: AlertType.error,
      // desc:
      //     "Please enter your phone number to complete the payment",
      // desc: "Flutter is more awesome with RFlutter Alert.",
      content: content,
      buttons: []);
}
