import 'dart:io';
import 'package:dalile_customer/view/widget/controller_view.dart';
import 'package:device_info/device_info.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/login_api.dart';
import 'package:dalile_customer/view/login/otp_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAgree = false.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var code;
  void fetchOTPSentData() async {
    try {
      isLoading(true);
      var data = await LoginAPi.loginData(phoneNumber.text);
      if (data != null) {
        if (data["message"] == "OK") {
          code = await SmsAutoFill().getAppSignature;

          Get.to(() => const OTPView());
          Get.snackbar('Send OTP', "OTP Sent Successfully",
              backgroundColor: primaryColor.withOpacity(0.6),
              colorText: whiteColor);
        } else {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Filed', LoginAPi.mass);
          }
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', LoginAPi.mass);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  onCompl() async {
    fetchCheckLoginData(pinController.value);
  }

  final OtpFieldController otpController = OtpFieldController();
  RxString pinController = ''.obs;
  void fetchCheckLoginData(String otp) async {
    try {
      isLoading(true);
      var data = await LoginAPi.loginOtpData(
          phoneNumber.text, otp, "$identifier", "$deviceName");
      if (data != null) {
        if (data["success"] == "ok" || data["success"] == "OK") {
          Get.offAll(() => ControllerView());
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', LoginAPi.mass);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  valid() async {
    if (globalKey.currentState!.validate()) {
      fetchOTPSentData();
    }
  }

  mobileVild(x) {
    if (x.isEmpty) {
      return "please enter your mobile number";
    } else if (x.length > 8) {
      return "number can not be bigger than 20";
    } else if (x.length <= 7) {
      return "number can not be smaller than 8";
    }
  }

  RxString deviceName = ''.obs;

  RxString identifier = ''.obs;

  getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfo.androidInfo;
        deviceName.value = build.model;
        //  deviceVersion = build.version.toString();
        identifier.value = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfo.iosInfo;
        deviceName.value = data.name;
        // deviceVersion = data.systemVersion;
        identifier.value = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {}
  }
}
