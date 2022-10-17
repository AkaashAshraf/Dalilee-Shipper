// To parse this JSON data, do
//
//     final wilayasModel = wilayasModelFromJson(jsonString);

import 'dart:convert';

WilayasModel wilayasModelFromJson(String str) =>
    WilayasModel.fromJson(json.decode(str));

String wilayasModelToJson(WilayasModel data) => json.encode(data.toJson());

class WilayasModel {
  WilayasModel({
    required this.success,
    required this.data,
  });

  String success;
  DataWilaya data;

  factory WilayasModel.fromJson(Map<String, dynamic> json) => WilayasModel(
        success: json["success"],
        data: DataWilaya.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class DataWilaya {
  DataWilaya({
    this.wilayaOMs,
    this.areas,
  });

  List<WilayaOM>? wilayaOMs;
  List<Area>? areas;

  factory DataWilaya.fromJson(Map<String, dynamic> json) => DataWilaya(
        wilayaOMs: List<WilayaOM>.from(
            json["wilayas"].map((x) => WilayaOM.fromJson(x))),
        areas: json["areas"] == null
            ? []
            : List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wilayas": List<dynamic>.from(wilayaOMs!.map((x) => x.toJson())),
        "areas": areas == null
            ? []
            : List<dynamic>.from(areas!.map((x) => x.toJson())),
      };
}

class WilayaOM {
  WilayaOM({
    required this.id,
    required this.name,
    this.code,
    required this.governateId,
    required this.branchId,
  });

  int id;
  String name;
  String? code;
  int governateId;
  int branchId;

  factory WilayaOM.fromJson(Map<String, dynamic> json) => WilayaOM(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        code: json["code"] ?? "",
        governateId: json["governate_id"] ?? 0,
        branchId: json["branch_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "governate_id": governateId,
        "branch_id": branchId,
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.nameAr,
    this.wilayaId,
    this.branchId,
  });

  int? id;
  String? name;
  String? nameAr;
  int? wilayaId;
  int? branchId;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? "" : json["name"],
        nameAr: json["name_ar"],
        wilayaId: json["wilaya_id"] == null ? 0 : json["wilaya_id"],
        branchId: json["branch_id"] == null ? 0 : json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "wilaya_id": wilayaId,
        "branch_id": branchId,
      };
}
