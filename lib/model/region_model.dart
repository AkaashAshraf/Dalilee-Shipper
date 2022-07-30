// To parse this JSON Regions, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) =>
    RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  RegionModel({
    this.success,
    this.data,
  });

  String? success;
  Regions? data;

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        success: json["success"],
        data: Regions.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Regions {
  Regions({
    this.areaRegions,
  });

  List<AreaRegion>? areaRegions;

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
        areaRegions: List<AreaRegion>.from(
            json["areas"].map((x) => AreaRegion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areas": List<dynamic>.from(areaRegions!.map((x) => x.toJson())),
      };
}

class AreaRegion {
  AreaRegion({
    required this.id,
    required this.name,
    this.nameAr,
    this.wilayaId,
    this.branchId,
    this.shipPrice,
    this.delFlag,
    this.code,
    this.discount,
  });

  int id;
  String name;
  String? nameAr;
  int? wilayaId;
  int? branchId;
  String? shipPrice;
  dynamic delFlag;
  String? code;
  dynamic discount;

  factory AreaRegion.fromJson(Map<String, dynamic> json) => AreaRegion(
        id: json["id"],
        name: json["name"],
        nameAr: json["name_ar"],
        wilayaId: json["wilaya_id"],
        branchId: json["branch_id"],
        shipPrice: json["ship_price"],
        delFlag: json["del_flag"],
        code: json["code"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "wilaya_id": wilayaId,
        "branch_id": branchId,
        "ship_price": shipPrice,
        "del_flag": delFlag,
        "code": code,
        "discount": discount,
      };
}
