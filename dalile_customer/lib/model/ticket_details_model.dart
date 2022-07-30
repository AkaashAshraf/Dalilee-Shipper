// To parse this JSON data, do
//
//     final ticketDetailsModel = ticketDetailsModelFromJson(jsonString);

import 'dart:convert';

TicketDetailsModel ticketDetailsModelFromJson(String str) => TicketDetailsModel.fromJson(json.decode(str));

String ticketDetailsModelToJson(TicketDetailsModel data) => json.encode(data.toJson());

class TicketDetailsModel {
    TicketDetailsModel({
        this.ticketDetails,
    });

    TicketDetails? ticketDetails;

    factory TicketDetailsModel.fromJson(Map<String, dynamic> json) => TicketDetailsModel(
        ticketDetails: TicketDetails.fromJson(json["ticket_details"]),
    );

    Map<String, dynamic> toJson() => {
        "ticket_details": ticketDetails!.toJson(),
    };
}

class TicketDetails {
    TicketDetails({
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
        this.orderNo,
        this.ratting,
        this.comments,
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
    dynamic ratting;
    List<Comment>? comments;

    factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
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
        sectionId: json["section_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDeleted: json["is_deleted"],
        orderNo: json["order_no"],
        ratting: json["ratting"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
        "section_id": sectionId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_deleted": isDeleted,
        "order_no": orderNo,
        "ratting": ratting,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
    };
}

class Comment {
    Comment({
        this.id,
        this.ticketId,
        this.userId,
        this.body,
        this.files,
        this.hash,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    dynamic id;
    dynamic ticketId;
    dynamic userId;
    dynamic body;
    dynamic files;
    dynamic hash;
    dynamic createdAt;
    dynamic updatedAt;
    User? user;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        ticketId: json["ticket_id"],
        userId: json["user_id"],
        body: json["body"],
        files:  List<String>.from(json["files"].map((x) => x)??[]),
        hash: json["hash"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_id": ticketId,
        "user_id": userId,
        "body": body,
        "files":  List<dynamic>.from(files!.map((x) => x)),
        "hash": hash,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user!.toJson(),
    };
}
class User {
    User({
        this.id,
        this.name,
        this.profile,
        this.avatar,
    });

    dynamic id;
    dynamic name;
    dynamic profile;
    dynamic avatar;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        profile: json["profile"],
        avatar: json["avatar"] ,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile": profile,
        "avatar": avatar ,
    };
}
