// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String success;
  Data data;

  Login({
    required this.success,
    required this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Store store;
  String accessToken;
  String tokenType;
  DateTime expiresAt;

  Data({
    required this.store,
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        store: Store.fromJson(json["store"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt.toIso8601String(),
      };
}

class Store {
  int id;
  int userId;
  String username;
  dynamic instagram;
  dynamic outMuscatPrice;
  dynamic inMuscatPrice;
  dynamic remoteAreaPrice;
  dynamic officePrice;
  dynamic image;
  dynamic shipperCode;
  dynamic companyName;
  dynamic ownerName;
  dynamic shipperEmail;
  dynamic contactOfc1;
  dynamic contactOfc2;
  dynamic shipperType;
  dynamic country;
  dynamic city;
  dynamic profilePic;
  String mobile;
  dynamic account;
  String storeCode;
  dynamic discount;
  dynamic lang;
  dynamic deliveryFee;
  dynamic collectionFee;
  String countryCode;

  String createdAt;
  String updatedAt;
  int invoiceDays;
  dynamic lastInvoiceDate;
  User user;

  Store({
    this.id = 0,
    this.userId = 0,
    this.username = "",
    this.instagram = "",
    this.outMuscatPrice = "",
    this.inMuscatPrice = "",
    this.remoteAreaPrice = "",
    this.officePrice = "",
    this.image = "",
    this.shipperCode = "",
    this.companyName = "",
    this.ownerName = "",
    this.shipperEmail = "",
    this.contactOfc1 = "",
    this.contactOfc2 = "",
    this.shipperType = "",
    this.country = "",
    this.city = "",
    this.profilePic = "",
    this.mobile = "",
    this.account = "",
    this.storeCode = "",
    this.discount,
    this.lang,
    this.deliveryFee,
    this.collectionFee,
    this.countryCode = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.invoiceDays = 0,
    this.lastInvoiceDate = '',
    required this.user,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        username: json["username"] ?? "",
        instagram: json["instagram"] ?? "",
        outMuscatPrice: json["out_muscat_price"] ?? "",
        inMuscatPrice: json["in_muscat_price"] ?? "",
        remoteAreaPrice: json["remote_area_price"] ?? "",
        officePrice: json["office_price"] ?? "",
        image: json["image"] ?? "",
        shipperCode: json["shipper_code"] ?? "",
        companyName: json["company_name"] ?? "",
        ownerName: json["owner_name"] ?? "",
        shipperEmail: json["shipper_email"] ?? "",
        contactOfc1: json["contact_ofc_1"] ?? "",
        contactOfc2: json["contact_ofc_2"] ?? "",
        shipperType: json["shipper_type"] ?? "",
        country: json["country"] ?? "",
        city: json["city"] ?? "",
        profilePic: json["profile_pic"] ?? "",
        mobile: json["mobile"] ?? "",
        account: json["account"] ?? "",
        storeCode: json["store_code"] ?? "",
        discount: json["discount"] ?? "",
        lang: json["lang"] ?? "",
        deliveryFee: json["delivery_fee"] ?? "",
        collectionFee: json["collection_fee"] ?? "",
        countryCode: json["country_code"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        invoiceDays: json["invoice_days"] ?? 0,
        lastInvoiceDate: json["last_invoice_date"] ?? "",
        user: User.fromJson(json["user"] ?? ""),
      );
}

class User {
  int id;
  int countryId;
  String name;
  dynamic fName;
  dynamic lName;
  dynamic phone;
  dynamic gender;
  String email;
  String deviceName;
  dynamic avatar;
  String lang;

  User({
    this.id = 0,
    this.countryId = 0,
    this.name = "",
    this.fName,
    this.lName,
    this.phone,
    this.gender,
    this.email = "",
    this.deviceName = "",
    this.avatar,
    this.lang = "",
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        countryId: json["country_id"] ?? 0,
        name: json["name"] ?? "",
        fName: json["f_name"] ?? "",
        lName: json["l_name"] ?? "",
        phone: json["phone"] ?? "",
        gender: json["gender"] ?? "",
        email: json["email"] ?? "",
        deviceName: json["device_name"] ?? "",
        avatar: json["avatar"] ?? "",
        lang: json["lang"] ?? "",
      );
}
