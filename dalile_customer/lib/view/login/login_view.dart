import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/login_view_model.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final LoginController _controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Obx(() {
          return Form(
            key: _controller.globalKey,
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
                const CustomText(
                  text: 'WELCOME TO DALILEE APP',
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  alignment: Alignment.center,
                  size: 15,
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyInput(
                    controller: _controller.phoneNumber,
                    validator: (x) => _controller.mobileVild(x),
                    keyboardType: TextInputType.phone,
                    hintText: 'Enter your mobile number',
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 15),
                      child: Text('+968'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: _controller.isLoading.value
                      ? const WaiteImage()
                      : CustomButtom(
                          text: 'login',
                          onPressed: () {
                            _controller.getDeviceDetails();
                            _controller.valid();
                          },
                        ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
