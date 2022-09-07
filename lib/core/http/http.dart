import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<dynamic> get(String url) async {
  var _url = like + url;
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';

  try {
    var response = await http.get(Uri.parse(_url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    print(response.body);
    // return response.statusCode;
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => LoginView());
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

  try {
    var response = await http.post(Uri.parse(_url), body: body, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    // return response.body;
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      prefs.remove("loginData");
      prefs.remove("token");
      prefs.clear();
      Get.deleteAll();
      Get.offAll(() => LoginView());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<dynamic> multirequestPost(dynamic request) async {
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';
  try {
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = "Bearer $token";
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
      Get.offAll(() => LoginView());
      return null;
    } else {
      return null;
    }
  } catch (e) {
    // print('object');
    return null;
  }
}
