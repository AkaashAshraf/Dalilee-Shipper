// To parse this JSON data, do
//
//     final pickupModel = pickupModelFromJson(jsonString);

import 'dart:convert';

PickupModel pickupModelFromJson(String str) => PickupModel.fromJson(json.decode(str));

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
        references: List<Reference>.from(json["references"].map((x) => Reference.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "references": List<dynamic>.from(references!.map((x) => x.toJson())),
    };
}

class Reference {
    Reference({
        this.id,
        this.cop,
        this.location,
        this.totalOrders,
        this.collectionDate,
        this.status,
        this.driverName,
        this.driveMobile,
    });

    dynamic id;
    dynamic cop;
    dynamic location;
    dynamic totalOrders;
    dynamic collectionDate;
    dynamic status;
    dynamic driverName;
    dynamic driveMobile;

    factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        id: json["id"],
        cop: json["cop"],
        location: json["location"],
        totalOrders: json["total_orders"],
        collectionDate: json["collection_date"],
        status: json["status"],
        driverName: json["driver_name"],
        driveMobile: json["drive_mobile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cop": cop,
        "location": location,
        "total_orders": totalOrders,
        "collection_date": collectionDate,
        "status": status,
        "driver_name": driverName,
        "drive_mobile": driveMobile,
    };
}
