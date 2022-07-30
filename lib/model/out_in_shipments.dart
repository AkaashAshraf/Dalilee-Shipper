// To parse this JSON data, do
//
//     final outAndInShipmentModel = outAndInShipmentModelFromJson(jsonString);

import 'dart:convert';

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
  });

  List<Request>? requests;
  List<TrackingStatus>? trackingStatuses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requests: List<Request>.from(
            json["requests"].map((x) => Request.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(requests!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class Request {
  Request({
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
    required this.isOpen
  });
  bool isOpen;
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

  factory Request.fromJson(Map<dynamic, dynamic> json) => Request(
    isOpen : false,
        orderId: json["order_id"],
        orderNo: json["order_no"],
        refId: json["ref_id"] == null ? null : json["ref_id"],
        cop: json["cop"],
        customerNo: json["customer_no"],
        weight: json["weight"],
        phone: json["phone"],
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
        "ref_id": refId == null ? null : refId,
        "cop": cop,
        "customer_no": customerNo,
        "weight": weight,
        "phone": phone,
        "shipping_price": shippingPrice,
        "cod": cod,
        "current_status": currentStatus == null ? null : currentStatus,
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
  dynamic externalText;
  dynamic shortText;
  dynamic internalText;
  dynamic createdAt;
  dynamic updatedAt;

  factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        id: json["id"],
        description: json["description"],
        externalText:
            json["external_text"] == null ? null : json["external_text"],
        shortText: json["short_text"] == null ? null : json["short_text"],
        internalText:
            json["internal_text"] == null ? null : json["internal_text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "external_text": externalText == null ? null : externalText,
        "short_text": shortText == null ? null : shortText,
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
