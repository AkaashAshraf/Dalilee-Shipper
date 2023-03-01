import 'package:dalile_customer/components/inputs/text_input.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditOrder extends StatefulWidget {
  EditOrder({
    Key? key,
    required this.order,
  }) : super(key: key);
  Order order;
  @override
  State<EditOrder> createState() => _EditOrder(order: order);
}

class _EditOrder extends State<EditOrder> {
  @override
  void initState() {
    super.initState();
  }

  _EditOrder({required this.order});
  @override
  void dispose() {
    super.dispose();
  }

  _checkValidtion() async {
    final _controller = Get.put(DispatcherController());

    bool isValid = true;
    Order order;
    List<Order> tempList = [];
    for (int i = 0; i < _controller.addList.length; i++) {
      order = _controller.addList[i];
      order.checkValidtion = true;
      tempList.add(order);
      if (order.phone == "" ||
          order.name == "" ||
          order.willayaID == 0 ||
          order.regionID == 0) isValid = false;
    }
    _controller.addList.value = tempList;
    return isValid;
  }

  Order order;
  String subTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        body: Container(
            padding: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Column(
              children: [
                GetX<DispatcherController>(builder: (_controller) {
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
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          order.phone = val;
                                        },
                                        label: "Contact *",
                                        validator: (_value) {
                                          if ((_value == "" ||
                                                  _value == null) &&
                                              order.checkValidtion)
                                            return "required";
                                          else
                                            return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: _controller
                                            .currentOrder.value.phone)),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.23,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          order.cod = val;
                                        },
                                        label: "COD:" + order.name,
                                        keyboardType: TextInputType.number,
                                        validator: (_value) {
                                          if ((_value == "" ||
                                                  _value == null) &&
                                              order.checkValidtion)
                                            return "required";
                                          else
                                            return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: order.cod)),

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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: textInputCustom(
                                        onTextChange: (val) {
                                          order.name = val;
                                          setState(() {
                                            order = order;
                                          });
                                        },
                                        label: "Name *",
                                        validator: (_value) {
                                          if ((_value == "" ||
                                                  _value == null) &&
                                              order.checkValidtion)
                                            return "required";
                                          else
                                            return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        initialValue: _controller
                                            .currentOrder.value.name)),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // GetX<Dispatcher_controller>(builder: (_controller) {
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: [
                                    Container(
                                        // height: 45,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Expanded(
                                          child: DropdownSearch<String>(
                                            label: "Willaya *",

                                            showSearchBox: true,
                                            // showClearButton: true,
                                            showAsSuffixIcons: true,
                                            showSelectedItems: true,

                                            items: _controller.willayas
                                                .map((element) {
                                              return element.name;
                                            }).toList(),
                                            onChanged: (_value) {
                                              final willaya = _controller
                                                  .willayas
                                                  .where((item) =>
                                                      item.name == _value)
                                                  .first;
                                              // print(r.id);
                                              final tempOrder = order;
                                              tempOrder.willayaLabel =
                                                  _value ?? "";
                                              tempOrder.willayaID = willaya.id;
                                              tempOrder.regionLabel = "";
                                              tempOrder.regionID = 0;
                                              setState(() {
                                                order = tempOrder;
                                              });
                                              // print(_controller
                                              //     .currentOrder.value
                                              //     .toJson());
                                            },

                                            autoValidateMode:
                                                AutovalidateMode.always,

                                            validator: (String? i) {
                                              if (i == "" &&
                                                  order.checkValidtion)
                                                return 'required';
                                              // else if (i >= 5) return 'value should be < 5';
                                              return null;
                                            },
                                            selectedItem: _controller
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
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: DropdownSearch<String>(
                                          label: "Region *",
                                          autoValidateMode:
                                              AutovalidateMode.always,
                                          validator: (String? i) {
                                            if (i == "" && order.checkValidtion)
                                              return 'required';
                                            else
                                              return null;
                                          },
                                          showSearchBox: true,
                                          showAsSuffixIcons: true,
                                          showSelectedItems: true,
                                          items: _controller.regions
                                              .where((element) =>
                                                  element.wilayaId ==
                                                  order.willayaID)
                                              .map((element) {
                                            return element.name!;
                                          }).toList(),
                                          onChanged: (_value) {
                                            final region = _controller.regions
                                                .where((item) =>
                                                    item.name == _value)
                                                .first;
                                            // print(r.id);
                                            final tempOrder = order;
                                            tempOrder.regionLabel =
                                                _value ?? "";
                                            tempOrder.regionID = region.id ?? 0;
                                            setState(() {
                                              order = tempOrder;
                                            });
                                            // print(_controller.currentOrder
                                            //     .toJson());
                                          },
                                          selectedItem: _controller
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
                                          _controller
                                              .currentOrder.value.address = val;
                                        },
                                        label: "Address",
                                        initialValue: _controller
                                            .currentOrder.value.address)),
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
                                    // order.checkValidtion =
                                    //     true;
                                    final tempOrder = order;
                                    tempOrder.checkValidtion = true;
                                    order = tempOrder;
                                    bool isValid = true;

                                    if (order.phone == "" ||
                                        order.name == "" ||
                                        _controller
                                                .currentOrder.value.willayaID ==
                                            0 ||
                                        _controller
                                                .currentOrder.value.regionID ==
                                            0) isValid = false;
                                    print(order.toJson());
                                    // final isValid = await _checkValidtion();
                                    // if (isValid) controller.handleAddorders(context);
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
            )));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: 'Edit Order'.tr,
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
