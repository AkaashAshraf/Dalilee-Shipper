import 'package:dalile_customer/components/inputs/text_input.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: textInputCustom(
                                  onTextChange: (val) {
                                    controller.addList[index].phone = val;
                                  },
                                  label: "Contact *",
                                  validator: (_value) {
                                    if ((_value == "" || _value == null) &&
                                        controller
                                            .addList[index].checkValidtion)
                                      return "required";
                                    else
                                      return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  initialValue: order.phone)),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: textInputCustom(
                                  onTextChange: (val) {
                                    controller.addList[index].name = val;
                                  },
                                  label: "Name *",
                                  validator: (_value) {
                                    if ((_value == "" || _value == null) &&
                                        controller
                                            .addList[index].checkValidtion)
                                      return "required";
                                    else
                                      return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  initialValue: order.name)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GetX<DispatcherController>(builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.19,
                                child: textInputCustom(
                                    onTextChange: (val) {
                                      controller.addList[index].cod = val;
                                    },
                                    label: "COD:",
                                    keyboardType: TextInputType.number,
                                    validator: (_value) {
                                      if ((_value == "" || _value == null) &&
                                          controller
                                              .addList[index].checkValidtion)
                                        return "required";
                                      else
                                        return null;
                                    },
                                    autovalidateMode: AutovalidateMode.always,
                                    initialValue: order.cod)),

                            Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.32,
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
                                    final List<Order> list = [];
                                    Order object;
                                    final willaya = controller.willayas
                                        .where((item) => item.name == _value)
                                        .first;
                                    // print(r.id);

                                    for (int i = 0;
                                        i < controller.addList.length;
                                        i++) {
                                      object = controller.addList[i];

                                      if (index == i) {
                                        object.willayaLabel = _value ?? "";
                                        object.willayaID = willaya.id;
                                        object.regionLabel = "";
                                        object.regionID = 0;
                                      }
                                      list.add(object);
                                    }
                                    controller.addList.value = list;
                                  },
                                  autoValidateMode: AutovalidateMode.always,

                                  validator: (String? i) {
                                    if (i == "" &&
                                        controller.addList[index]
                                            .checkValidtion) return 'required';
                                    // else if (i >= 5) return 'value should be < 5';
                                    return null;
                                  },
                                  selectedItem: controller
                                      .addList[index].willayaLabel
                                      .toString(),
                                )),

                            Container(
                                // height: 45,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: DropdownSearch<String>(
                                  label: "Region *",
                                  autoValidateMode: AutovalidateMode.always,
                                  validator: (String? i) {
                                    if (i == "" &&
                                        controller.addList[index]
                                            .checkValidtion) return 'required';
                                  },
                                  showSearchBox: true,
                                  showAsSuffixIcons: true,
                                  showSelectedItems: true,
                                  items: controller.regions
                                      .where((element) =>
                                          element.wilayaId ==
                                          controller.addList[index].willayaID)
                                      .map((element) {
                                    return element.name!;
                                  }).toList(),
                                  onChanged: (_value) {
                                    final List<Order> list = [];
                                    Order object;
                                    final region = controller.regions
                                        .where((item) => item.name == _value)
                                        .first;
                                    // print(r.id);

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
                                  selectedItem:
                                      controller.addList[index].regionLabel,
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
                                )
                            //  _cutomDropDown(
                            //         list: controller.regions
                            //             .where((element) =>
                            //                 element.wilayaId ==
                            //                 controller.addList[index].willaya)
                            //             .map((element) {
                            //           return DropDownListTemplate(
                            //               label: element.name ?? "",
                            //               id: element.id ?? 0);
                            //         }).toList(),
                            //         onSelect: (selection) {
                            //           final List<Order> list = [];
                            //           Order object;
                            //           for (int i = 0;
                            //               i < controller.addList.length;
                            //               i++) {
                            //             object = controller.addList[index];

                            //             if (index == i) {
                            //               object.region = selection.id;
                            //             }
                            //             list.add(object);
                            //           }
                            //           controller.addList.value = list;
                            //         },
                            //         hint: "Region")),
                          ],
                        );
                      }),
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
                                    controller.addList[index].address = val;
                                  },
                                  label: "Address",
                                  initialValue: order.address)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (index == controller.addList.length - 1)
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

Widget _customDropDownExampleMultiSelection(
    BuildContext context, List<DropDownListTemplate?> selectedItems) {
  if (selectedItems.isEmpty) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(),
      title: Text("No item selected"),
    );
  }

  return Wrap(
    children: selectedItems.map((e) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            // leading: CircleAvatar(
            //     // this does not work - throws 404 error
            //     // backgroundImage: NetworkImage(item.avatar ?? ''),
            //     ),
            // title: Text(e?.label ?? ''),
            // subtitle: Text(
            //   e?.label.toString() ?? '',
            // ),
          ),
        ),
      );
    }).toList(),
  );
}
