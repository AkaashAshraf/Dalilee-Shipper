// To parse this JSON data, do
//
//     final orderViewListModel = orderViewListModelFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';

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
    this.totalOrders,
    this.orders,
    this.trackingStatuses,
  });
  int? totalOrders;

  List<Shipment>? orders;
  List<TrackingStatus>? trackingStatuses;

  factory ViewOrderData.fromJson(Map<String, dynamic> json) => ViewOrderData(
        totalOrders: json["total_orders"],
        orders:
            List<Shipment>.from(json["orders"].map((x) => Order.fromJson(x))),
        trackingStatuses: List<TrackingStatus>.from(
            json["tracking_statuses"].map((x) => TrackingStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_orders": totalOrders,
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
        "tracking_statuses":
            List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
      };
}

class Order {
  Order({
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
    this.isOpen,
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
  dynamic isOpen;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        isOpen: false,
        orderId: json["order_id"],
        orderNo: json["order_no"],
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
        "order_no": orderNo,
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
