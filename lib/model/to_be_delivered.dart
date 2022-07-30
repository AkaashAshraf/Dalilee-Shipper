// To parse this JSON data, do
//
//     final ToBeDelivereddashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';


ToBeDeliveredDashbordModel dashbordToBeDeliveredModelFromJson(String str) => ToBeDeliveredDashbordModel.fromJson(json.decode(str));

String toBeDelivereddashbordModelToJson(ToBeDeliveredDashbordModel data) => json.encode(data.toJson());

class ToBeDeliveredDashbordModel {
    ToBeDeliveredDashbordModel({
        this.success,
        this.data,
    });

    String? success;
    ToBeDeliveredData? data;

    factory ToBeDeliveredDashbordModel.fromJson(Map<String, dynamic> json) => ToBeDeliveredDashbordModel(
        success: json["success"],
        data: ToBeDeliveredData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class ToBeDeliveredData {
    ToBeDeliveredData({
        this.totalShipments,
        this.shipmentsToDelivered,
        this.trackingStatuses,
    });

    int? totalShipments;
    List<ToBeDeliveredShipment>? shipmentsToDelivered;
    List<TrackingStatusTOBED>? trackingStatuses;

    factory ToBeDeliveredData.fromJson(Map<String, dynamic> json) => ToBeDeliveredData(
        totalShipments: json["total_to_be_delivered"],
        shipmentsToDelivered: List<ToBeDeliveredShipment>.from(json["return_shipments"].map((x) => ToBeDeliveredShipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusTOBED>.from(json["tracking_statuses"].map((x) => TrackingStatusTOBED.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_to_be_delivered": totalShipments,
        "return_shipments": List<dynamic>.from(shipmentsToDelivered!.map((x) => x.toJson())),
        "tracking_statuses": List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
    };
}

class ToBeDeliveredShipment {
    ToBeDeliveredShipment({
        this.orderId,
        this.orderNo,
        this.refId,
        this.cop,
        this.customerNo,
        this.weight,
        this.phone,
        this.shippingPrice,
        this.cod,
        this.currentStatus,
        this.orderActivities, required this.isOpen
    });

    dynamic orderId;
    dynamic orderNo;
    dynamic refId;
    dynamic cop;
    dynamic customerNo;
    dynamic weight;
    dynamic phone;
    dynamic shippingPrice;
    dynamic cod;
    dynamic currentStatus;
    List<OrderActivity>? orderActivities;
    bool isOpen;

    factory ToBeDeliveredShipment.fromJson(Map<String, dynamic> json) => ToBeDeliveredShipment(
       isOpen: false,
        orderId: json["order_id"],
        orderNo: json["order_no"],
        refId: json["ref_id"],
        cop: json["cop"],
        customerNo: json["customer_no"] == null ? null : json["customer_no"],
        weight: json["weight"] == null ? null : json["weight"],
        phone: json["phone"] == null ? null : json["phone"],
        shippingPrice: json["shipping_price"],
        cod: json["cod"],
        currentStatus: json["current_status"] == null ? null : json["current_status"],
        orderActivities: List<OrderActivity>.from(json["order_activities"].map((x) => OrderActivity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_no": orderNo,
        "ref_id": refId,
        "cop": cop,
        "customer_no": customerNo,
        "weight":  weight,
        "phone": phone,
        "shipping_price": shippingPrice,
        "cod": cod,
        "current_status": currentStatus,
        "order_activities": List<dynamic>.from(orderActivities!.map((x) => x.toJson())),
    };
}

class OrderActivity {
    OrderActivity({
        this.id,
        this.description,
        this.externalText,
        this.shortText,
        this.internalText,
        this.createdAt,
        this.updatedAt,
    });

    dynamic id;
    dynamic description;
    String? externalText;
    dynamic shortText;
    String? internalText;
    dynamic createdAt;
    dynamic updatedAt;

    factory OrderActivity.fromJson(Map<String, dynamic> json) => OrderActivity(
        id: json["id"],
        description: json["description"],
        externalText: json["external_text"] == null ? null : json["external_text"],
        shortText: json["short_text"],
        internalText: json["internal_text"] == null ? null : json["internal_text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "external_text": externalText == null ? null : externalText,
        "short_text": shortText,
        "internal_text": internalText == null ? null : internalText,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}



class TrackingStatusTOBED {
    TrackingStatusTOBED({
        this.id,
        this.statusAr,
        this.statusEng,
        this.icon,
    });

    dynamic id;
    dynamic statusAr;
    dynamic statusEng;
    dynamic icon;

    factory TrackingStatusTOBED.fromJson(Map<String, dynamic> json) => TrackingStatusTOBED(
        id: json["id"],
        statusAr: json["status_ar"],
        statusEng: json["status_eng"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status_ar": statusAr,
        "status_eng": statusEng,
        "icon": icon,
    };
}
