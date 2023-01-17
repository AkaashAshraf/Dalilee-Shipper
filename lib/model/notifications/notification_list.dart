// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

Notifications? notificationsFromJson(String str) =>
    Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications? data) => json.encode(data!.toJson());

class Notifications {
  Notifications({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        status: json["status"],
        data: json["data"] == null ? Data() : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}

class Data {
  Data({
    this.notifications,
  });

  List<Notification>? notifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: json["notifications"] == null
            ? []
            : json["notifications"] == null
                ? []
                : List<Notification>.from(json["notifications"]!
                    .map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : notifications == null
                ? []
                : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    this.id,
    this.externalText,
    this.createdAt,
    this.orderId,
    this.rId,
  });

  int? id;
  String? externalText;
  String? createdAt;
  String? orderId;
  int? rId;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        externalText: json["external_text"],
        createdAt: json["created_at"],
        orderId: json["order_id"],
        rId: json["r_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_text": externalText,
        "created_at": createdAt,
        "order_id": orderId,
        "r_id": rId,
      };
}
