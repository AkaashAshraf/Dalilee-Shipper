import 'package:dalile_customer/components/popups/askOtp.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/core/server/login_api.dart';
import 'package:dalile_customer/model/Profile/profile.dart';
// import 'package:dalile_customer/model/Profile/profile.dart';
import 'package:dalile_customer/model/Profile/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  Rx<Data> profile = new Data().obs;

  RxBool profileLoading = false.obs;
  RxBool isEditinig = false.obs;
  RxBool askOtp = false.obs;
  Rx<XFile> image = XFile('').obs;
  Data oldProfile = new Data();
  String mobile = "";
  String email = "";
  String name = "";

  RxString sentOtp = '1234'.obs;
  RxString enteredOtp = ''.obs;

  @override
  void onInit() async {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    try {
      profileLoading(true);
      var res = await post('/profile', {});
      // print(res);
      if (res != null) {
        var _profile = profileFromJson(res.body);
        // print(_profile.data!.storeMobile);
        mobile = _profile.data!.storeMobile.toString();
        name = _profile.data!.storeName.toString();
        email = _profile.data!.storeEmail.toString();

        profile.value = _profile.data!;
      } //if
    } //try
    catch (e) {
    } finally {
      profileLoading(false);
    } //catch
  } //get profile

  updateProfile() async {
    try {
      profileLoading(true);
      isEditinig(false);

      var request =
          http.MultipartRequest('POST', Uri.parse(like + '/profile/update'));
      request.fields['email'] = profile.value.storeEmail.toString();
      request.fields['mobile'] = profile.value.storeMobile.toString();
      request.fields['name'] = profile.value.storeName.toString();

      // print(request);

      try {
        if (image.value.path != null) {
          http.MultipartFile multipartFile =
              await http.MultipartFile.fromPath('image', image.value.path);
          request.files.add(multipartFile);
        }
      } catch (e) {}
      var res = await multirequestPost(request);
      if (res != null) {
        var _profile = updateProfileFromJson(res);

        profile.value = _profile.data!;
        mobile = _profile.data!.storeMobile.toString();
        name = _profile.data!.storeName.toString();
        email = _profile.data!.storeEmail.toString();
        sentOtp.value = '';
        enteredOtp.value = '';

        image.value = XFile('');
        Get.snackbar('Data Updated', "Your information has been updated",
            backgroundColor: primaryColor.withOpacity(0.6),
            colorText: whiteColor);
      } //if
      return true;
    } //try
    catch (e) {
      print(e);
      Get.snackbar(
          'Error', "This mobile number is already registered" + e.toString(),
          backgroundColor: Colors.red.withOpacity(0.8), colorText: whiteColor);
      isEditinig(true);
      profileLoading(false);

      return false;
    } finally {
      profileLoading(false);
    } //catch
  } //get profile

  sendOTP(BuildContext context) async {
    profileLoading(true);

    try {
      var data = await LoginAPi.sendOtpGeneral(profile.value.storeMobile!);

      sentOtp.value = data['otp'].toString();
      Get.snackbar('Send OTP', "OTP Sent Successfully",
          backgroundColor: primaryColor.withOpacity(0.8),
          colorText: whiteColor);
      otp_modal(context).show();
    } catch (e) {
      profileLoading(false);

      sentOtp.value = "";
    } finally {
      profileLoading(false);
    }
  } //send OTP

}
