class Stores {
  Stores({
    this.storeId = 0,
    this.name = "",
    this.mobile = "",
    this.storeCode = "",
    this.email = "",
  });

  int storeId;
  String name;
  String mobile;
  String storeCode;
  String email;

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        storeId: json["store_id"] ?? 0,
        name: json["name"] ?? "",
        mobile: json["mobile"] ?? "",
        storeCode: json["store_code"] ?? "",
        email: json["email"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "name": name,
        "mobile": mobile,
        "store_code": storeCode,
        "email": email,
      };
}
