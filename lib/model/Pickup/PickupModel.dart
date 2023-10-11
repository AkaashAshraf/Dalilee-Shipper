// To parse this JSON data, do
//
//     final pickupModel = pickupModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Pickup/reference.dart';
import 'package:dalile_customer/model/all_pickup_model.dart';

PickupModel pickupModelFromJson(String str) =>
    PickupModel.fromJson(json.decode(str));

String pickupModelToJson(PickupModel data) => json.encode(data.toJson());

class PickupModel {
  PickupModel({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory PickupModel.fromJson(Map<String, dynamic> json) => PickupModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.totalReferences,
    this.references,
  });

  int? totalReferences;
  List<Reference>? references;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalReferences:
            json["total_references"] == null ? null : json["total_references"],
        references: json["references"] == null
            ? null
            : List<Reference>.from(
                json["references"].map((x) => Reference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_references": totalReferences == null ? null : totalReferences,
        "references": references == null
            ? null
            : List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}
