// To parse this JSON data, do
//
//     final assignStore = assignStoreFromJson(jsonString);

import 'dart:convert';

AssignStore assignStoreFromJson(String str) =>
    AssignStore.fromJson(json.decode(str));

String assignStoreToJson(AssignStore data) => json.encode(data.toJson());

class AssignStore {
  Data data;

  AssignStore({
    required this.data,
  });

  factory AssignStore.fromJson(Map<String, dynamic> json) => AssignStore(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  int totalStores;
  List<Store> stores;

  Data({
    required this.totalStores,
    required this.stores,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalStores: json["total_stores"],
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_stores": totalStores,
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class Store {
  int id;
  String name;
  String? countryCode;
  String mobile;
  String branch;
  int? branchId;

  Store({
    required this.id,
    required this.name,
    this.countryCode,
    required this.mobile,
    required this.branch,
    this.branchId,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        countryCode: json["country_code"] ?? "",
        mobile: json["mobile"] ?? "",
        branch: json["branch"] ?? "",
        branchId: json["branch_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "mobile": mobile,
        "branch": branch,
        "branch_id": branchId,
      };
}
