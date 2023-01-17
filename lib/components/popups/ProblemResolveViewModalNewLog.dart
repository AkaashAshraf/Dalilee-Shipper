import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/components/inputs/text_input.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';

Alert problemResolveViewModal(BuildContext context, String orderNo,
    {required Shipment shipment}) {
  return modal(
    context,
    SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: GetX<DownloadController>(builder: (controller) {
        return Column(children: [
          Text(
            "$orderNo",
            style: TextStyle(color: primaryColor),
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DottedLine(
                dashColor: primaryColor,
              )),
          SizedBox(height: 5),
          Text(
            shipment.orderProblem != null
                ? shipment.orderProblem!.problemReason.title
                : "",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
          SizedBox(height: 5),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DottedLine(
                dashColor: primaryColor,
              )),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width * 0.92,
              child: textInputCustom(
                onTextChange: (val) {
                  controller.comments.value = val;
                },
                label: "Comments",
                maxLines: 4,
                validator: (_value) {
                  if (_value == "" || _value == null) return "required";
                  // else
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                initialValue: controller.comments.value,
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: controller.loading.value
                  ? WaiteImage()
                  : ElevatedButton(
                      onPressed: () {
                        controller.addComment(
                            problemId: shipment.orderProblem!.id.toString(),
                            context: context);
                      },
                      child: Text(
                        "Update".tr,
                        style: TextStyle(color: whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ),
        ]);
      }),
    ),
  );
}
