import 'package:dalile_customer/components/generalModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert showInfoMessage(BuildContext context,
    {required String message, String message2: ""}) {
  // ProfileController controller = Get.put(ProfileController());
  return modal(
    context,
    Column(
      children: [
        Stack(
          children: [
            Column(children: [
              Text(
                "info".tr,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                message2,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.038,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK".tr)),
              )
            ]),
          ],
        )
      ],
    ),
  );
}
