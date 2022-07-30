// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    this.message,
    this.otp,
    this.request,
  });

  String? message;
  int? otp;
  Request? request;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        message: json["message"],
        otp: json["otp"],
        request: Request.fromJson(json["request"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "otp": otp,
        "request": request!.toJson(),
      };
}

class Request {
  Request({
    this.mobile,
  });

  String? mobile;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}
