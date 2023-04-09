class Stores {
  Stores({
    this.storeId = 0,
    this.name = "",
    this.mobile = "",
    this.storeCode = "",
    this.email = "",
    this.countryCode = "",
  });

  int storeId;
  String name;
  String mobile;
  String storeCode;
  String email;
  String countryCode;

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        storeId: json["store_id"] ?? 0,
        countryCode: json["country_code"].toString(),
        name: json["name"] ?? "",
        mobile: json["mobile"] ?? "",
        storeCode: json["store_code"] ?? "",
        email: json["email"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "country_code": countryCode,
        "name": name,
        "mobile": mobile,
        "store_code": storeCode,
        "email": email,
      };
}
