// To parse this JSON data, do
//
//     final pickupDetailsModel = pickupDetailsModelFromJson(jsonString);

import 'dart:convert';

PickupDetailsModel pickupDetailsModelFromJson(String str) =>
    PickupDetailsModel.fromJson(json.decode(str));

String pickupDetailsModelToJson(PickupDetailsModel data) =>
    json.encode(data.toJson());

class PickupDetailsModel {
  PickupDetailsModel({
    this.success,
    this.data,
  });

  String? success;
  PickupDetialsData? data;

  factory PickupDetailsModel.fromJson(Map<String, dynamic> json) =>
      PickupDetailsModel(
        success: json["success"],
        data: PickupDetialsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class PickupDetialsData {
  PickupDetialsData({
    this.orders,
  });

  List<Order>? orders;

  factory PickupDetialsData.fromJson(Map<String, dynamic> json) =>
      PickupDetialsData(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.refId,
    this.date,
    this.orderId,
    this.image,
    this.weight,
    this.shipping,
    this.phone,
    this.location,
    this.orderNo,
  });

  dynamic refId;
  dynamic date;
  dynamic orderId;
  dynamic image;
  dynamic weight;
  dynamic shipping;
  dynamic phone;
  dynamic location;
  dynamic orderNo;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        refId: json["ref_id"],
        date: json["date"],
        orderId: json["order_id"],
        image: json["image"],
        weight: json["weight"] == null ? null : json["weight"],
        shipping: json["shipping"],
        phone: json["phone"] == null ? null : json["phone"],
        location: json["location"],
        orderNo: json["order_no"] == null ? "" : json["order_no"],
      );

  Map<String, dynamic> toJson() => {
        "ref_id": refId,
        "date": date,
        "order_id": orderId,
        "image": image,
        "weight": weight == null ? null : weight,
        "shipping": shipping,
        "phone": phone == null ? null : phone,
        "location": location,
        "order_no": orderNo,
      };
}
