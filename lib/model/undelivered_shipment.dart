// To parse this JSON data, do
//
//     final unDeliveredDashbordModel = unDeliveredDashbordModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

UnDeliveredDashbordModel unDeliveredDashbordModelFromJson(String str) =>
    UnDeliveredDashbordModel.fromJson(json.decode(str));

String unDeliveredDashbordModelToJson(UnDeliveredDashbordModel data) =>
    json.encode(data.toJson());

class UnDeliveredDashbordModel {
  UnDeliveredDashbordModel({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory UnDeliveredDashbordModel.fromJson(Map<String, dynamic> json) =>
      UnDeliveredDashbordModel(
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
    this.totalUndeliveredShipments,
    this.undeliveredShipments,
    this.trackingStatuses,
  });

  int? totalUndeliveredShipments;
  List<Shipment>? undeliveredShipments;
  List<TrackingStatus>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalUndeliveredShipments: json["total_undelivered_shipments"],
        undeliveredShipments: List<Shipment>.from(
            json["undelivered_shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_undelivered_shipments": totalUndeliveredShipments,
        "undelivered_shipments":
            List<dynamic>.from(undeliveredShipments!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}
