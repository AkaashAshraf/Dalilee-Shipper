// To parse this JSON data, do
//
//     final CancelldashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

CancellDashbordModel dashbordCancellModelFromJson(String str) =>
    CancellDashbordModel.fromJson(json.decode(str));

String cancelldashbordModelToJson(CancellDashbordModel data) =>
    json.encode(data.toJson());

class CancellDashbordModel {
  CancellDashbordModel({
    this.success,
    this.data,
  });

  String? success;
  CancellData? data;

  factory CancellDashbordModel.fromJson(Map<String, dynamic> json) =>
      CancellDashbordModel(
        success: json["success"],
        data: CancellData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class CancellData {
  CancellData({
    this.totalShipments,
    this.cancellshipments,
    this.trackingStatuses,
  });

  int? totalShipments;
  List<Shipment>? cancellshipments;
  List<TrackingStatusCanc>? trackingStatuses;

  factory CancellData.fromJson(Map<String, dynamic> json) => CancellData(
        totalShipments: json["total_cancel_shipments"],
        cancellshipments: List<Shipment>.from(
            json["cancel_shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusCanc>.from(
            json["tracking_statuses"]
                .map((x) => TrackingStatusCanc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_cancel_shipments": totalShipments,
        "cancel_shipments":
            List<dynamic>.from(cancellshipments!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class TrackingStatusCanc {
  TrackingStatusCanc({
    this.id,
    this.statusAr,
    this.statusEng,
    this.icon,
  });

  dynamic id;
  dynamic statusAr;
  dynamic statusEng;
  dynamic icon;

  factory TrackingStatusCanc.fromJson(Map<String, dynamic> json) =>
      TrackingStatusCanc(
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
