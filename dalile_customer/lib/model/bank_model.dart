// To parse this JSON data, do
//
//     final bankListModel = bankListModelFromJson(jsonString);

import 'dart:convert';

List<BankListModel> bankListModelFromJson( str) =>
    List<BankListModel>.from(
        str.map((x) => BankListModel.fromJson(x)));

String bankListModelToJson(List<BankListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankListModel {
  BankListModel({
    this.name,
    this.id,
  });

  String? name;
  int? id;

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
