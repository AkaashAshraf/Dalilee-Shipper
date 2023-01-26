// To parse this JSON data, do
//
//     final mainDashboard = mainDashboardFromJson(jsonString);

import 'dart:convert';

MainDashboard mainDashboardFromJson(String str) =>
    MainDashboard.fromJson(json.decode(str));

String mainDashboardToJson(MainDashboard data) => json.encode(data.toJson());

class MainDashboard {
  MainDashboard({
    this.status,
    this.data,
    this.message,
    this.andriodVersion,
    this.iosVersion,
    this.isAndroidVersionCheck,
    this.isIosVersionCheck,
  });

  String? status;
  Data? data;
  String? message;

  int? andriodVersion;
  int? iosVersion;
  bool? isAndroidVersionCheck;
  bool? isIosVersionCheck;

  factory MainDashboard.fromJson(Map<String, dynamic> json) => MainDashboard(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        andriodVersion: json["andriod_version"],
        iosVersion: json["ios_version"],
        isAndroidVersionCheck: json["is_android_version_check"],
        isIosVersionCheck: json["is_ios_version_check"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
        "andriod_version": andriodVersion,
        "ios_version": iosVersion,
        "is_android_version_check": isAndroidVersionCheck,
        "is_ios_version_check": isIosVersionCheck,
      };
}

class Data {
  Data({
    this.stats,
    this.trackingStatuses,
  });

  Stats? stats;
  List<TrackingStatus>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stats: Stats.fromJson(json["stats"]),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stats": stats!.toJson(),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class Stats {
  Stats({
    this.totalShipments,
    this.deliverdShipments,
    this.toBeDelivered,
    this.returnedShipments,
    this.cancelShipments,
    this.undeliveredShipments,
    this.ofdShipments,
  });

  int? totalShipments;
  int? deliverdShipments;
  int? toBeDelivered;
  int? returnedShipments;
  int? cancelShipments;
  int? undeliveredShipments;
  int? ofdShipments;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalShipments: json["total_shipments"],
        deliverdShipments: json["deliverd_shipments"],
        toBeDelivered: json["to_be_delivered"],
        returnedShipments: json["returned_shipments"],
        cancelShipments: json["cancel_shipments"],
        undeliveredShipments: json["undelivered_shipments"],
        ofdShipments: json["ofd_shipments"],
      );

  Map<String, dynamic> toJson() => {
        "total_shipments": totalShipments,
        "deliverd_shipments": deliverdShipments,
        "to_be_delivered": toBeDelivered,
        "returned_shipments": returnedShipments,
        "cancel_shipments": cancelShipments,
        "undelivered_shipments": undeliveredShipments,
        "ofd_shipments": ofdShipments,
      };
}

class TrackingStatus {
  TrackingStatus({
    this.id,
    this.statusAr,
    this.statusEng,
    this.icon,
  });

  int? id;
  dynamic statusAr;
  String? statusEng;
  String? icon;

  factory TrackingStatus.fromJson(Map<String, dynamic> json) => TrackingStatus(
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
