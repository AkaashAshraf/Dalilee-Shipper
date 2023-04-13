// To parse this JSON data, do
//
//     final accountManagerLogin = accountManagerLoginFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/aacount_manager/store.dart';
import 'package:dalile_customer/model/login_data_model.dart';

AccountManagerLogin accountManagerLoginFromJson(String str) =>
    AccountManagerLogin.fromJson(json.decode(str));

String accountManagerLoginToJson(AccountManagerLogin data) =>
    json.encode(data.toJson());

class AccountManagerLogin {
  AccountManagerLogin({
    this.success = "",
    this.data,
  });

  String success;
  Data? data;

  factory AccountManagerLogin.fromJson(Map<String, dynamic> json) =>
      AccountManagerLogin(
        success: json["success"] ?? "",
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.user,
    this.accessToken = "",
    this.tokenType = "",
    this.expiresAt = "",
    this.stores,
  });

  User? user;
  String accessToken;
  String tokenType;
  String expiresAt;
  List<Stores>? stores;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"] ?? "",
        tokenType: json["token_type"] ?? "",
        expiresAt: json["expires_at"] ?? "",
        stores: json["stores"] == null
            ? []
            : List<Stores>.from(json["stores"].map((x) => Stores.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stores": List<dynamic>.from(stores!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt,
      };
}
