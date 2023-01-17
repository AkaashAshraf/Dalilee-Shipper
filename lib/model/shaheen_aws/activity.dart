class Activity {
  Activity({
    this.id,
    this.logName,
    this.description,
    this.externalText,
    this.shortText,
    this.internalText,
    this.createdAt,
    this.updatedAt,
    this.trackingId,
    this.acitivityTime,
  });

  int? id;
  String? logName;
  String? description;
  String? externalText;
  String? shortText;
  String? internalText;
  String? createdAt;
  String? updatedAt;
  int? trackingId;
  String? acitivityTime;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        logName: json["log_name"],
        description: json["description"],
        externalText: json["external_text"],
        shortText: json["short_text"],
        internalText: json["internal_text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        trackingId: json["tracking_id"],
        acitivityTime: json["acitivity_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "log_name": logName,
        "description": description,
        "external_text": externalText,
        "short_text": shortText,
        "internal_text": internalText,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "tracking_id": trackingId,
        "acitivity_time": acitivityTime,
      };
}
