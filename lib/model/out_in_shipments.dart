// To parse this JSON data, do
//
//     final outAndInShipmentModel = outAndInShipmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/all_shipment.dart';

OutAndInShipmentModel outAndInShipmentModelFromJson(String str) =>
    OutAndInShipmentModel.fromJson(json.decode(str));

String outAndInShipmentModelToJson(OutAndInShipmentModel data) =>
    json.encode(data.toJson());

class OutAndInShipmentModel {
  OutAndInShipmentModel({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory OutAndInShipmentModel.fromJson(Map<String, dynamic> json) =>
      OutAndInShipmentModel(
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
    this.requests,
    this.trackingStatuses,
    this.total_requests,
  });

  List<Shipment>? requests;
  int? total_requests;
  List<TrackingStatus>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requests: List<Shipment>.from(
            json["requests"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
        total_requests: json["total_requests"],
      );

  Map<String, dynamic> toJson() => {
        "total_requests": total_requests,
        "requests": List<dynamic>.from(requests!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}
