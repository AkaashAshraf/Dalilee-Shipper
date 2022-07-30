// To parse this JSON data, do
//
//     final orderViewListModel = orderViewListModelFromJson(jsonString);

import 'dart:convert';

OrderViewListModel orderViewListModelFromJson(String str) =>
    OrderViewListModel.fromJson(json.decode(str));

String orderViewListModelToJson(OrderViewListModel data) =>
    json.encode(data.toJson());

class OrderViewListModel {
  OrderViewListModel({
    this.success,
    this.data,
  });

  String? success;
  ViewOrderData? data;

  factory OrderViewListModel.fromJson(Map<String, dynamic> json) =>
      OrderViewListModel(
        success: json["success"],
        data: ViewOrderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class ViewOrderData {
  ViewOrderData({
    this.orders,
    this.trackingStatuses,
  });

  List<Order>? orders;
  List<TrackingStatus>? trackingStatuses;

  factory ViewOrderData.fromJson(Map<String, dynamic> json) => ViewOrderData(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.orderId,
    this.refId,
    this.cop,
    this.customerNo,
    this.weight,
    this.phone,
    this.shippingPrice,
    this.cod,
    this.currentStatus,
    this.orderActivities,
    this.isOpen,
  });

  dynamic orderId;
  dynamic refId;
  dynamic cop;
  dynamic customerNo;
  dynamic weight;
  dynamic phone;
  dynamic shippingPrice;
  dynamic cod;
  dynamic currentStatus;
  List<OrderActivity>? orderActivities;
  dynamic isOpen;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        isOpen: false,
        orderId: json["order_id"],
        refId: json["ref_id"],
        cop: json["cop"],
        customerNo: json["customer_no"],
        weight: json["weight"],
        phone: json["phone"],
        shippingPrice: json["shipping_price"],
        cod: json["cod"],
        currentStatus: json["current_status"],
        orderActivities: List<OrderActivity>.from(
            json["order_activities"].map((x) => OrderActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "ref_id": refId,
        "cop": cop,
        "customer_no": customerNo,
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
  dynamic externalText;
  dynamic shortText;
  dynamic internalText;
  dynamic createdAt;
  dynamic updatedAt;

  factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        id: json["id"],
        description: json["description"],
        externalText: json["external_text"],
        shortText: json["short_text"],
        internalText: json["internal_text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "external_text": externalText,
        "short_text": shortText,
        "internal_text": internalText,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class TrackingStatus {
  TrackingStatus({
    this.id,
    this.statusAr,
    this.statusEng,
    required this.icon,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic statusAr;
  dynamic statusEng;
  String icon;
  dynamic createdAt;
  dynamic updatedAt;

  factory TrackingStatus.fromJson(Map<String, dynamic> json) => TrackingStatus(
        id: json["id"],
        statusAr: json["status_ar"],
        statusEng: json["status_eng"],
        icon: json["icon"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_ar": statusAr,
        "status_eng": statusEng,
        "icon": icon,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
