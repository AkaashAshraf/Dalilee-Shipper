import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/account_manager_controller.dart';
import 'package:dalile_customer/model/aacount_manager/store.dart';
import 'package:dalile_customer/model/login_data_model.dart';
import 'package:dalile_customer/view/widget/controller_view.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
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
                    const SizedBox(
                      height: 35,
                    ),
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
                                .map((element) => element.mobile)
                                .toList(),
                            onChanged: (_value) {
                              // inspect(_controller.stores.indexWhere((element) =>
                              //     element.mobile.toString() ==
                              //     _value.toString()));
                              Stores currentSelectedStore = _controller.stores[
                                  _controller.stores.indexWhere(
                                      (element) => element.mobile == _value)];
                              // inspect(currentSelectedStore);
                              setState(() {
                                selectedStore = currentSelectedStore;
                              });
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
                      height: 30,
                    ),
                    SizedBox(
                      height: 20,
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
                                _controller.fetchStoreToken(
                                    selectedStore.storeId.toString());
                                // if (_controller
                                //         .emailVild(_controller.email.value) !=
                                //     null) {
                                //   Get.snackbar(
                                //       'Error',
                                //       _controller
                                //           .emailVild(_controller.email.value),
                                //       backgroundColor:
                                //           Colors.red.withOpacity(0.8),
                                //       colorText: whiteColor);
                                //   return;
                                // }
                                // Get.offAll(ControllerView());
                                // _controller.login();
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
