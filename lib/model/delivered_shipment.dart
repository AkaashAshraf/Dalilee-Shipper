// To parse this JSON data, do
//
//     final DeliveredDashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/all_shipment.dart';

DeliveredDashbordModel dashbordDeliveredShipmentModelFromJson(String str) =>
    DeliveredDashbordModel.fromJson(json.decode(str));

String deliveredDashbordModelToJson(DeliveredDashbordModel data) =>
    json.encode(data.toJson());

class DeliveredDashbordModel {
  DeliveredDashbordModel({
    this.success,
    this.data,
  });

  String? success;
  DeliveredShipmentData? data;

  factory DeliveredDashbordModel.fromJson(Map<String, dynamic> json) =>
      DeliveredDashbordModel(
        success: json["success"],
        data: DeliveredShipmentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class DeliveredShipmentData {
  DeliveredShipmentData({
    this.totalShipments,
    this.deliveredShipment,
    this.trackingStatuses,
  });

  int? totalShipments;
  List<Shipment>? deliveredShipment;
  List<TrackingStatusDelivered>? trackingStatuses;

  factory DeliveredShipmentData.fromJson(Map<String, dynamic> json) =>
      DeliveredShipmentData(
        totalShipments: json["total_delivered_shipments"],
        deliveredShipment: List<Shipment>.from(
            json["delivered_shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusDelivered>.from(
            json["tracking_statuses"]
                .map((x) => TrackingStatusDelivered.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_delivered_shipments": totalShipments,
        "delivered_shipments":
            List<dynamic>.from(deliveredShipment!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class TrackingStatusDelivered {
  TrackingStatusDelivered({
    this.id,
    this.statusAr,
    this.statusEng,
    this.icon,
  });

  dynamic id;
  dynamic statusAr;
  dynamic statusEng;
  dynamic icon;

  factory TrackingStatusDelivered.fromJson(Map<String, dynamic> json) =>
      TrackingStatusDelivered(
        id: json["id"],
        statusAr: json["status_ar"],
        statusEng: json["status_eng"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_ar": statusAr,
        "status_eng": statusEng,
        "icon": icon,
      };
}
