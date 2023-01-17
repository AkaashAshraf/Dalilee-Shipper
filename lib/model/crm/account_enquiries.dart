// To parse this JSON data, do
//
//     final accountEnquiries = accountEnquiriesFromJson(jsonString);

import 'dart:convert';

AccountEnquiries? accountEnquiriesFromJson(String str) =>
    AccountEnquiries.fromJson(json.decode(str));

String accountEnquiriesToJson(AccountEnquiries? data) =>
    json.encode(data!.toJson());

class AccountEnquiries {
  AccountEnquiries({
    this.status,
    this.meassage,
    this.total,
    this.data,
  });

  String? status;
  String? meassage;
  int? total;
  List<Enquiry>? data;

  factory AccountEnquiries.fromJson(Map<String, dynamic> json) =>
      AccountEnquiries(
        status: json["status"],
        meassage: json["meassage"],
        total: json["total"],
        data: json["data"] == null
            ? []
            : json["data"] == null
                ? []
                : List<Enquiry>.from(
                    json["data"]!.map((x) => Enquiry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "meassage": meassage,
        "total": total,
        "data": data == null
            ? []
            : data == null
                ? []
                : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Enquiry {
  Enquiry({
    this.enqNo,
    this.status,
    this.traderId,
    this.amount,
    this.clientName,
    this.clientContact,
    this.beneficiaryName,
    this.accountNo,
    this.accountType,
    this.createdBy,
    this.description,
    this.estimatedAmount,
    this.createdAt,
    this.updatedAt,
    this.notes,
  });

  int? enqNo;
  String? status;
  String? traderId;
  String? amount;

  String? clientName;
  String? clientContact;
  String? beneficiaryName;
  String? accountNo;
  String? accountType;
  String? createdBy;
  String? description;
  String? estimatedAmount;
  String? createdAt;
  String? updatedAt;
  List<Note>? notes;

  factory Enquiry.fromJson(Map<String, dynamic> json) => Enquiry(
        enqNo: json["enq_no"],
        status: json["status"],
        traderId: json["trader_id"],
        amount: json["amount"],
        clientName: json["client_name"],
        clientContact: json["client_contact"],
        beneficiaryName: json["beneficiary_name"],
        accountNo: json["account_no"],
        accountType: json["account_type"],
        createdBy: json["created_by"],
        description: json["description"],
        estimatedAmount: json["estimated_amount"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        notes: json["notes"] == null
            ? []
            : json["notes"] == null
                ? []
                : List<Note>.from(json["notes"]!.map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "enq_no": enqNo,
        "status": status,
        "trader_id": traderId,
        "client_name": clientName,
        "client_contact": clientContact,
        "beneficiary_name": beneficiaryName,
        "account_no": accountNo,
        "account_type": accountType,
        "created_by": createdBy,
        "amount": amount,
        "description": description,
        "estimated_amount": estimatedAmount,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "notes": notes == null
            ? []
            : notes == null
                ? []
                : List<dynamic>.from(notes!.map((x) => x!.toJson())),
      };
}

class Note {
  Note({
    this.id,
    this.note,
    this.status,
    this.fkUserIdCreated,
    this.fkComplainId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? note;
  int? status;
  int? fkUserIdCreated;
  int? fkComplainId;
  String? createdAt;
  String? updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        note: json["note"],
        status: json["status"],
        fkUserIdCreated: json["fk_user_id_created"],
        fkComplainId: json["fk_complain_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "note": note,
        "status": status,
        "fk_user_id_created": fkUserIdCreated,
        "fk_complain_id": fkComplainId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
