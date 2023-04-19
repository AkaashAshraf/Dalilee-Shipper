import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/account_manager_controller.dart';
import 'package:dalile_customer/model/aacount_manager/store.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseStoreView extends StatefulWidget {
  ChooseStoreView({Key? key}) : super(key: key);

  @override
  State<ChooseStoreView> createState() => _LoginViewState();
}

class _LoginViewState extends State<ChooseStoreView> {
  final AccountManagerController _controller =
      Get.put(AccountManagerController());
  String countryCode = "";
  String mobile = "";
  bool isMobileSearch = false;

  Stores selectedStore = Stores();
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Obx(() {
          return Form(
            key: _controller.globalKey,
            child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset(
                      "assets/images/dalilees.png",
                      fit: BoxFit.contain,
                      height: 220,
                      width: 220,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!isMobileSearch)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomText(
                          text: "Please Select Store",
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          alignment: Alignment.bottomRight,
                          size: 15,
                        ),
                      ),
                    if (!isMobileSearch)
                      const SizedBox(
                        height: 35,
                      ),
                    if (!isMobileSearch)
                      Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownSearch<String>(
                              label: "Select Store",
                              autoValidateMode: AutovalidateMode.always,
                              dropdownBuilder: ((context, item) =>
                                  Text(item ?? "")),
                              showSearchBox: true,
                              showAsSuffixIcons: true,
                              showSelectedItems: true,
                              items: _controller.stores
                                  .map((element) =>
                                      element.mobile + " - " + element.name)
                                  .toList(),
                              onChanged: (_value) {
                                // inspect(_controller.stores.indexWhere((element) =>
                                //     element.mobile.toString() ==
                                //     _value.toString()));

                                try {
                                  var splittedArray = _value?.split(" ");
                                  var temparedValue = splittedArray!.isNotEmpty
                                      ? splittedArray[0]
                                      : _value;
                                  Stores currentSelectedStore =
                                      _controller.stores[_controller.stores
                                          .indexWhere((element) =>
                                              element.mobile == temparedValue)];
                                  // inspect(currentSelectedStore);
                                  setState(() {
                                    mobile = "";
                                    selectedStore = currentSelectedStore;
                                  });
                                } catch (e) {}
                              },
                              selectedItem: selectedStore.mobile,
                            ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    if (!isMobileSearch) Text("OR"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isMobileSearch,
                          onChanged: (value) {
                            setState(() {
                              isMobileSearch = !isMobileSearch;
                            });
                          },
                        ), //Che

                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Search By Mobile".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15)),
                            ]),
                          ),
                        )
                      ],
                    ),
                    if (isMobileSearch)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomFormFiledWithTitle(
                          onChanged: (val) {
                            setState(() {
                              mobile = val;
                              selectedStore = Stores();
                            });
                          },
                          text: 'Enter Store Mobile Number'.tr,
                          keyboardType: TextInputType.number,
                          // controller: new TextEditingController(
                          //   text: mobile,
                          // ),

                          // initialValue: controller.profile.value.storeMobile,

                          hintText: '',
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: _controller.loading.value
                          ? const WaiteImage()
                          : CustomButtom(
                              text: 'Next'.tr,
                              backgroundColor: primaryColor,
                              onPressed: () async {
                                _controller.selectedStore(selectedStore);
                                if ((!isMobileSearch &&
                                        _controller
                                                .selectedStore.value.storeId ==
                                            0) ||
                                    (isMobileSearch && mobile.isEmpty)) {
                                  return;
                                }
                                _controller.fetchStoreToken(
                                    isMobileSearch
                                        ? ""
                                        : selectedStore.storeId.toString(),
                                    mobile: isMobileSearch ? mobile : "");
                              }),
                    ),
                  ],
                )),
          );
        }),
      ),
    );
  }
}
