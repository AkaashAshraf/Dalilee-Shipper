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
  });

  List<WilayaOM>? wilayaOMs;

  factory DataWilaya.fromJson(Map<String, dynamic> json) => DataWilaya(
        wilayaOMs: List<WilayaOM>.from(
            json["wilayas"].map((x) => WilayaOM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wilayas": List<dynamic>.from(wilayaOMs!.map((x) => x.toJson())),
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
        id: json["id"],
        name: json["name"],
        code: json["code"],
        governateId: json["governate_id"],
        branchId: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "governate_id": governateId,
        "branch_id": branchId,
      };
}
