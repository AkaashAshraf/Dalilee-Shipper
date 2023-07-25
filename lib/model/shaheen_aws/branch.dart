class LastReceiverBranch {
  int id;
  String name;
  String phone;

  LastReceiverBranch({
    this.id = 0,
    this.name = "",
    this.phone = "",
  });

  factory LastReceiverBranch.fromJson(Map<String, dynamic> json) =>
      LastReceiverBranch(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
      };
}
