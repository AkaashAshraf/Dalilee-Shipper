import 'package:dalile_customer/components/inputs/text_input.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:dalile_customer/model/Dispatcher/components/map_picker_input_add_order.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

// import 'user_model.dart';
class AddOrderCard extends StatelessWidget {
  AddOrderCard(
      {Key? key,
      required this.order,
      required this.onCancelClick,
      required this.controller,
      required this.index})
      : super(key: key);

  final Order order;
  final int index;
  final dynamic onCancelClick;
  final DispatcherController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: Container(
        // height: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.4,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ]),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.015,
                      right: MediaQuery.of(context).size.width * 0.015,
                      top: 40,
                      bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey, // Set border color
                              width: 1), // Set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: "Pickup Info".tr,
                                  fontWeight: FontWeight.w600,
                                  size: 15,
                                ),
                              ],
                            ).paddingOnly(bottom: 10),
                            LocationPickerInputForAddOrder(
                                title: "choosePickupLocation".tr, index: index),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          controller.addList[index].roadNumber =
                                              val;
                                        },
                                        label: "Road Number".tr,
                                        // validator: (_value) {
                                        //   if ((_value == "" ||
                                        //           _value == null) &&
                                        //       controller.addList[index]
                                        //           .checkValidtion)
                                        //     return "".tr;
                                        //   else
                                        //     return null;
                                        // },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: order.roadNumber)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          controller
                                              .addList[index].blockNumber = val;
                                        },
                                        label: "Block Number".tr,
                                        // validator: (_value) {
                                        //   if ((_value == "" ||
                                        //           _value == null) &&
                                        //       controller.addList[index]
                                        //           .checkValidtion)
                                        //     return "".tr;
                                        //   else
                                        //     return null;
                                        // },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: order.blockNumber)),
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: textInputCustom(
                                    onTextChange: (val) {
                                      controller.addList[index].flatNumber =
                                          val;
                                    },
                                    label: "Flat Number".tr,
                                    // validator: (_value) {
                                    //   if ((_value == "" || _value == null) &&
                                    //       controller
                                    //           .addList[index].checkValidtion)
                                    //     return "".tr;
                                    //   else
                                    //     return null;
                                    // },
                                    autovalidateMode: AutovalidateMode.always,
                                    initialValue: order.flatNumber)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: textInputCustom(
                                        maxLines: 3,
                                        onTextChange: (val) {
                                          controller.addList[index].pickupNote =
                                              val;
                                        },
                                        label: "Pickup Note".tr,
                                        initialValue: order.pickupNote)),
                              ],
                            ),
                          ],
                        ).paddingSymmetric(vertical: 10, horizontal: 5),
                      ).paddingOnly(bottom: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey, // Set border color
                              width: 1), // Set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: "Delivery Info".tr,
                                  fontWeight: FontWeight.w600,
                                  size: 15,
                                ),
                              ],
                            ).paddingOnly(bottom: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          controller.addList[index].phone = val;
                                        },
                                        label: "contact".tr,
                                        validator: (_value) {
                                          if ((_value == "" ||
                                                  _value == null) &&
                                              controller.addList[index]
                                                  .checkValidtion)
                                            return "required".tr;
                                          else
                                            return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: order.phone)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          controller.addList[index].name = val;
                                        },
                                        label: "Name".tr,
                                        validator: (_value) {
                                          if ((_value == "" ||
                                                  _value == null) &&
                                              controller.addList[index]
                                                  .checkValidtion)
                                            return "required".tr;
                                          else
                                            return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: order.name)),
                              ],
                            ),
                            GetX<DispatcherController>(builder: (controller) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.19,
                                      child: textInputCustom(
                                          onTextChange: (val) {
                                            controller.addList[index].cod = val;
                                          },
                                          label: "COD".tr,
                                          keyboardType: TextInputType.number,
                                          validator: (_value) {
                                            if ((_value == "" ||
                                                    _value == null) &&
                                                controller.addList[index]
                                                    .checkValidtion)
                                              return "required".tr;
                                            else
                                              return null;
                                          },
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          initialValue: order.cod)),
                                  Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: DropdownSearch<String>(
                                        label: "Wilaya".tr,

                                        showSearchBox: true,
                                        // showClearButton: true,
                                        showAsSuffixIcons: true,
                                        showSelectedItems: true,

                                        items:
                                            controller.willayas.map((element) {
                                          return element.name;
                                        }).toList(),
                                        onChanged: (_value) {
                                          final List<Order> list = [];
                                          Order object;
                                          final willaya = controller.willayas
                                              .where(
                                                  (item) => item.name == _value)
                                              .first;
                                          // print(r.id);

                                          for (int i = 0;
                                              i < controller.addList.length;
                                              i++) {
                                            object = controller.addList[i];

                                            if (index == i) {
                                              object.willayaLabel =
                                                  _value ?? "";
                                              object.willayaID = willaya.id;
                                              object.regionLabel = "";
                                              object.regionID = 0;
                                            }
                                            list.add(object);
                                          }
                                          controller.addList.value = list;
                                        },
                                        autoValidateMode:
                                            AutovalidateMode.always,

                                        validator: (String? i) {
                                          if (i == "" &&
                                              controller.addList[index]
                                                  .checkValidtion)
                                            return 'required'.tr;
                                          // else if (i >= 5) return 'value should be < 5';
                                          return null;
                                        },
                                        selectedItem: controller
                                            .addList[index].willayaLabel
                                            .toString(),
                                      )),
                                  Container(
                                      // height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: DropdownSearch<String>(
                                        label: "Region".tr,
                                        autoValidateMode:
                                            AutovalidateMode.always,
                                        validator: (String? i) {
                                          if (i == "" &&
                                              controller.addList[index]
                                                  .checkValidtion)
                                            return 'required'.tr;
                                        },
                                        showSearchBox: true,
                                        showAsSuffixIcons: true,
                                        showSelectedItems: true,
                                        items: controller.regions
                                            .where((element) =>
                                                element.wilayaId ==
                                                controller
                                                    .addList[index].willayaID)
                                            .map((element) {
                                          return element.name!;
                                        }).toList(),
                                        onChanged: (_value) {
                                          final List<Order> list = [];
                                          Order object;
                                          final region = controller.regions
                                              .where(
                                                  (item) => item.name == _value)
                                              .first;

                                          for (int i = 0;
                                              i < controller.addList.length;
                                              i++) {
                                            object = controller.addList[i];

                                            if (index == i) {
                                              object.regionLabel = _value ?? "";
                                              object.regionID = region.id ?? 0;
                                            }
                                            list.add(object);
                                          }
                                          controller.addList.value = list;
                                        },
                                        selectedItem: controller
                                            .addList[index].regionLabel,
                                      ))
                                ],
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: textInputCustom(
                                        maxLines: 4,
                                        onTextChange: (val) {
                                          controller.addList[index].address =
                                              val;
                                        },
                                        label: "Address".tr,
                                        initialValue: order.address)),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ).paddingSymmetric(vertical: 10, horizontal: 5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (controller.addList.length > 1 &&
                index == controller.addList.length - 1)
              Positioned(
                  right: -5,
                  top: -5,
                  child: IconButton(
                      icon: Icon(
                        Icons.cancel_presentation_outlined,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: onCancelClick)),
          ],
        ),
      ),
    );
  }

  DecoratedBox _cutomDropDown(
      {required List<DropDownListTemplate> list,
      required dynamic onSelect,
      required String hint}) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: Color.fromARGB(255, 207, 203, 203)),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButton<DropDownListTemplate>(
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            hint,
            style: TextStyle(fontSize: 12),
          ),
        ),
        items: list.map((DropDownListTemplate value) {
          return DropdownMenuItem<DropDownListTemplate>(
            value: value,
            child: Text(value.label),
          );
        }).toList(),
        onChanged: (selection) {
          onSelect(selection);
        },
      ),
    );
  }
}

class DropDownListTemplate {
  final int id;
  final String label;
  String userAsString() {
    return '#${this.id} ${this.label}';
  }

  DropDownListTemplate({this.id: 0, required this.label});
}
