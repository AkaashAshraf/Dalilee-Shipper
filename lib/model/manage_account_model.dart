// To parse this JSON data, do
//
//     final manageAccountModel = manageAccountModelFromJson(jsonString);

import 'dart:convert';

ManageAccountModel manageAccountModelFromJson(String str) =>
    ManageAccountModel.fromJson(json.decode(str));

String manageAccountModelToJson(ManageAccountModel data) =>
    json.encode(data.toJson());

class ManageAccountModel {
  ManageAccountModel({
    this.data,
  });

  Data_? data;

  factory ManageAccountModel.fromJson(Map<String, dynamic> json) =>
      ManageAccountModel(
        data: Data_.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data_ {
  Data_({
    this.totalBankAccounts,
    this.bankAccounts,
  });

  dynamic totalBankAccounts;
  List<BankAccount>? bankAccounts;

  factory Data_.fromJson(Map<String, dynamic> json) => Data_(
        totalBankAccounts: json["totalBankAccounts"],
        bankAccounts: List<BankAccount>.from(
            json["bankAccounts"].map((x) => BankAccount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalBankAccounts": totalBankAccounts,
        "bankAccounts":
            List<dynamic>.from(bankAccounts!.map((x) => x.toJson())),
      };
}

class BankAccount {
  BankAccount({
    this.id,
    this.holderName,
    this.bankName,
    this.accountNumber,
    this.openingBalance,
    this.contactNumber,
    this.bankAddress,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  dynamic id;
  dynamic holderName;
  dynamic bankName;
  dynamic accountNumber;
  dynamic openingBalance;
  dynamic contactNumber;
  dynamic bankAddress;
  dynamic createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json["id"],
        holderName: json["holder_name"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        openingBalance: json["opening_balance"],
        contactNumber: json["contact_number"],
        bankAddress: json["bank_address"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "holder_name": holderName,
        "bank_name": bankName,
        "account_number": accountNumber,
        "opening_balance": openingBalance,
        "contact_number": contactNumber,
        "bank_address": bankAddress,
        "created_by": createdBy,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "pivot": pivot!.toJson(),
      };
}

class Pivot {
  Pivot({
    this.storeId,
    this.bankAccountId,
  });

  dynamic storeId;
  dynamic bankAccountId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        storeId: json["store_id"],
        bankAccountId: json["bank_account_id"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "bank_account_id": bankAccountId,
      };
}
