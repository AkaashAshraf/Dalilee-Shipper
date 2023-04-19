// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.storeName,
    this.storeUsername,
    this.storeEmail,
    this.storeMobile,
    this.latitude,
    this.longitude,
    this.payable = false,
    this.instagramLink,
    this.storeImage,
    this.createdAt,
  });

  String? storeName;
  String? storeUsername;
  String? storeEmail;
  String? storeMobile;
  String? storeImage;
  String? latitude;
  String? longitude;
  bool payable;
  String? instagramLink;

  String? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        storeName: json["store_name"],
        payable: json["payable"],
        storeUsername: json["store_username"],
        storeEmail: json["store_email"],
        latitude: json["store_lat"],
        longitude: json["store_lng"],
        instagramLink: json["store_instagram"],
        storeMobile: json["store_mobile"],
        storeImage: json["store_image"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "store_name": storeName,
        "payable": payable,
        "store_instagram": instagramLink,
        "store_lat": latitude,
        "store_lng": longitude,
        "store_username": storeUsername,
        "store_email": storeEmail,
        "store_mobile": storeMobile,
        "store_image": storeImage,
        "created_at": createdAt,
      };
}
