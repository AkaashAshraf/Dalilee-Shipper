// To parse this JSON LoginData, do
//
//     final logindataModel = logindataModelFromJson(jsonString);

import 'dart:convert';

LogindataModel logindataModelFromJson(String str) =>
    LogindataModel.fromJson(json.decode(str));

String logindataModelToJson(LogindataModel data) => json.encode(data.toJson());

class LogindataModel {
  LogindataModel({
    this.success,
    this.data,
  });

  String? success;
  LoginData? data;

  factory LogindataModel.fromJson(Map<String, dynamic> json) => LogindataModel(
        success: json["success"],
        data: LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class LoginData {
  LoginData({
    this.store,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
  });

  Store? store;
  String? accessToken;
  String? tokenType;
  DateTime? expiresAt;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        store: Store.fromJson(json["store"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "store": store!.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt!.toIso8601String(),
      };
}

class Store {
  Store({
    this.id,
    this.userId,
    this.wilayaId,
    this.areaId,
    this.packageId,
    this.locationPoint,
    this.mobile,
    this.account,
    this.storeCode,
    this.hide,
    this.discount,
    this.lang,
    this.deliveryFee,
    this.collectionFee,
    this.countryCode,
    this.tripStatus,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.user,
  });

  dynamic id;
  dynamic userName;
  dynamic userId;
  dynamic wilayaId;
  dynamic areaId;
  dynamic packageId;
  dynamic locationPoint;
  dynamic mobile;
  dynamic account;
  dynamic storeCode;
  dynamic hide;
  dynamic discount;
  dynamic lang;
  dynamic deliveryFee;
  dynamic collectionFee;
  dynamic countryCode;
  dynamic tripStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        userName: json['username'],
        userId: json["user_id"],
        wilayaId: json["wilaya_id"],
        areaId: json["area_id"],
        packageId: json["package_id"],
        locationPoint: json["location_point"],
        mobile: json["mobile"],
        account: json["account"],
        storeCode: json["store_code"],
        hide: json["hide"],
        discount: json["discount"],
        lang: json["lang"],
        deliveryFee: json["delivery_fee"],
        collectionFee: json["collection_fee"],
        countryCode: json["country_code"],
        tripStatus: json["trip_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": userName,
        "user_id": userId,
        "wilaya_id": wilayaId,
        "area_id": areaId,
        "package_id": packageId,
        "location_point": locationPoint,
        "mobile": mobile,
        "account": account,
        "store_code": storeCode,
        "hide": hide,
        "discount": discount,
        "lang": lang,
        "delivery_fee": deliveryFee,
        "collection_fee": collectionFee,
        "country_code": countryCode,
        "trip_status": tripStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.activeStatus,
    this.branchId,
    this.shiftId,
    this.darkMode,
    this.messengerColor,
    this.emailVerifiedAt,
    this.plan,
    this.planExpireDate,
    this.type,
    this.avatar,
    this.lang,
    this.createdBy,
    this.defaultPipeline,
    this.deleteStatus,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic activeStatus;
  dynamic branchId;
  dynamic shiftId;
  dynamic darkMode;
  dynamic messengerColor;
  DateTime? emailVerifiedAt;
  dynamic plan;
  dynamic planExpireDate;
  dynamic type;
  dynamic avatar;
  dynamic lang;
  dynamic createdBy;
  dynamic defaultPipeline;
  dynamic deleteStatus;
  dynamic isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic profile;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        activeStatus: json["active_status"],
        branchId: json["branch_id"],
        shiftId: json["shift_id"],
        darkMode: json["dark_mode"],
        messengerColor: json["messenger_color"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        plan: json["plan"],
        planExpireDate: json["plan_expire_date"],
        type: json["type"],
        avatar: json["avatar"],
        lang: json["lang"],
        createdBy: json["created_by"],
        defaultPipeline: json["default_pipeline"],
        deleteStatus: json["delete_status"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "active_status": activeStatus,
        "branch_id": branchId,
        "shift_id": shiftId,
        "dark_mode": darkMode,
        "messenger_color": messengerColor,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "plan": plan,
        "plan_expire_date": planExpireDate,
        "type": type,
        "avatar": avatar,
        "lang": lang,
        "created_by": createdBy,
        "default_pipeline": defaultPipeline,
        "delete_status": deleteStatus,
        "is_active": isActive,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "profile": profile,
      };
}
