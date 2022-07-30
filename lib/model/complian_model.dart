// To parse this JSON data, do
//
//     final complainListModel = complainListModelFromJson(jsonString);

import 'dart:convert';

ComplainListModel complainListModelFromJson(String str) =>
    ComplainListModel.fromJson(json.decode(str));

String complainListModelToJson(ComplainListModel data) =>
    json.encode(data.toJson());

class ComplainListModel {
  ComplainListModel({
    this.tickets,
  });

  List<Ticket>? tickets;

  factory ComplainListModel.fromJson(Map<String, dynamic> json) =>
      ComplainListModel(
        tickets:
            List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tickets": List<dynamic>.from(tickets!.map((x) => x.toJson())),
      };
}

class Ticket {
  Ticket({
    this.id,
    this.ticketId,
    this.name,
    this.email,
    this.categoryId,
    this.subject,
    this.status,
    this.description,
    this.attachments,
    this.priority,
    this.creatorId,
    this.userId,
    this.departmentId,
    this.sectionId,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.orderNo
  });

  dynamic id;
  dynamic ticketId;
  dynamic name;
  dynamic email;
  dynamic categoryId;
  dynamic subject;
  dynamic status;
  dynamic description;
  dynamic attachments;
  dynamic priority;
  dynamic creatorId;
  dynamic userId;
  dynamic departmentId;
  dynamic sectionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic isDeleted;
  dynamic orderNo;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        ticketId: json["ticket_id"],
        name: json["name"],
        email: json["email"],
        categoryId: json["category_id"],
        subject: json["subject"],
        status: json["status"],
        description: json["description"],
        attachments: json["attachments"],
        priority: json["priority"],
        creatorId: json["creator_id"],
        userId: json["user_id"],
        departmentId: json["department_id"],
        sectionId: json["section_id"] == null ? null : json["section_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDeleted: json["is_deleted"],
        orderNo: json["order_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_id": ticketId,
        "name": name,
        "email": email,
        "category_id": categoryId,
        "subject": subject,
        "status": status,
        "description": description,
        "attachments": attachments,
        "priority": priority,
        "creator_id": creatorId,
        "user_id": userId,
        "department_id": departmentId,
        "section_id": sectionId == null ? null : sectionId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_deleted": isDeleted,
        "order_no":orderNo,
      };
}
