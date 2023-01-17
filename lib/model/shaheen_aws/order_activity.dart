import 'package:dalile_customer/model/shaheen_aws/activity.dart';

class OrderActivity {
  OrderActivity({
    this.date = "",
    required this.activities,
  });

  String date;
  List<Activity?> activities;

  factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        date: json["date"],
        activities: json["activities"] == null
            ? []
            : json["activities"] == null
                ? []
                : List<Activity?>.from(
                    json["activities"]!.map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "activities": List<dynamic>.from(activities.map((x) => x!.toJson())),
      };
}
