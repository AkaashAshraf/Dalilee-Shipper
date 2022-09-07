// To parse this JSON data, do
//
//     final exportResponse = exportResponseFromJson(jsonString);

import 'dart:convert';

ExportResponse exportResponseFromJson(String str) =>
    ExportResponse.fromJson(json.decode(str));

String exportResponseToJson(ExportResponse data) => json.encode(data.toJson());

class ExportResponse {
  ExportResponse({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory ExportResponse.fromJson(Map<String, dynamic> json) => ExportResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.url,
  });

  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
