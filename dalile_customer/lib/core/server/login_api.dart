import 'dart:convert';
import 'package:dalile_customer/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

 class LoginAPi {
  static String mass = 'please try agian later';

  static Future loginData(String mobile) async {
    try {
      final url = Uri.parse("$like/send-otp");
      final data = {'mobile': mobile};
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

  static Future loginOtpData(
      String mobile, String otpnum, String dId, String dName) async {
    try {
      var url = Uri.parse("$like/login");
      var data = {
        "mobile": mobile,
        "code": otpnum,
        "device_id": dId,
        "device_name": dName
      };
      var headers = {"Accept": "application/json"};
      final response = await http.post(url, headers: headers, body: data);
      var res = json.decode(response.body);

      if (response.statusCode == 200) {
        if (res["success"] == "OK" || res["success"] == "ok") {
          _saveProduct(response.body, "loginData");
          final token = json.decode(response.body);
        
          _saveProduct(token['data']["access_token"], "token");
          return res;
        } else {
          mass = res['message'] ?? "please try agian later";

          return null;
        }
      }
      mass = res['message'] ?? "please try agian later";
    } catch (e) {
      mass = 'Network error';
    }
  }

  static _saveProduct(String jsonTO, String name) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(name, jsonTO);
  }
}
