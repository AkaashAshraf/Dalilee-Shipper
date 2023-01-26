import 'package:dalile_customer/model/shaheen_aws/order_activity.dart';
import 'package:dalile_customer/model/shaheen_aws/order_problem.dart';
import 'package:dalile_customer/model/shaheen_aws/problem_category.dart';

class Shipment {
  Shipment({
    this.rId = 0,
    this.orderId = "",
    this.refId = 0,
    this.cop,
    this.customerNo = "",
    this.customerName = "",
    this.cc,
    this.orderStatusName = "",
    this.orderStatusKey = "",
    this.pickupImage = "",
    this.orderImage = "",
    this.undeliverImage = "",
    this.undeliverImage2 = "",
    this.undeliverImage3 = "",
    this.weight = "",
    this.shippingPrice,
    this.cod,
    this.wilayaName = "",
    this.areaName = "",
    this.addedByStore = 0,
    this.storeId = 0,
    this.orderProblem,
    this.createdAt = "",
    this.updatedAt = "",
    this.trackingId = 0,
    this.deliveryAttempts = "",
    this.callAttempts = "",
    this.isOpen = false,
    required this.orderActivities,
  });

  int rId;
  String orderId;
  int refId;
  bool isOpen;
  dynamic cop;
  String customerNo;
  String customerName;
  dynamic cc;
  String orderStatusName;
  String orderStatusKey;
  String pickupImage;
  String orderImage;
  String undeliverImage;
  String undeliverImage2;
  String undeliverImage3;
  String weight;
  dynamic shippingPrice;
  dynamic cod;

  String? deliveryAttempts;
  String? callAttempts;
  String wilayaName;
  String areaName;
  int addedByStore;
  int storeId;
  OrderProblem? orderProblem;
  String createdAt;
  String updatedAt;
  int trackingId;
  List<OrderActivity?> orderActivities;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        rId: json["r_id"] ?? 0,
        orderId: json["order_id"].toString(),
        refId: json["ref_id"] ?? 0,
        cop: json["cop"] ?? 0,
        customerNo: json["customer_no"] ?? "",
        customerName: json["customer_name"] ?? "",
        cc: json["cc"],
        orderStatusName: json["order_status_name"] ?? "",
        orderStatusKey: json["order_status_key"] ?? "",
        pickupImage: json["pickup_image"] ?? "",
        orderImage: json["order_image"] ?? "",
        undeliverImage: json["undeliver_image"] ?? "",
        undeliverImage2: json["undeliver_image2"] ?? "",
        undeliverImage3: json["undeliver_image3"] ?? "",
        weight: json["weight"] ?? "",
        shippingPrice: json["shipping_price"],
        cod: json["cod"],
        deliveryAttempts: json["delivery_attempts"] ?? "",
        callAttempts: json["call_attempts"] ?? "",
        wilayaName: json["wilaya_name"] ?? "",
        areaName: json["area_name"] ?? "",
        addedByStore: json["added_by_store"] ?? 0,
        storeId: json["store_id"] ?? 0,
        orderProblem: json["order_problem"] == null
            ? OrderProblem(problemReason: ProblemReason())
            : OrderProblem.fromJson(json["order_problem"]),
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        trackingId: json["tracking_id"] ?? 0,
        orderActivities: json["order_activities"] == null
            ? []
            : json["order_activities"] == null
                ? []
                : List<OrderActivity?>.from(json["order_activities"]!
                    .map((x) => OrderActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "r_id": rId,
        "order_id": orderId,
        "ref_id": refId,
        "cop": cop,
        "customer_no": customerNo,
        "customer_name": customerName,
        "cc": cc,
        "order_status_name": orderStatusName,
        "order_status_key": orderStatusKey,
        "pickup_image": pickupImage,
        "order_image": orderImage,
        "undeliver_image": undeliverImage,
        "undeliver_image2": undeliverImage2,
        "undeliver_image3": undeliverImage3,
        "weight": weight,
        "shipping_price": shippingPrice,
        "cod": cod,
        "wilaya_name": wilayaName,
        "area_name": areaName,
        "added_by_store": addedByStore,
        "store_id": storeId,
        "delivery_attempts": deliveryAttempts,
        "call_attempts": callAttempts,
        "order_problem": orderProblem,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "tracking_id": trackingId,
        "order_activities":
            List<dynamic>.from(orderActivities.map((x) => x!.toJson())),
      };
}
