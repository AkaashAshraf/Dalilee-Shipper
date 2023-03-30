import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/account_manager_controller.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountManagerLoginView extends StatefulWidget {
  AccountManagerLoginView({Key? key}) : super(key: key);

  @override
  State<AccountManagerLoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<AccountManagerLoginView> {
  final AccountManagerController _controller =
      Get.put(AccountManagerController());
  String countryCode = "";
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
                    CustomText(
                      text: "WELCOME TO DALILEE ACCOUNT MANAGER APP",
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      size: 15,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 20),
                          child: Row(
                            children: [
                              Text('Login'.tr, style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        // _customDropDownExampleMultiSelection(
                        //     context, controller.countries),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MyInput(
                        // controller: _controller.email.value,
                        validator: (x) => _controller.emailVild(x),
                        keyboardType: TextInputType.emailAddress,
                        limitCharacters: 100,
                        hintText: 'Enteryouremail'.tr,
                        onChanged: ((p0) => {_controller.email(p0)}),

                        // prefix: Text(''),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MyInput(
                        // controller: _controller.email.value,
                        validator: (x) => _controller.passwordValid(x),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: ((p0) => {_controller.password(p0)}),
                        limitCharacters: 100,
                        hintText: "Enter password",
                        // prefix: Text(''),
                      ),
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
                              text: 'Signin'.tr,
                              backgroundColor: primaryColor,
                              onPressed: () async {
                                setState(() {
                                  validate = true;
                                });
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

                                _controller.login();
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
