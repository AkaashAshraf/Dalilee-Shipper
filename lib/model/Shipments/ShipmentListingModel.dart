import 'dart:convert';

ShipmentListing shipmentListingFromJson(String str) =>
    ShipmentListing.fromJson(json.decode(str));

String shipmentListingToJson(ShipmentListing data) =>
    json.encode(data.toJson());

class ShipmentListing {
  ShipmentListing({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory ShipmentListing.fromJson(Map<String, dynamic> json) =>
      ShipmentListing(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.totalShipments,
    this.shipments,
  });

  int? totalShipments;
  List<Shipment>? shipments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalShipments:
            json["total_shipments"] == null ? 0 : json["total_shipments"],
        shipments: json["shipments"] == null
            ? []
            : List<Shipment>.from(
                json["shipments"].map((x) => Shipment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_shipments": totalShipments == null ? 0 : totalShipments,
        "shipments": shipments == null
            ? []
            : List<Shipment>.from(shipments!.map((x) => x.toJson())),
      };
}

class Shipment {
  Shipment(
      {this.orderId,
      this.orderNo,
      this.refId,
      this.cop,
      this.customerNo,
      this.customerName,
      this.cc,
      this.orderStatusName,
      this.orderStatusKey,
      this.orderPickupImage,
      this.orderDeliverImage,
      this.orderUndeliverImage,
      this.orderUndeliverImage2,
      this.orderUndeliverImage3,
      this.problemReasonId,
      this.problemReasons,
      this.traderComments,
      this.probllemId,
      this.problemResponse,
      this.weight,
      this.phone,
      this.shippingPrice,
      this.cod,
      this.createdAt,
      this.updatedAt,
      this.orderActivities,
      this.status,
      this.currentStatus,
      this.ccCurrency = "OMR",
      this.codCurrency = "OMR",
      this.currency = "OMR",
      this.shippingCurrency = "OMR",
      this.isOpen: false,
      this.wilayaName,
      this.areaName,
      this.isProblem: true,
      this.problemImage:
          "https://dalilee.net/cpdNew/app-api/uploads/2022/09/L27IGdT5ow7mwXeD-20220925082355PM.png",
      this.problemText:
          "Customer is not responding. Please contact with him if it ispossible. Customer is not responding. Please contact with him if it ispossible. Customer is not responding. Please contact with him if it ispossible. Customer is not responding. Please contact with him if it ispossible"});

  int? orderId;
  String? orderNo;
  int? refId;
  dynamic cop;
  dynamic customerNo;
  String? customerName;
  dynamic cc;
  bool isOpen;
  bool isProblem;
  String problemImage;
  String problemText;
  String? orderStatusName;
  String? orderStatusKey;
  String? orderPickupImage;
  String? orderDeliverImage;
  String? orderUndeliverImage;
  String? orderUndeliverImage2;
  String? orderUndeliverImage3;
  String ccCurrency, shippingCurrency, codCurrency, currency;

  dynamic problemReasonId;
  dynamic problemReasons;
  dynamic traderComments;
  int? probllemId;
  String? problemResponse;

  dynamic weight;
  String? phone;
  String? shippingPrice;
  String? cod;

  String? wilayaName;
  String? areaName;
  String? createdAt;
  String? updatedAt;
  List<OrderActivity>? orderActivities;
  dynamic status;
  int? currentStatus;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        orderId: json["order_id"] == null ? "" : json["order_id"],
        orderNo: json["order_no"] == null ? "" : json["order_no"],
        refId: json["ref_id"] == null ? 0 : json["ref_id"],
        cop: json["cop"] == null
            ? ""
            : json["cop"] == ""
                ? "0"
                : json["cop"],
        customerNo: json["customer_no"] == null ? "" : json["customer_no"],
        currency: json["currency"] ?? "OMR",
        ccCurrency: json["cc_currency"] ?? "OMR",
        codCurrency: json["cod_currency"] ?? "OMR",
        shippingCurrency: json["shipping_currency"] ?? "OMR",
        customerName:
            json["customer_name"] == null ? "" : json["customer_name"],
        cc: json["cc"] == null
            ? "0"
            : json["cc"] == ""
                ? "0"
                : json["cc"],
        orderStatusName:
            json["order_status_name"] == null ? "" : json["order_status_name"],
        orderStatusKey:
            json["order_status_key"] == null ? "" : json["order_status_key"],
        orderPickupImage: json["order_pickup_image"] == null
            ? ""
            : json["order_pickup_image"],
        orderDeliverImage: json["order_deliver_image"] == null
            ? ""
            : json["order_deliver_image"],
        orderUndeliverImage: json["order_undeliver_image"] ?? "",
        orderUndeliverImage2: json["order_undeliver_image2"] ?? "",
        orderUndeliverImage3: json["order_undeliver_image3"] ?? "",
        problemReasonId: json["problem_reason_id"] ?? "",
        problemReasons: json["problem_reasons"] ?? "",
        traderComments: json["trader_comments"] ?? "",
        probllemId: json["problem_id"] ?? 0,
        problemResponse: json["problem_response"] ?? "",
        wilayaName: json["wilaya_name"] ?? "",
        areaName: json["area_name"] ?? "",
        weight: json["weight"] == null
            ? 0
            : json["weight"] == ""
                ? "0"
                : json["weight"],
        phone: json["phone"] == null ? "" : json["phone"],
        shippingPrice: json["shipping_price"] == null
            ? "0.0"
            : json["shipping_price"] == ""
                ? "0"
                : json["shipping_price"],
        cod: json["cod"] == null
            ? "0"
            : json["cod"] == ""
                ? "0"
                : json["cod"],
        createdAt: json["created_at"] == null ? "" : json["created_at"],
        updatedAt: json["updated_at"] == null ? "" : json["updated_at"],
        orderActivities: json["order_activities"] == null
            ? []
            : List<OrderActivity>.from(
                json["order_activities"].map((x) => OrderActivity.fromJson(x))),
        status: json["status"],
        currentStatus:
            json["current_status"] == null ? 0 : json["current_status"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId == null ? null : orderId,
        "order_no": orderNo == null ? "" : orderNo,
        "ref_id": refId == null ? null : refId,
        "cop": cop == null
            ? "0"
            : cop == ""
                ? "0"
                : cop,
        "customer_no": customerNo == null ? "" : customerNo,
        "customer_name": customerName == null ? "" : customerName,
        "cc": cc == null
            ? "0"
            : cc == ""
                ? "0"
                : cc,
        "order_status_name": orderStatusName == null ? "" : orderStatusName,
        "order_status_key": orderStatusKey == null ? "" : orderStatusKey,
        "order_pickup_image": orderPickupImage == null ? "" : orderPickupImage,
        "order_deliver_image":
            orderDeliverImage == null ? "" : orderDeliverImage,
        "order_undeliver_image": orderUndeliverImage ?? "",
        "order_undeliver_image2": orderUndeliverImage2 ?? "",
        "order_undeliver_image3": orderUndeliverImage3 ?? "",
        "problem_reason_id": problemReasonId ?? "",
        "problem_reasons": problemReasons ?? "",
        "trader_comments": traderComments ?? "",
        "problem_id": probllemId ?? 0,
        "problem_response": problemResponse ?? "",
        "weight": weight == null ? 0 : weight,
        "phone": phone == null ? "" : phone,
        "wilaya_name": wilayaName == null ? "" : wilayaName,
        "area_name": areaName == null ? "" : areaName,
        "shipping_price": shippingPrice == null
            ? "0.0"
            : shippingPrice == ""
                ? "0"
                : shippingPrice,
        "cod": cod == null
            ? "0"
            : cod == ""
                ? "0"
                : cod,
        "created_at": createdAt == null ? "" : createdAt,
        "updated_at": updatedAt == null ? "" : updatedAt,
        "order_activities": orderActivities == null
            ? []
            : List<dynamic>.from(orderActivities!.map((x) => x.toJson())),
        "status": status,
        "current_status": currentStatus == null ? 0 : currentStatus,
      };
}

class OrderActivity {
  OrderActivity({
    this.id,
    this.status,
    this.externalText,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? status;
  dynamic externalText;
  String? createdAt;
  String? updatedAt;

  factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        id: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? 0 : json["status"],
        externalText:
            json["external_text"] == null ? "" : json["external_text"],
        createdAt: json["created_at"] == null ? "" : json["created_at"],
        updatedAt: json["updated_at"] == null ? "" : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "status": status == null ? 0 : status,
        "external_text": externalText == null ? "" : externalText,
        "created_at": createdAt == null ? "" : createdAt,
        "updated_at": updatedAt == null ? "" : updatedAt,
      };
}
