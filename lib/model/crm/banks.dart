import 'dart:convert';

List<BanksReponse> banksReponseFromJson(String str) => List<BanksReponse>.from(
    json.decode(str).map((x) => BanksReponse.fromJson(x)));

String banksReponseToJson(List<BanksReponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BanksReponse {
  String name;
  int id;

  BanksReponse({
    this.name = "",
    this.id = 0,
  });

  factory BanksReponse.fromJson(Map<String, dynamic> json) => BanksReponse(
        name: json["name"] ?? "",
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
