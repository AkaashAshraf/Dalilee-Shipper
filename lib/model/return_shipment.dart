// To parse this JSON data, do
//
//     final DeliveredDashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/all_shipment.dart';

RetrunDashbordModel dashbordRetrunShipmentModelFromJson(String str) =>
    RetrunDashbordModel.fromJson(json.decode(str));

String retrunDashbordModelToJson(RetrunDashbordModel data) =>
    json.encode(data.toJson());

class RetrunDashbordModel {
  RetrunDashbordModel({
    this.success,
    this.data,
  });

  String? success;
  RetrunShipmentData? data;

  factory RetrunDashbordModel.fromJson(Map<String, dynamic> json) =>
      RetrunDashbordModel(
        success: json["success"],
        data: RetrunShipmentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class RetrunShipmentData {
  RetrunShipmentData({
    this.totalShipments,
    this.retrunShipment,
    this.trackingStatuses,
  });

  int? totalShipments;
  List<Shipment>? retrunShipment;
  List<TrackingStatusRetrun>? trackingStatuses;

  factory RetrunShipmentData.fromJson(Map<String, dynamic> json) =>
      RetrunShipmentData(
        totalShipments: json["total_returned_shipments"],
        retrunShipment: List<Shipment>.from(
            json["return_shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusRetrun>.from(
            json["tracking_statuses"]
                .map((x) => TrackingStatusRetrun.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_delivered_shipments": totalShipments,
        "return_shipments":
            List<dynamic>.from(retrunShipment!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class TrackingStatusRetrun {
  TrackingStatusRetrun({
    this.id,
    this.statusAr,
    this.statusEng,
    this.icon,
  });

  dynamic id;
  dynamic statusAr;
  dynamic statusEng;
  dynamic icon;

  factory TrackingStatusRetrun.fromJson(Map<String, dynamic> json) =>
      TrackingStatusRetrun(
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
