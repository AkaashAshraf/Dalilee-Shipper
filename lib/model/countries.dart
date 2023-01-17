// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

Countries? countriesFromJson(String str) =>
    Countries.fromJson(json.decode(str));

String countriesToJson(Countries? data) => json.encode(data!.toJson());

class Countries {
  Countries({
    required this.countries,
  });

  List<Country?> countries;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        countries: List<Country?>.from(
            json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x!.toJson())),
      };
}

class Country {
  Country({
    this.id = 0,
    this.nameEn = "",
    this.nameAr = "",
    this.countryCode = "",
    this.flag = "",
  });

  int id;
  String nameEn;
  String nameAr;
  String countryCode;
  String flag;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"] ?? 0,
        nameEn: json["name_en"] ?? "",
        nameAr: json["name_ar"] ?? "",
        countryCode: json["country_code"] ?? "",
        flag: json["flag"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "country_code": countryCode,
        "flag": flag,
      };
}
