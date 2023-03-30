// To parse this JSON data, do
//
//     final storesList = storesListFromJson(jsonString);

import 'dart:convert';

import 'package:dalile_customer/model/aacount_manager/store.dart';

StoresList storesListFromJson(String str) =>
    StoresList.fromJson(json.decode(str));

String storesListToJson(StoresList data) => json.encode(data.toJson());

class StoresList {
  StoresList({
    this.data,
  });

  Data? data;

  factory StoresList.fromJson(Map<String, dynamic> json) => StoresList(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.totalStores = 0,
    this.stores,
  });

  int totalStores;
  List<Stores>? stores;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalStores: json["total_stores"] ?? 0,
        stores: json["stores"] == null
            ? []
            : List<Stores>.from(json["stores"].map((x) => Stores.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_stores": totalStores,
        "stores": List<dynamic>.from(stores!.map((x) => x.toJson())),
      };
}
