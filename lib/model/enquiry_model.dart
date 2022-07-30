// To parse this JSON data, do
//
//     final enquiryModel = enquiryModelFromJson(jsonString);

import 'dart:convert';

EnquiryModel enquiryModelFromJson(String str) => EnquiryModel.fromJson(json.decode(str));

String enquiryModelToJson(EnquiryModel data) => json.encode(data.toJson());

class EnquiryModel {
    EnquiryModel({
        this.data,
    });

    List<EnquiryList>? data;

    factory EnquiryModel.fromJson(Map<String, dynamic> json) => EnquiryModel(
        data: List<EnquiryList>.from(json["data"].map((x) => EnquiryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class EnquiryList {
    EnquiryList({
        this.id,
        this.inquiryNo,
        this.userId,
        this.phoneNo,
        this.mainCategory,
        this.subCategory,
        this.secSubCategory,
        this.title,
        this.comment,
        this.assignTo,
        this.priority,
        this.updateStatus,
        this.createdAt,
        this.updatedAt,
        this.customerId,
        this.sourceId,
    });

    dynamic id;
    dynamic inquiryNo;
    dynamic userId;
    dynamic phoneNo;
    dynamic mainCategory;
    dynamic subCategory;
    dynamic secSubCategory;
    dynamic title;
    dynamic comment;
    dynamic assignTo;
    dynamic priority;
    dynamic updateStatus;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic customerId;
    dynamic sourceId;

    factory EnquiryList.fromJson(Map<String, dynamic> json) => EnquiryList(
        id: json["id"],
        inquiryNo: json["inquiry_no"],
        userId: json["user_id"],
        phoneNo: json["phone_no"],
        mainCategory: json["main_category"],
        subCategory: json["sub_category"],
        secSubCategory: json["sec_sub_category"],
        title: json["title"],
        comment: json["comment"],
        assignTo: json["assign_to"],
        priority: json["priority"],
        updateStatus: json["update_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customerId: json["customer_id"],
        sourceId: json["source_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "inquiry_no": inquiryNo,
        "user_id": userId,
        "phone_no": phoneNo,
        "main_category": mainCategory,
        "sub_category": subCategory,
        "sec_sub_category": secSubCategory,
        "title": title,
        "comment": comment,
        "assign_to": assignTo,
        "priority": priority,
        "update_status": updateStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "customer_id": customerId,
        "source_id": sourceId,
    };
}
