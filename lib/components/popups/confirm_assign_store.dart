import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/controllers/add_store_controller.dart';
import 'package:dalile_customer/model/assign_store/assign_store.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';

Alert confirmAssignStore(BuildContext context, {required Store store}) {
  return modal(
    context,
    Column(
      children: [
        GetX<AddStoreController>(builder: (controller) {
          return Stack(
            children: [
              Column(children: [
                Text(
                  '${"are_you_sure_want_to_assign".tr} ${store.name} ${"store_to_you".tr}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                if (!controller.assignLoading.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CustomButtom(
                          text: 'yes'.tr,
                          onPressed: () async {
                            controller.assignStore(
                                storeID: store.id, context: context);
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CustomButtom(
                          text: 'no'.tr,
                          backgroundColor: Colors.red,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )
                else
                  WaiteImage()
              ]),
            ],
          );
        })
      ],
    ),
  );
}
