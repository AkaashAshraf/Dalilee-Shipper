import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static bool _isLogin = false;
  static bool get isL => _isLogin;
  static Future isLoginUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      dynamic fromString = prefs.getString('loginData') ?? null;

      dynamic resLogin = json.decode(fromString!.toString()) ?? null;

      dynamic tokenLo = resLogin['data']["access_token"] ?? null;

      if (tokenLo != null) {
        _isLogin = true;

        return;
      } else {
        _isLogin = false;
      }

      return;
    } catch (e) {
      _isLogin = false;
      return;
    }
  }
}
