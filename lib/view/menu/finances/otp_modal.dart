import 'package:dalile_customer/components/common/buttons.dart';
import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/enquiry_controller.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

Alert otpModal(BuildContext context) {
  String _code = "";

  return modal(
    context,
    Column(
      children: [
        GetX<EnquiryFinanceController>(builder: (controller) {
          return Column(children: [
            Text(
              'enter_otp_to_verify'.tr,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            // TextFieldPinAutoFill(
            //     decoration: // basic InputDecoration
            //     currentCode: // prefill with a code
            //     onCodeSubmitted: //code submitted callback
            //     onCodeChanged: //code changed callback
            //     codeLength: //code length, default 6
            //   ),
            // OTPTextField(
            //   length: 4,
            //   width: MediaQuery.of(context).size.width,
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   fieldWidth: 60,

            //   fieldStyle: FieldStyle.box,
            //   // otpFieldStyle: FieldStyle.underline,
            //   outlineBorderRadius: 5,

            //   // style: TextStyle(fontSize: 17, wordSpacing: 9),
            //   onChanged: (pin) {
            //     // print("Changed: " + pin);
            //     controller.enteredOtp.value = pin;
            //   },
            //   onCompleted: (pin) {
            //     controller.enteredOtp.value = pin;
            //     // print("Completed: " + pin);
            //   },
            // ),
            PinFieldAutoFill(
              codeLength: 4,
              decoration: UnderlineDecoration(
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              currentCode: _code,
              onCodeSubmitted: (code) {
                // controller.checkval(context);
              },
              onCodeChanged: (code) {
                if (code!.length == 4) {
                  _code = code;
                  controller.otp.value = code;
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            controller.isAddwiting.value == false
                ? Column(
                    children: [
                      lightButton(context, 'verify'.tr, 0.038, () async {
                        if (controller.otp.value.length < 4) {
                          return;
                        }
                        controller.checkval(context);

                        // var res =
                        //     await controller.addEnquiryFinanceData(context);
                        // // .verifyOTP(controller.phone.toString());
                        // if (res) Navigator.pop(context);
                      }),
                    ],
                  )
                : Center(
                    child: Container(
                    height: 50,
                    width: 50,
                    child: LoadingIndicator(
                      indicatorType: Indicator.lineSpinFadeLoader,
                      colors: [primaryColor],
                      strokeWidth: 2,
                      // backgroundColor: Colors.white,
                      // pathBackgroundColor: Colors.black
                    ),
                  )),
            SizedBox(
              height: 10,
            ),
            // if (!controller.isAddwiting.value)
            //   lightButton(context, 'resend_otp'.tr, 0.038, () {
            //     // controller.sendOtp();
            //     otpTimerButtonController.startTimer();
            //     // controller.getRegister(controller.phone.toString());
            //   }),

            if (controller.isAddwiting.value == false)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: OtpTimerButton(
                  controller: controller.otpTimerButtonController,
                  backgroundColor: primaryColor,
                  onPressed: () {
                    controller.sendOtp();
                    controller.otpTimerButtonController.startTimer();
                  },
                  text: Text('resend_otp'.tr),
                  duration: 60,
                  height: MediaQuery.of(context).size.height * 0.055,
                ),
              ),
          ]);
        }),
      ],
    ),
  );
}
