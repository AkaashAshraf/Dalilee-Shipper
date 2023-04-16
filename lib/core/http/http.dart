import 'dart:developer';

import 'package:dalile_customer/config/storag_paths.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/model/aacount_manager/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<dynamic> get(String url) async {
  var _url = like + url;
  print(_url);
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';
  String managerToken = prefs.getString(accountManagerToken) ?? '';

  try {
    var response = await http.get(Uri.parse(_url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "ManagerToken": "Bearer $managerToken"
    });
    // return response;

    // print(response.body);
    // return response.statusCode;
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    return e;
  }
}

Future<dynamic> getWithUrl(String url) async {
  var _url = url;
  // print(_url);
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';
  String managerToken = prefs.getString(accountManagerToken) ?? '';

  try {
    var response = await http.get(Uri.parse(_url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "ManagerToken": "Bearer $managerToken"
    });
    // print(response.body);
    // return response.statusCode;
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    return e;
  }
}

Future<dynamic> post(String url, dynamic body) async {
  var _url = like + url;
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';
  String managerToken = prefs.getString(accountManagerToken) ?? '';
  print(accountManagerToken);
  try {
    var response = await http.post(Uri.parse(_url), body: body, headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
      "ManagerToken": "Bearer $managerToken"
    });
    // return _url;
    // print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return response.statusCode;
    } else {
      return response;
    }
  } catch (e) {
    print(e.toString());

    return null;
  }
}

Future<dynamic> getAccountManager(String url) async {
  var _url = url;
  // print(_url);
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString(accountManagerToken) ?? '';
  String managerToken = prefs.getString(accountManagerToken) ?? '';

  try {
    var response = await http.get(Uri.parse(_url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "ManagerToken": "Bearer $managerToken"
    });
    // inspect(response);
    // return response;

    // print(response.body);
    // return response.statusCode;
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    inspect(e);
    return e;
  }
}

Future<dynamic> postAccountManager(String url, dynamic body,
    {bool isLogin = false}) async {
  var _url = url;
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString(accountManagerToken) ?? '';
  String managerToken = prefs.getString(accountManagerToken) ?? '';

  // print(token);
  try {
    // inspect(body);
    var response = await http.post(Uri.parse(_url), body: body, headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
      "ManagerToken": "Bearer $managerToken"
    });
    // return _url;
    inspect(response);
    // print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401 && !isLogin) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return response.statusCode;
    } else {
      return null;
    }
  } catch (e) {
    inspect(e);
    // print(e.toString());

    return null;
  }
}

Future<dynamic> postWithJsonBody(String url, dynamic body) async {
  var _url = like + url;
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';
  String managerToken = prefs.getString(accountManagerToken) ?? '';

  try {
    var response = await http.post(Uri.parse(_url), body: body, headers: {
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
      "ManagerToken": "Bearer $managerToken"
    });
    // inspect(response);
    // Get.snackbar('Successfull', response.statusCode.toString());
    // return response;
    // return response.body;
    // print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    // return e.toString;
    // Get.snackbar(e.toString(), " ", colorText: Colors.orange);
    print(e.toString());
    return null;
  }
}

Future<dynamic> multirequestPost(dynamic request) async {
  final prefs = await SharedPreferences.getInstance();
  String managerToken = prefs.getString(accountManagerToken) ?? '';

  String token = prefs.getString('token') ?? '';
  try {
    request.headers['Accept'] = 'application/json';

    request.headers['Authorization'] = "Bearer $token";
    request.headers['ManagerToken'] = "Bearer $managerToken";
    var res = await request.send();
    var resData = await res.stream.toBytes();
    var f_res = String.fromCharCodes(resData);
    // print(request);
    // return f_res.toString();
    // return response.body;
    if (res.statusCode == 200) {
      return f_res;
    } else if (res.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => AccountManagerLogin());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    // print('object');
    return null;
  }
}
