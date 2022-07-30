// To parse this JSON data, do
//
//     final toBePickUpdashbordModel = toBePickUpdashbordModelFromJson(jsonString);

import 'dart:convert';

ToBePickUpdashbordModel toBePickUpdashbordModelFromJson(String str) =>
    ToBePickUpdashbordModel.fromJson(json.decode(str));

String toBePickUpdashbordModelToJson(ToBePickUpdashbordModel data) =>
    json.encode(data.toJson());

class ToBePickUpdashbordModel {
  ToBePickUpdashbordModel({
    this.success,
    this.data,
  });

  String? success;
  ToBePickupData? data;

  factory ToBePickUpdashbordModel.fromJson(Map<String, dynamic> json) =>
      ToBePickUpdashbordModel(
        success: json["success"],
        data: ToBePickupData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class ToBePickupData {
  ToBePickupData({
    this.totalToBePickups,
    this.toBePickups,
  });

  int? totalToBePickups;
  List<ToBePickup>? toBePickups;

  factory ToBePickupData.fromJson(Map<String, dynamic> json) => ToBePickupData(
        totalToBePickups: json["total_to_be_pickups"],
        toBePickups: List<ToBePickup>.from(
            json["to_be_pickups"].map((x) => ToBePickup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_to_be_pickups": totalToBePickups,
        "to_be_pickups":
            List<dynamic>.from(toBePickups!.map((x) => x.toJson())),
      };
}

class ToBePickup {
  ToBePickup({
    this.id,
    this.date,
    this.cop,
    this.driver,
    this.quantity,
    this.phone,
    this.status
  });

  dynamic id;
  dynamic date;
  dynamic cop;
  dynamic driver;
  dynamic quantity;
  dynamic phone;
  dynamic status;

  factory ToBePickup.fromJson(Map<String, dynamic> json) => ToBePickup(

        id: json["id"],
        date: json["date"],
        cop: json["cop"],
        driver: json["driver"],
        quantity: json["quantity"],
        phone: json["phone"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "cop": cop,
        "driver": driver,
        "quantity": quantity,
        "phone": phone,
        "status":status,
      };
}
