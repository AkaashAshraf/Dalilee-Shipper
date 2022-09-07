import 'dart:async';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/login_view_model.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
    _lisnOTP();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  late FocusNode focusNode;
  LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/dalilees.png",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomText(
              text: 'Enter the verification code',
              color: primaryColor,
              fontWeight: FontWeight.bold,
              alignment: Alignment.center,
              size: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text:
                  'We have sent a 4 digit verification code.\nPlease enter the verification code below',
              fontWeight: FontWeight.w400,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: PinFieldAutoFill(
                codeLength: 4,
                decoration: BoxLooseDecoration(
                  radius: const Radius.circular(5),
                  strokeWidth: 1,
                  bgColorBuilder:
                      FixedColorBuilder(primaryColor.withOpacity(0.1)),
                  textStyle: const TextStyle(fontSize: 18, color: text1Color),
                  strokeColorBuilder:
                      FixedColorBuilder(primaryColor.withOpacity(0.3)),
                ),
                onCodeSubmitted: (code) {
                  focusNode.unfocus();
                  _controller.onCompl();
                },
                focusNode: focusNode,
                onCodeChanged: (code) {
                  _controller.pinController.value = code!;
                  if (code.length == 4) {
                    FocusScope.of(context).requestFocus(focusNode);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.7,
              child: _controller.isLoading.value
                  ? const WaiteImage()
                  : CustomButtom(
                      text: 'Confirm the code',
                      onPressed: () {
                        focusNode.unfocus();
                        _controller.onCompl();
                      },
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            _Hours(),
          ],
        );
      }),
    ));
  }

  _lisnOTP() => SmsAutoFill().listenForCode;
}

class _Hours extends StatefulWidget {
  const _Hours({Key? key}) : super(key: key);

  @override
  State<_Hours> createState() => _HoursState();
}

class _HoursState extends State<_Hours> {
  bool isWOTP = false;
  int _start = 60;
  Timer? _timer;
  void startTimer() {
    Get.put(LoginController()).fetchOTPSentData();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isWOTP = false;
            timer.cancel();

            _start = 60;
          });
        } else {
          setState(() {
            isWOTP = true;
            _start--;
          });
          print(_start.toString());
        }
      },
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isWOTP
        ? CustomText(
            text: " $_start seconds",
            alignment: Alignment.center,
            color: textRedColor,
            size: 14,
          )
        : MaterialButton(
            onPressed: () {
              startTimer();
            },
            child: DefaultTextStyle(
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: textRedColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                child: Text(
                  'Resend the verification code again',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: textRedColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                )),
          );
  }
}
