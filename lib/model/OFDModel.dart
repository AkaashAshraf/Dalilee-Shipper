// To parse this JSON data, do
//
//     final ofdModel = ofdModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

OfdModel ofdModelFromJson(String str) => OfdModel.fromJson(json.decode(str));

String ofdModelToJson(OfdModel data) => json.encode(data.toJson());

class OfdModel {
  OfdModel({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory OfdModel.fromJson(Map<String, dynamic> json) => OfdModel(
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
    this.totalOfdShipments,
    this.ofdShipments,
    this.trackingStatuses,
  });

  int? totalOfdShipments;
  List<Shipment>? ofdShipments;
  List<TrackingStatus>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOfdShipments: json["total_ofd_shipments"],
        ofdShipments: List<Shipment>.from(
            json["ofd_shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_ofd_shipments": totalOfdShipments,
        "ofd_shipments":
            List<Shipment>.from(ofdShipments!.map((x) => x.toJson())),
        "tracking_statuses":
            List<TrackingStatus>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}
