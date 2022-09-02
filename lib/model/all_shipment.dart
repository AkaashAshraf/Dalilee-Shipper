// To parse this JSON data, do
//
//     final AlldashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

AllDashbordModel dashbordAllModelFromJson(String str) =>
    AllDashbordModel.fromJson(json.decode(str));

String alldashbordModelToJson(AllDashbordModel data) =>
    json.encode(data.toJson());

class AllDashbordModel {
  AllDashbordModel({
    this.success,
    this.data,
  });

  String? success;
  AllData? data;

  factory AllDashbordModel.fromJson(Map<String, dynamic> json) =>
      AllDashbordModel(
        success: json["success"],
        data: AllData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class AllData {
  AllData({
    this.totalShipments,
    this.shipments,
    this.trackingStatuses,
  });

  int? totalShipments;
  List<Shipment>? shipments;
  List<TrackingStatus>? trackingStatuses;

  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
        totalShipments: json["total_shipments"],
        shipments: List<Shipment>.from(
            json["shipments"].map((x) => Shipment.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_shipments": totalShipments,
        "shipments": List<dynamic>.from(shipments!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class Shipment {
  Shipment({
    this.orderId,
    this.orderNo,
    this.refId,
    this.cop,
    this.customerNo,
    this.weight,
    this.phone,
    this.shippingPrice,
    this.cod,
    this.currentStatus,
    this.orderActivities,
    required this.isOpen,
    this.cc,
    this.customerName,
    this.orderStatusName,
    this.orderStatusKey,
    this.orderDeliverImage,
    this.orderUndeliverImage,
  });

  dynamic orderId;
  dynamic orderNo;
  dynamic refId;
  dynamic cop;
  dynamic customerNo;
  dynamic weight;
  dynamic phone;
  dynamic shippingPrice;
  dynamic cod;
  dynamic currentStatus;
  List<OrderActivity>? orderActivities;
  bool isOpen;

  int? cc;
  String? customerName;

  String? orderStatusName;
  String? orderStatusKey;
  String? orderDeliverImage;
  String? orderUndeliverImage;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        cc: json["cc"] == null ? null : json["cc"],
        customerName: json['customer_name'],
        orderStatusName: json["order_status_name"],
        orderStatusKey: json["order_status_key"],
        orderDeliverImage: json["order_deliver_image"],
        orderUndeliverImage: json["order_undeliver_image"],
        isOpen: false,
        orderId: json["order_id"],
        orderNo: json["order_no"],
        refId: json["ref_id"],
        cop: json["cop"],
        customerNo: json["customer_no"] == null ? null : json["customer_no"],
        weight: json["weight"] == null ? null : json["weight"],
        phone: json["phone"] == null ? null : json["phone"],
        shippingPrice: json["shipping_price"],
        cod: json["cod"],
        currentStatus:
            json["current_status"] == null ? null : json["current_status"],
        orderActivities: List<OrderActivity>.from(
            json["order_activities"].map((x) => OrderActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_no": orderNo,
        "ref_id": refId,
        "cop": cop,
        "customer_no": customerNo,
        "customer_name": customerName,
        "cc": cc,
        "order_status_name": orderStatusName,
        "order_status_key": orderStatusKey,
        "order_deliver_image": orderDeliverImage,
        "order_undeliver_image": orderUndeliverImage,
        "weight": weight,
        "phone": phone,
        "shipping_price": shippingPrice,
        "cod": cod,
        "current_status": currentStatus,
        "order_activities":
            List<dynamic>.from(orderActivities!.map((x) => x.toJson())),
      };
}

class OrderActivity {
  OrderActivity({
    this.id,
    this.description,
    this.externalText,
    this.shortText,
    this.internalText,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic description;
  String? externalText;
  dynamic shortText;
  String? internalText;
  dynamic createdAt;
  dynamic updatedAt;

  factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        id: json["id"],
        description: json["description"],
        externalText:
            json["external_text"] == null ? null : json["external_text"],
        shortText: json["short_text"],
        internalText:
            json["internal_text"] == null ? null : json["internal_text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "external_text": externalText == null ? null : externalText,
        "short_text": shortText,
        "internal_text": internalText == null ? null : internalText,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class TrackingStatus {
  TrackingStatus({
    this.id,
    this.statusAr,
    this.statusEng,
    this.icon,
  });

  dynamic id;
  dynamic statusAr;
  dynamic statusEng;
  dynamic icon;

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
