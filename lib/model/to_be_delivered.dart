// To parse this JSON data, do
//
//     final ToBeDelivereddashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

ToBeDeliveredDashbordModel dashbordToBeDeliveredModelFromJson(String str) =>
    ToBeDeliveredDashbordModel.fromJson(json.decode(str));

String toBeDelivereddashbordModelToJson(ToBeDeliveredDashbordModel data) =>
    json.encode(data.toJson());

class ToBeDeliveredDashbordModel {
  ToBeDeliveredDashbordModel({
    this.success,
    this.data,
  });

  String? success;
  ToBeDeliveredData? data;

  factory ToBeDeliveredDashbordModel.fromJson(Map<String, dynamic> json) =>
      ToBeDeliveredDashbordModel(
        success: json["success"],
        data: ToBeDeliveredData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class ToBeDeliveredData {
  ToBeDeliveredData({
    this.totalShipments,
    this.shipmentsToDelivered,
    this.trackingStatuses,
  });

  int? totalShipments;
  List<Shipment>? shipmentsToDelivered;
  List<TrackingStatusTOBED>? trackingStatuses;

  factory ToBeDeliveredData.fromJson(Map<String, dynamic> json) =>
      ToBeDeliveredData(
        totalShipments: json["total_to_be_delivered"],
        shipmentsToDelivered: List<Shipment>.from(
            json["return_shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusTOBED>.from(
            json["tracking_statuses"]
                .map((x) => TrackingStatusTOBED.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_to_be_delivered": totalShipments,
        "return_shipments":
            List<dynamic>.from(shipmentsToDelivered!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class TrackingStatusTOBED {
  TrackingStatusTOBED({
    this.id,
    this.statusAr,
    this.statusEng,
    this.icon,
  });

  dynamic id;
  dynamic statusAr;
  dynamic statusEng;
  dynamic icon;

  factory TrackingStatusTOBED.fromJson(Map<String, dynamic> json) =>
      TrackingStatusTOBED(
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
