// To parse this JSON data, do
//
//     final dispatchOrders = dispatchOrdersFromJson(jsonString);

import 'dart:convert';

DispatchOrders dispatchOrdersFromJson(String str) =>
    DispatchOrders.fromJson(json.decode(str));

String dispatchOrdersToJson(DispatchOrders data) => json.encode(data.toJson());

class DispatchOrders {
  DispatchOrders({
    this.orders,
  });

  List<Order>? orders;

  factory DispatchOrders.fromJson(Map<String, dynamic> json) => DispatchOrders(
        orders: json["orders"] == null
            ? null
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? null
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  Order(
      {this.id: 0,
      this.rid: 0,
      this.phone: "",
      this.name: "",
      this.cod: "",
      this.cc: "0",
      this.willayaLabel: "",
      this.regionLabel: "",
      this.willayaID: 0,
      this.regionID: 0,
      this.address: "",
      this.checkValidtion: false});

  int id;
  int rid;

  String phone;
  String name;
  String cod;
  String cc;
  int willayaID;
  String willayaLabel;

  int regionID;
  String regionLabel;
  String address;
  bool checkValidtion;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? 0 : json["id"],
        rid: json["rid"] == null ? 0 : json["rid"],
        phone: json["phone"] == null ? null : json["phone"],
        name: json["name"] == null ? null : json["name"],
        cod: json["cod"] == null ? null : json["cod"],
        cc: json["cc"] == null ? null : json["cc"],
        willayaID: json["willayaID"] == null ? 0 : json["willaya"],
        regionID: json["regionID"] == null ? 0 : json["region"],
        regionLabel: json["regionLabel"] == null ? 0 : json["regionLabel"],
        willayaLabel: json["willayaLabel"] == null ? 0 : json["willayaLabel"],
        checkValidtion:
            json["checkValidtion"] == null ? 0 : json["checkValidtion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rid": rid,
        "phone": phone,
        "name": name,
        "cod": cod,
        "cc": cc,
        "willayaID": willayaID,
        "regionID": regionID,
        "willayaLabel": willayaLabel,
        "regionLabel": regionLabel,
        "checkValidtion": checkValidtion
      };
}
