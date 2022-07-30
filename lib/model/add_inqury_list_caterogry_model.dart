// To parse this JSON data, do
//
//     final addInquiryListCattModel = addInquiryListCattModelFromJson(jsonString);

import 'dart:convert';

AddInquiryListCattModel addInquiryListCattModelFromJson(String str) => AddInquiryListCattModel.fromJson(json.decode(str));

String addInquiryListCattModelToJson(AddInquiryListCattModel data) => json.encode(data.toJson());

class AddInquiryListCattModel {
    AddInquiryListCattModel({
        this.data,
    });

    List<CatList>? data;

    factory AddInquiryListCattModel.fromJson(Map<String, dynamic> json) => AddInquiryListCattModel(
        data: List<CatList>.from(json["data"].map((x) => CatList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CatList {
    CatList({
        this.id,
        this.name,
        this.message,
    });

    dynamic id;
    dynamic name;
    dynamic message;

    factory CatList.fromJson(Map<String, dynamic> json) => CatList(
        id: json["id"],
        name: json["name"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "message": message,
    };
}
