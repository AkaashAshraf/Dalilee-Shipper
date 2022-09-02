import 'dart:convert';

import 'package:dalile_customer/model/all_shipment.dart';

FinanceListing financeListingFromJson(String str) =>
    FinanceListing.fromJson(json.decode(str));

String financeListingToJson(FinanceListing data) => json.encode(data.toJson());

class FinanceListing {
  FinanceListing({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory FinanceListing.fromJson(Map<String, dynamic> json) => FinanceListing(
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
    this.totalShipments,
    this.shipments,
    this.trackingStatuses,
  });

  int? totalShipments;
  List<Shipment>? shipments;
  List<TrackingStatus>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalShipments: json["total_shipments"],
        shipments: List<Shipment>.from(
            json["shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_shipments": totalShipments,
        "shipments": List<dynamic>.from(shipments!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class OrderActivity {
  OrderActivity({
    this.id,
    this.description,
    this.externalText,
    this.shortText,
    this.internalText,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic description;
  String? externalText;
  String? shortText;
  String? internalText;
  dynamic createdAt;
  dynamic updatedAt;

  factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        id: json["id"],
        description: json["description"],
        externalText: json["external_text"],
        shortText: json["short_text"],
        internalText: json["internal_text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "external_text": externalText,
        "short_text": shortText,
        "internal_text": internalText,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
