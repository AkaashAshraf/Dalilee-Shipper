// To parse this JSON Muhafaza, do
//
//     final muhafazaModel = muhafazaModelFromJson(jsonString);

import 'dart:convert';

MuhafazaModel muhafazaModelFromJson(String str) =>
    MuhafazaModel.fromJson(json.decode(str));

String muhafazaModelToJson(MuhafazaModel data) => json.encode(data.toJson());

class MuhafazaModel {
  MuhafazaModel({
    this.success,
    this.data,
  });

  String? success;
  Muhafaza? data;

  factory MuhafazaModel.fromJson(Map<String, dynamic> json) => MuhafazaModel(
        success: json["success"],
        data: Muhafaza.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Muhafaza {
  Muhafaza({
    this.governates,
  });

  List<Governate>? governates;

  factory Muhafaza.fromJson(Map<String, dynamic> json) => Muhafaza(
        governates: List<Governate>.from(
            json["governates"].map((x) => Governate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "governates": List<dynamic>.from(governates!.map((x) => x.toJson())),
      };
}

class Governate {
  Governate({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Governate.fromJson(Map<String, dynamic> json) => Governate(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
