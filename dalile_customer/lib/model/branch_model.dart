// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'dart:convert';

BranchListModel branchListModelFromJson(String str) =>
    BranchListModel.fromJson(json.decode(str));

String branchListModelToJson(BranchListModel data) =>
    json.encode(data.toJson());

class BranchListModel {
  BranchListModel({
    this.success,
    this.data,
  });

  String? success;
  BData? data;

  factory BranchListModel.fromJson(Map<String, dynamic> json) =>
      BranchListModel(
        success: json["success"],
        data: BData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class BData {
  BData({
    this.branches,
  });

  List<Branch>? branches;

  factory BData.fromJson(Map<String, dynamic> json) => BData(
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branches": List<dynamic>.from(branches!.map((x) => x.toJson())),
      };
}

class Branch {
  Branch(
      {this.id,
      this.name,
      this.nameAr,
      this.createdBy,
      this.branchStatus,
      this.deviceId,
      this.branchCode,
      this.lat,
      this.lng,
      this.ip,
      this.phone,
      this.image});

  dynamic id;
  String? name;
  String? nameAr;
  String? phone;
  String? image;
  dynamic createdBy;
  dynamic branchStatus;
  String? deviceId;
  String? branchCode;
  String? lat;
  String? lng;
  String? ip;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        nameAr: json["name_ar"],
        createdBy: json["created_by"],
        phone: json["phone"],
        image: json["image"],
        branchStatus: json["branch_status"],
        deviceId: json["device_id"],
        branchCode: json["branch_code"],
        lat: json["lat"] ?? "0",
        lng: json["lng"] ?? "0",
        ip: json["ip"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "created_by": createdBy,
        "phone": phone,
        "image": image,
        "branch_status": branchStatus,
        "device_id": deviceId,
        "branch_code": branchCode,
        "lat": lat,
        "lng": lng,
        "ip": ip,
      };
}
