import 'dart:convert';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/login_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginAPi {
  static String mass = 'please try agian later';

  static Future loginData(
      {required String mobile,
      required String email,
      required String countryCode,
      bool isEmail: false}) async {
    try {
      final url =
          Uri.parse(isEmail ? "$like/send-otp-email" : "$like/send-otp");
      var data = {'mobile': mobile, "country_code": countryCode};
      if (isEmail) data = {'email': email};
      final headers = {"Accept": "application/json"};
      final response = await http.post(url, headers: headers, body: data);
      final res = json.decode(response.body);
      if (response.statusCode == 200) {
        if (res["message"] != null && res["message"] == "OK") {
          String tostring = res["otp"].toString();
          _saveProduct(tostring, "otp");
          return res;
        } else {
          mass = res['message'];
          return null;
        }
      }

      mass = res['message'];
    } catch (e) {
      mass = 'Network error';
    }
  }

  static Future sendOtpGeneral(String mobile) async {
    try {
      final url = Uri.parse("$like/send-otp-general");
      final data = {'mobile': mobile};
      final headers = {"Accept": "application/json"};
      final response = await http.post(url, headers: headers, body: data);
      final res = json.decode(response.body);
      if (response.statusCode == 200) {
        if (res["message"] != null && res["message"] == "OK") {
          return res;
        } else {
          mass = res['message'];
          return null;
        }
      }
      mass = res['message'];
    } catch (e) {
      mass = 'Network error';
    }
  }

  static Future loginOtpData(String otpnum, String dId, String dName,
      {required String email,
      required String countryCode,
      required String mobile,
      bool isEmail: false}) async {
    // print(Get.put(LoginController()).mobile.value +
    //     "-" +
    //     Get.put(LoginController()).emailAddress.value);

    try {
      var url = Uri.parse(isEmail ? "$like/login-with-email" : "$like/login");

      String? token = await FirebaseMessaging.instance.getToken();

      // print("fcm:$token");
      var data = {
        "mobile": mobile,
        "country_code": countryCode,
        "email": email,
        "code": otpnum,
        "device_id": dId,
        "device_name": dName,
        "fcm_token": token
      };

      // print(data);
      var headers = {"Accept": "application/json"};
      final response = await http.post(url, headers: headers, body: data);
      var res = json.decode(response.body);

      if (response.statusCode == 200) {
        if (res["success"] == "OK" || res["success"] == "ok") {
          _saveProduct(response.body, "loginData");
          final token = json.decode(response.body);
          print(token['data']['store']['username']);
          // return null;
          _saveProduct(token['data']["access_token"] ?? "", "token");
          _saveProduct(token['data']['store']["mobile"] ?? "", "mobile");
          _saveProduct(
              token['data']['store']["store_code"] ?? "", "store_code");

          _saveProduct(token['data']['store']['username'], "username");
          _saveProduct(token['data']['store']['user']["name"] ?? "", "name");

          return res;
        } else {
          mass = res['message'] ?? "please try agian later";

          return null;
        }
      }
      mass = res['message'] ?? "please try agian later";
    } catch (e) {
      mass = 'Network error' + e.toString();
    }
  }

  static _saveProduct(String jsonTO, String name) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(name, jsonTO);
  }
}
