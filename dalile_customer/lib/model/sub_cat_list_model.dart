// To parse this JSON data, do
//
//     final addInquiryListSubCattModel = addInquiryListSubCattModelFromJson(jsonString);

import 'dart:convert';

AddInquiryListSubCattModel addInquiryListSubCattModelFromJson(String str) => AddInquiryListSubCattModel.fromJson(json.decode(str));

String addInquiryListSubCattModelToJson(AddInquiryListSubCattModel data) => json.encode(data.toJson());

class AddInquiryListSubCattModel {
    AddInquiryListSubCattModel({
        this.success,
        this.data,
    });

    String? success;
    List<SubCatList>? data;

    factory AddInquiryListSubCattModel.fromJson(Map<String, dynamic> json) => AddInquiryListSubCattModel(
        success: json["success"],
        data: List<SubCatList>.from(json["data"].map((x) => SubCatList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubCatList {
    SubCatList({
        this.id,
        this.name,
        this.parentId,
        this.message,
        this.createdAt,
        this.updatedAt,
    });

    dynamic id;
    dynamic name;
    dynamic parentId;
    dynamic message;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory SubCatList.fromJson(Map<String, dynamic> json) => SubCatList(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
