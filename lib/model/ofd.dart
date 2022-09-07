// To parse this JSON data, do
//
//     final ofdResponse = ofdResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/all_shipment.dart';
import 'package:dalile_customer/model/to_be_delivered.dart';

OfdResponse ofdResponseFromJson(String str) =>
    OfdResponse.fromJson(json.decode(str));

String ofdResponseToJson(OfdResponse data) => json.encode(data.toJson());

class OfdResponse {
  OfdResponse({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory OfdResponse.fromJson(Map<String, dynamic> json) => OfdResponse(
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
  List<TrackingStatusTOBED>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOfdShipments: json["total_ofd_shipments"],
        ofdShipments: List<Shipment>.from(json["ofd_shipments"].map((x) => x)),
        trackingStatuses: List<TrackingStatusTOBED>.from(
            json["tracking_statuses"]
                .map((x) => TrackingStatusTOBED.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_ofd_shipments": totalOfdShipments,
        "ofd_shipments": List<dynamic>.from(ofdShipments!.map((x) => x)),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}
