import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/profileController.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

Alert otp_modal(BuildContext context) {
  String _code = "";
  ProfileController controller = Get.put(ProfileController());
  return modal(
    context,
    Column(
      children: [
        GetX<ProfileController>(builder: (controller) {
          return Stack(
            children: [
              Column(children: [
                Text(
                  'Enter your OTP to your new number please verify it',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                PinFieldAutoFill(
                  codeLength: 4,
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder:
                        FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  currentCode: _code,
                  onCodeSubmitted: (code) {
                    // print(code);
                    // if (controller.sentOtp.value == code) {
                    //   Navigator.pop(context);
                    //   controller.updateProfile();
                    // }
                  },
                  onCodeChanged: (code) async {
                    if (controller.sentOtp.value == code && code?.length == 4)
                    // if (code?.length == 4)
                    {
                      controller.enteredOtp.value = code.toString();
                      // Navigator.pop(context);
                      var res = await controller.updateProfile();
                      if (res) Navigator.pop(context);
                    } else if (code?.length == 4) {
                      Get.snackbar('Error', "Invalid OTP",
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: whiteColor);
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                false == false
                    ? Column(
                        children: [],
                      )
                    : Center(
                        child: Container(
                        height: 50,
                        width: 50,
                        child: null,
                      )),
                SizedBox(
                  height: 10,
                ),
                CustomButtom(
                  text: 'Confirm',
                  onPressed: () async {
                    // if (controller.sentOtp.value == controller.enteredOtp.value &&
                    //     controller.enteredOtp.value.length == 4)
                    if (true) {
                      // Navigator.pop(context);
                      var res = await controller.updateProfile();
                      // if (res)
                      Navigator.pop(context);
                    } else {
                      Get.snackbar('Error', "Invalid OTP",
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: whiteColor);
                    }
                  },
                ),
              ]),
              if (controller.profileLoading.value)
                Positioned.fill(
                    // top: MediaQuery.of(context).size.height * 0.4,
                    // right: MediaQuery.of(context).size.width * 0.35,
                    child: const WaiteImage()),
            ],
          );
        })
      ],
    ),
  );
}
