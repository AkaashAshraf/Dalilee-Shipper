import 'dart:developer';
import 'dart:io';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/countries.dart';
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
  RxString mobile = "".obs;
  RxString emailAddress = "".obs;
  RxString selectedCountryCode = "".obs;

  RxList<Country?> countries = <Country?>[].obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  RxInt isLoginWithUserName = 0.obs;

  void fetchCountries() async {
    var response = await getWithUrl("$base_url/shipper-countries");
    if (response?.statusCode == 200) {
      var responseJson = countriesFromJson(response?.body);
      countries.value = responseJson!.countries;
      if (responseJson.countries.length > 0)
        selectedCountryCode(responseJson.countries[0]?.countryCode);
    }
  }

  @override
  void onInit() {
    fetchCountries();
    super.onInit();
  }

  var code;
  void fetchOTPSentData({required String countryCode}) async {
    try {
      mobile(phoneNumber.value.text);
      emailAddress(userName.value.text);

      isLoading(true);

      var data = await LoginAPi.loginData(
          countryCode: selectedCountryCode.value,
          mobile: "${phoneNumber.value.text}",
          email: userName.value.text,
          isEmail: isLoginWithUserName.value == 0 ? false : true);
      if (data != null) {
        if (data["message"] == "OK") {
          code = await SmsAutoFill().getAppSignature;

          Get.to(() => const OTPView());
          Get.snackbar("sendOtp".tr, "otpSent".tr,
              backgroundColor: primaryColor.withOpacity(0.6),
              colorText: whiteColor);
        } else {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Failed'.tr, LoginAPi.mass);
          }
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, LoginAPi.mass);
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
  fetchCheckLoginData(String otp) async {
    try {
      isLoading(true);
      var data = await LoginAPi.loginOtpData(
          otp,
          "$identifier",
          userName: userName.value.text,
          password: password.value.text,
          deviceName.value,
          countryCode: selectedCountryCode.value,
          email: emailAddress.value,
          isUserNAme: isLoginWithUserName.value == 0 ? false : true,
          mobile: mobile.value);
      // inspect(data);
      if (data != null) {
        if (data["success"] == "ok" || data["success"] == "OK") {
          Get.offAll(() => ControllerView());
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, LoginAPi.mass);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  valid({required String countryCode}) async {
    if (isLoginWithUserName > 0) {
      fetchCheckLoginData("");
    } else if (globalKey.currentState!.validate()) {
      fetchOTPSentData(countryCode: countryCode);
    }
  }

  mobileVild(x) {
    if (x.isEmpty) {
      return "please enter your mobile number";
    } else if (x.length <= 7) {
      return "number can not be smaller than 8";
    }
  }

  emailVild(x) {
    if (x.isEmpty) {
      return "please enter your email";
    }
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(x);
    if (!isValid) return "please enter a valid email";
  }

  emailUserName(x) {
    if (x.isEmpty) {
      return "please enter your email";
    }
  }

  emailPassword(x) {
    if (x.isEmpty) {
      return "please enter your password";
    }
  }

  RxString deviceName = '..'.obs;
  RxString enteredEmail = ''.obs;

  RxString identifier = '..'.obs;

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
