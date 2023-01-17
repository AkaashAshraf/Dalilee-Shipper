import 'dart:convert';

import 'package:dalile_customer/model/shaheen_aws/shipment.dart';

ShipmentListAws? shipmentListAwsFromJson(String str) =>
    ShipmentListAws.fromJson(json.decode(str));

String shipmentListAwsToJson(ShipmentListAws? data) =>
    json.encode(data!.toJson());

class ShipmentListAws {
  ShipmentListAws({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  factory ShipmentListAws.fromJson(Map<String, dynamic> json) =>
      ShipmentListAws(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.totalShipments,
    required this.shipments,
  });

  int? totalShipments;
  List<Shipment> shipments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalShipments: json["total_shipments"],
        shipments: List<Shipment>.from(
            json["shipments"]!.map((x) => Shipment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_shipments": totalShipments,
        "shipments": List<dynamic>.from(shipments.map((x) => x.toJson())),
      };
}
