// To parse this JSON data, do
//
//     final pickupModel = pickupModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Pickup/reference.dart';

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
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.references,
  });

  List<Reference>? references;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        references: List<Reference>.from(
            json["references"].map((x) => Reference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "references": List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}
