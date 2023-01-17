// To parse this JSON data, do
//
//     final bankaccounts = bankaccountsFromJson(jsonString);

import 'dart:convert';

Bankaccounts? bankaccountsFromJson(String str) =>
    Bankaccounts.fromJson(json.decode(str));

String bankaccountsToJson(Bankaccounts? data) => json.encode(data!.toJson());

class Bankaccounts {
  Bankaccounts({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Accounts>? data;

  factory Bankaccounts.fromJson(Map<String, dynamic> json) => Bankaccounts(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : json["data"] == null
                ? []
                : List<Accounts>.from(
                    json["data"]!.map((x) => Accounts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : data == null
                ? []
                : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class Accounts {
  Accounts({
    this.id,
    this.civilId,
    this.name,
    this.fkBankId,
    this.accounttNo,
    this.accountType,
    this.beneficiaryNo,
    this.traderId,
    this.createdAt,
    this.updatedAt,
    this.bankName,
  });

  int? id;
  String? civilId;
  String? name;
  int? fkBankId;
  String? accounttNo;
  String? accountType;
  String? beneficiaryNo;
  String? traderId;
  String? createdAt;
  String? updatedAt;
  String? bankName;

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
        id: json["id"],
        civilId: json["civil_id"],
        name: json["name"],
        fkBankId: json["fk_bank_id"],
        accounttNo: json["accountt_no"],
        accountType: json["account_type"],
        beneficiaryNo: json["beneficiary_no"],
        traderId: json["trader_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "civil_id": civilId,
        "name": name,
        "fk_bank_id": fkBankId,
        "accountt_no": accounttNo,
        "account_type": accountType,
        "beneficiary_no": beneficiaryNo,
        "trader_id": traderId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "bank_name": bankName,
      };
}
