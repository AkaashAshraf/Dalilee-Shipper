import 'package:dalile_customer/components/generalModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert infoModal(BuildContext context,
    {required String title, required String message, bool isError = false}) {
  // ProfileController controller = Get.put(ProfileController());
  return modal(
    context,
    Column(
      children: [
        Stack(
          children: [
            Column(children: [
              Text(
                title,
                style: TextStyle(
                    color: isError ? Colors.red : Colors.green,
                    fontSize: MediaQuery.of(context).size.width * 0.06),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                message,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("OK".tr)),
                    ),
                  ],
                ),
              )
            ])
          ],
        )
      ],
    ),
  );
}
