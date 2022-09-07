import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';

Alert DownloadingDialog(BuildContext context) {
  return modal(
    context,
    Column(
      children: [
        GetX<DownloadController>(builder: (controller) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          );
        })
      ],
    ),
  );
}
