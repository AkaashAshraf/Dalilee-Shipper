import 'dart:convert';
import 'dart:developer';

import 'package:dalile_customer/config/storag_paths.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/aacount_manager/login.dart';
import 'package:dalile_customer/model/aacount_manager/store.dart';
import 'package:dalile_customer/model/aacount_manager/stores_list.dart';
import 'package:dalile_customer/model/login_data_model.dart';
import 'package:dalile_customer/view/account_manager/choose_store_view.dart';
import 'package:dalile_customer/view/widget/controller_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountManagerController extends GetxController {
  RxBool loading = false.obs;
  RxString email = "".obs;
  RxString password = "".obs;
  Rx<Stores> selectedStore = Stores().obs;
  RxList<Stores> stores = <Stores>[].obs;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  passwordValid(x) {
    if (x.isEmpty) {
      return "please enter password";
    }
  }

  @override
  void onInit() {
    fetchStores();
    super.onInit();
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

  login() async {
    // try {
    loading(true);
    var res = await postAccountManager("$accountManagerBaseUrl/login",
        {"email": email.value, "password": password.value},
        isLogin: true);
    // inspect(res);
    if (res != null) {
      var jsonResponse = accountManagerLoginFromJson(res?.body);
      final prefs = await SharedPreferences.getInstance();
      stores(jsonResponse.data?.stores);
      prefs.setString(
          accountManagerToken, jsonResponse.data?.accessToken ?? "");
      prefs.setString(accountManagerName, jsonResponse.data?.user?.name ?? "");

      prefs.setString(
          accountManagerUserID, jsonResponse.data?.user?.id.toString() ?? "");
      prefs.setString(
          accountManagerData, accountManagerLoginToJson(jsonResponse));
      Get.snackbar('Success', "Logged In Successfully",
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: whiteColor);
      Get.to(ChooseStoreView());
    } else {
      Get.snackbar('Error', "Invalid email/password",
          backgroundColor: Colors.red.withOpacity(0.8), colorText: whiteColor);
    }
    loading(false);
    // } catch (e) {
    //   inspect(e);
    //   Get.snackbar('Error', "Invalid email/password",
    //       backgroundColor: Colors.red.withOpacity(0.8), colorText: whiteColor);
    //   // inspect(e);
    // } finally {
    //   loading(false);
    // }
  }

  fetchStores() async {
    // try {
    var res = await getAccountManager("$accountManagerBaseUrl/stores");
    // inspect(res);
    if (res != null) {
      var jsonResponse = storesListFromJson(res?.body);
      stores(jsonResponse.data?.stores);
    }
  }

  fetchStoreToken(String storeID) async {
    // try {
    loading(true);
    var response = await postAccountManager(
        "$accountManagerBaseUrl/generate-store-token", {"store_id": storeID});
    inspect(response);
    if (response.statusCode == 200) {
      // if (response["success"] == "OK" || response["success"] == "ok")
      if (true) {
        _saveProduct(response.body, "loginData");
        final token = json.decode(response.body);
        print(token['data']['store']['username']);
        // return null;
        _saveProduct(token['data']["access_token"] ?? "", "token");
        _saveProduct(token['data']['store']["mobile"] ?? "", "mobile");
        _saveProduct(token['data']['store']["store_code"] ?? "", "store_code");

        _saveProduct(token['data']['store']['username'], "username");
        _saveProduct(token['data']['store']['user']["name"] ?? "", "name");
        loading(false);
        Get.offAll(ControllerView());
        return response;
      } else {
        // mass = response['message'] ?? "please try agian later";

        return null;
      }
    }
    loading(false);
  }

  static _saveProduct(String jsonTO, String name) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(name, jsonTO);
  }
}
