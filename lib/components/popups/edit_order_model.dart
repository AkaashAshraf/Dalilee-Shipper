import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/components/inputs/text_input.dart';
import 'package:dalile_customer/core/view_model/DispatcherController.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert editOrderModal(BuildContext context) {
  return modal(
      context,
      Column(
        children: [
          GetX<DispatcherController>(builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                      top: 40,
                      bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: textInputCustom(
                                  onTextChange: (val) {
                                    controller.currentOrder.value.phone = val;
                                  },
                                  label: "Contact *",
                                  validator: (_value) {
                                    if ((_value == "" || _value == null) &&
                                        controller
                                            .currentOrder.value.checkValidtion)
                                      return "required";
                                    else
                                      return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  initialValue:
                                      controller.currentOrder.value.phone)),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: textInputCustom(
                                  onTextChange: (val) {
                                    controller.currentOrder.value.cod = val;
                                  },
                                  label: "COD:" +
                                      controller.currentOrder.value.name,
                                  keyboardType: TextInputType.number,
                                  validator: (_value) {
                                    if ((_value == "" || _value == null) &&
                                        controller
                                            .currentOrder.value.checkValidtion)
                                      return "required";
                                    else
                                      return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  initialValue:
                                      controller.currentOrder.value.cod)),

                          // Container(
                          //     width: MediaQuery.of(context).size.width * 0.44,
                          //     child: textInputCustom(
                          //         onTextChange: (val) {
                          //           order.name = val;
                          //         },
                          //         label: "Name *",
                          //         validator: (_value) {
                          //           if ((_value == "" || _value == null) &&
                          //               order.checkValidtion)
                          //             return "required";
                          //           else
                          //             return null;
                          //         },
                          //         autovalidateMode: AutovalidateMode.always,
                          //         initialValue: order.name)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: textInputCustom(
                                  onTextChange: (val) {
                                    controller.currentOrder.value.name = val;
                                  },
                                  label: "Name *",
                                  validator: (_value) {
                                    if ((_value == "" || _value == null) &&
                                        controller
                                            .currentOrder.value.checkValidtion)
                                      return "required";
                                    else
                                      return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  initialValue:
                                      controller.currentOrder.value.name)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // GetX<DispatcherController>(builder: (controller) {
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Container(
                                  // height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Expanded(
                                    child: DropdownSearch<String>(
                                      label: "Willaya *",

                                      showSearchBox: true,
                                      // showClearButton: true,
                                      showAsSuffixIcons: true,
                                      showSelectedItems: true,

                                      items: controller.willayas.map((element) {
                                        return element.name;
                                      }).toList(),
                                      onChanged: (_value) {
                                        final willaya = controller.willayas
                                            .where(
                                                (item) => item.name == _value)
                                            .first;
                                        // print(r.id);
                                        final tempOrder =
                                            controller.currentOrder.value;
                                        tempOrder.willayaLabel = _value ?? "";
                                        tempOrder.willayaID = willaya.id;
                                        tempOrder.regionLabel = "";
                                        tempOrder.regionID = 0;
                                        controller.currentOrder.value =
                                            tempOrder;
                                        print(controller.currentOrder.value
                                            .toJson());
                                      },

                                      autoValidateMode: AutovalidateMode.always,

                                      validator: (String? i) {
                                        if (i == "" &&
                                            controller.currentOrder.value
                                                .checkValidtion)
                                          return 'required';
                                        // else if (i >= 5) return 'value should be < 5';
                                        return null;
                                      },
                                      selectedItem: controller
                                          .currentOrder.value.willayaLabel
                                          .toString(),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                  // height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: DropdownSearch<String>(
                                    label: "Region *",
                                    autoValidateMode: AutovalidateMode.always,
                                    validator: (String? i) {
                                      if (i == "" &&
                                          controller.currentOrder.value
                                              .checkValidtion)
                                        return 'required';
                                      else
                                        return null;
                                    },
                                    showSearchBox: true,
                                    showAsSuffixIcons: true,
                                    showSelectedItems: true,
                                    items: controller.regions
                                        .where((element) =>
                                            element.wilayaId ==
                                            controller
                                                .currentOrder.value.willayaID)
                                        .map((element) {
                                      return element.name!;
                                    }).toList(),
                                    onChanged: (_value) {
                                      final region = controller.regions
                                          .where((item) => item.name == _value)
                                          .first;
                                      // print(r.id);
                                      final tempOrder =
                                          controller.currentOrder.value;
                                      tempOrder.regionLabel = _value ?? "";
                                      tempOrder.regionID = region.id ?? 0;
                                      controller.currentOrder.value = tempOrder;
                                      print(controller.currentOrder.toJson());
                                    },
                                    selectedItem: controller
                                        .currentOrder.value.regionLabel,
                                  )

                                  // dropdownBuilder: ((context, lis) =>
                                  //     Text(lis.id.toString())),
                                  // showClearButton: true,
                                  // popupProps: PopupPropsMultiSelection.menu(
                                  //     showSelectedItems: true,
                                  //     disabledItemFn: (String s) => s.startsWith('I'),
                                  // ),
                                  // onChanged: (){},
                                  // selectedItem:  ,
                                  ),
                            ],
                          )
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: textInputCustom(
                                  maxLines: 4,
                                  onTextChange: (val) {
                                    controller.currentOrder.value.address = val;
                                  },
                                  label: "Address",
                                  initialValue:
                                      controller.currentOrder.value.address)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Positioned(
                        right: 80,
                        bottom: 30,
                        left: 80,
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomButtom(
                            text: 'Edit'.tr,
                            onPressed: () async {
                              // controller.currentOrder.value.checkValidtion =
                              //     true;
                              final tempOrder = controller.currentOrder.value;
                              tempOrder.checkValidtion = true;
                              controller.currentOrder.value = tempOrder;
                              bool isValid = true;

                              if (controller.currentOrder.value.phone == "" ||
                                  controller.currentOrder.value.name == "" ||
                                  controller.currentOrder.value.willayaID ==
                                      0 ||
                                  controller.currentOrder.value.regionID == 0)
                                isValid = false;
                              print(controller.currentOrder.value.toJson());
                              // final isValid = await _checkValidtion();
                              // if (isValid) controller.handleAddcontroller.currentOrder.values(context);
                              // print(checkValidation);
                              // Get.back();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ));
}
