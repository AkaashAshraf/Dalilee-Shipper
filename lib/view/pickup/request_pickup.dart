import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickup extends GetWidget<PickupController> {
  const RequestPickup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(() {
        if (controller.isLoadingToday.value) {
          return const WaiteImage();
        }
        return Center(
          child: Form(
            key: controller.formKeyRequest,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CustomFormFiled(
                  text: 'Muhafaza',
                  select: controller.muhafazaCont.text.isEmpty
                      ? "select"
                      : controller.muhafazaCont.text,
                  onSaved: (val) {
                    controller.muhafazaVal(val);
                    return null;
                  },
                  validator: (val) =>
                      val == null ? 'please select muhafaza' : null,
                  hint: 'Select Muhafaza',
                  items: List.generate(controller.muhafazaList.length,
                      (i) => controller.muhafazaList[i]!.name),
                ),
                CustomFormFiled(
                  text: 'Wilaya',
                  select: controller.wCont.text.isEmpty
                      ? "select"
                      : controller.wCont.text,
                  onSaved: (val) {
                    controller.wilayaVal(val);
                    return null;
                  },
                  validator: (val) =>
                      val == null ? 'please select wilaya' : null,
                  hint: 'select wilaya',
                  items: List.generate(controller.wilayaList.length,
                      (i) => controller.wilayaList[i]!.name),
                ),
                CustomFormFiled(
                  text: 'Region',
                  select: controller.rCont.text.isEmpty
                      ? "select"
                      : controller.rCont.text,
                  onSaved: (val) {
                    controller.regionVal(val);
                    return null;
                  },
                  validator: (val) =>
                      val == null ? 'please select region' : null,
                  hint: 'select region',
                  items: List.generate(controller.regionList.length,
                      (i) => controller.regionList[i]!.name),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButtom(
                  text: 'Request Pickup',
                  onPressed: () {
                    controller.fetchAllPostData(context);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
