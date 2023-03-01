import 'package:dalile_customer/components/inputs/text_input.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItem extends StatefulWidget {
  AddItem({
    Key? key,
  }) : super(key: key);

  @override
  State<AddItem> createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  final _controller = Get.put(DispatcherController());

  @override
  void initState() {
    super.initState();
    _controller.addList.value = [new Order()];
  }

  @override
  void dispose() {
    super.dispose();
  }

  String subTitle = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 10, right: 10, bottom: 10),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: width * 0.92,
                          child: textInputCustom(
                              // isElevation: true,
                              onTextChange: (val) {},
                              label: "Food Name *",
                              validator: (_value) {
                                // if ((_value == "" || _value == null) &&
                                //     controller.addList[index].checkValidtion)
                                //   return "required";
                                // else
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                              initialValue: "")),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          width: width * 0.92,
                          child: textInputCustom(
                              // isElevation: true,
                              onTextChange: (val) {},
                              label: "Price *",
                              validator: (_value) {
                                // if ((_value == "" || _value == null) &&
                                //     controller.addList[index].checkValidtion)
                                //   return "required";
                                // else
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                              initialValue: "")),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: width * 0.45,
                              child: textInputCustom(
                                  // isElevation: true,
                                  onTextChange: (val) {},
                                  label: "Discount *",
                                  validator: (_value) {
                                    // if ((_value == "" || _value == null) &&
                                    //     controller.addList[index].checkValidtion)
                                    //   return "required";
                                    // else
                                    return null;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  initialValue: "")),
                          Container(
                              width: width * 0.45,
                              child: Expanded(
                                child: Card(
                                  // elevation: 2,
                                  color: Colors.white,
                                  child: DropdownSearch<String>(
                                    label: "Discount Type *",
                                    showSearchBox: true,
                                    showAsSuffixIcons: true,
                                    showSelectedItems: true,
                                    items: ['Percentage', 'Amount'],
                                    onChanged: (_value) {},
                                    autoValidateMode: AutovalidateMode.always,
                                    validator: (String? i) {
                                      return null;
                                    },
                                    selectedItem: "",
                                  ),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: width * 0.45,
                              child: Expanded(
                                child: Card(
                                  // elevation: 2,
                                  color: Colors.white,
                                  child: DropdownSearch<String>(
                                    label: "Category *",
                                    showSearchBox: true,
                                    showAsSuffixIcons: true,
                                    showSelectedItems: true,
                                    items: ['Percentage', 'Amount'],
                                    onChanged: (_value) {},
                                    autoValidateMode: AutovalidateMode.always,
                                    validator: (String? i) {
                                      return null;
                                    },
                                    selectedItem: "",
                                  ),
                                ),
                              )),
                          Container(
                              width: width * 0.45,
                              child: Expanded(
                                child: Card(
                                  // elevation: 2,
                                  color: Colors.white,
                                  child: DropdownSearch<String>(
                                    label: "Sub Category *",
                                    showSearchBox: true,
                                    showAsSuffixIcons: true,
                                    showSelectedItems: true,
                                    items: ['Percentage', 'Amount'],
                                    onChanged: (_value) {},
                                    autoValidateMode: AutovalidateMode.always,
                                    validator: (String? i) {
                                      return null;
                                    },
                                    selectedItem: "",
                                  ),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                          width: width * 0.92,
                          child: textInputCustom(
                              // isElevation: true,
                              onTextChange: (val) {},
                              label: "Addons ",
                              validator: (_value) {
                                // if ((_value == "" || _value == null) &&
                                //     controller.addList[index].checkValidtion)
                                //   return "required";
                                // else
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                              initialValue: "")),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 10, minute: 47),
                                builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child!,
                                  );
                                },
                              );
                            },
                            child: Container(
                                height: height * 0.055,
                                width: width * 0.44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("11:30 AM"),
                                    Icon(
                                      Icons.access_alarm_sharp,
                                    ),
                                  ],
                                ))),
                          ),
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 10, minute: 47),
                                builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child!,
                                  );
                                },
                              );
                            },
                            child: Container(
                                height: height * 0.055,
                                width: width * 0.44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("12:00 AM"),
                                    Icon(
                                      Icons.access_alarm_sharp,
                                    ),
                                  ],
                                ))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          width: width * 0.92,
                          child: textInputCustom(
                              isElevation: true,
                              onTextChange: (val) {},
                              label: "Description ",
                              maxLines: 4,
                              validator: (_value) {
                                // if ((_value == "" || _value == null) &&
                                //     controller.addList[index].checkValidtion)
                                //   return "required";
                                // else
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                              initialValue: "")),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                      width: width * 0.94,
                      height: 40,
                      color: whiteColor,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Submit"))),
                )
              ],
            ),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: 'AddItem'.tr,
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
