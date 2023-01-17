class ProblemReason {
  ProblemReason({
    this.id = 0,
    this.code = "",
    this.title = "",
    this.category = 0,
    this.createdAt = "",
    this.updatedAt = "",
    this.titleAr = "",
  });

  int id;
  String code;
  String title;
  int category;
  String createdAt;
  String updatedAt;
  String titleAr;

  factory ProblemReason.fromJson(Map<String, dynamic> json) => ProblemReason(
        id: json["id"] ?? 0,
        code: json["code"] ?? "",
        title: json["title"] ?? "",
        category: json["category"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        titleAr: json["title_ar"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "title": title,
        "category": category,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title_ar": titleAr,
      };
}
