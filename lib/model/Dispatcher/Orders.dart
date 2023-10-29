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
      this.roadNumber: "",
      this.pickupNote: "",
      this.flatNumber: "",
      this.blockNumber: "",
      this.cod: "",
      this.cc: "0",
      this.latitude: "",
      this.longitude: "0",
      this.willayaLabel: "",
      this.regionLabel: "",
      this.willayaID: 0,
      this.regionID: 0,
      this.address: "",
      this.locationName: "",
      this.checkValidtion: false});

  int id;
  int rid;

  String phone;
  String name;
  String cod;
  String cc;
  String latitude;
  String longitude;
  String locationName;
  String roadNumber;
  String blockNumber;
  String flatNumber;
  String pickupNote;

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
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        roadNumber: json["road_number"] ?? "",
        flatNumber: json["block_number"] ?? "",
        blockNumber: json["flat_number"] ?? "",
        pickupNote: json["pickup_note"] ?? "",
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
