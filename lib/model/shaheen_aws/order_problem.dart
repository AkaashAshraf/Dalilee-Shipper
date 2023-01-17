import 'package:dalile_customer/model/shaheen_aws/problem_category.dart';

class OrderProblem {
  OrderProblem({
    this.id = 0,
    this.requestId = 0,
    this.driverId = 0,
    this.auditorId,
    this.auditorComment,
    this.auditorResponse,
    this.traderComments,
    this.statusCode,
    this.rescheduleDate,
    this.auditDate,
    this.createdAt = "",
    this.updatedAt = "",
    required this.problemReason,
  });

  int id;
  int requestId;
  int driverId;
  dynamic auditorId;
  dynamic auditorComment;
  dynamic auditorResponse;
  dynamic traderComments;
  dynamic statusCode;
  dynamic rescheduleDate;
  dynamic auditDate;
  String createdAt;
  String updatedAt;
  ProblemReason problemReason;

  factory OrderProblem.fromJson(Map<String, dynamic> json) => OrderProblem(
        id: json["id"] ?? 0,
        requestId: json["request_id"] ?? 0,
        driverId: json["driver_id"] ?? 0,
        auditorId: json["auditor_id"],
        auditorComment: json["auditor_comment"],
        auditorResponse: json["auditor_response"],
        traderComments: json["trader_comments"],
        statusCode: json["status_code"],
        rescheduleDate: json["reschedule_date"],
        auditDate: json["audit_date"],
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        problemReason: json["problem_reason"] == null
            ? ProblemReason()
            : ProblemReason.fromJson(json["problem_reason"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "request_id": requestId,
        "driver_id": driverId,
        "auditor_id": auditorId,
        "auditor_comment": auditorComment,
        "auditor_response": auditorResponse,
        "trader_comments": traderComments,
        "status_code": statusCode,
        "reschedule_date": rescheduleDate,
        "audit_date": auditDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "problem_reason": problemReason,
      };
}
