// To parse this JSON data, do
//
//     final DeliveredDashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';


RetrunDashbordModel dashbordRetrunShipmentModelFromJson(String str) => RetrunDashbordModel.fromJson(json.decode(str));

String retrunDashbordModelToJson(RetrunDashbordModel data) => json.encode(data.toJson());

class RetrunDashbordModel {
    RetrunDashbordModel({
        this.success,
        this.data,
    });

    String? success;
    RetrunShipmentData? data;

    factory RetrunDashbordModel.fromJson(Map<String, dynamic> json) => RetrunDashbordModel(
        success: json["success"],
        data: RetrunShipmentData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class RetrunShipmentData {
    RetrunShipmentData({
        this.totalShipments,
        this.retrunShipment,
        this.trackingStatuses,
    });

    int? totalShipments;
    List<ReturnShipment>? retrunShipment;
    List<TrackingStatusRetrun>? trackingStatuses;

    factory RetrunShipmentData.fromJson(Map<String, dynamic> json) => RetrunShipmentData(
        totalShipments: json["total_returned_shipments"],
        retrunShipment: List<ReturnShipment>.from(json["return_shipments"].map((x) => ReturnShipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusRetrun>.from(json["tracking_statuses"].map((x) => TrackingStatusRetrun.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_delivered_shipments": totalShipments,
        "return_shipments": List<dynamic>.from(retrunShipment!.map((x) => x.toJson())),
        "tracking_statuses": List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
    };
}

class ReturnShipment {
    ReturnShipment({
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
    List<OrderActivityRetrun>? orderActivities;
    bool isOpen;

    factory ReturnShipment.fromJson(Map<String, dynamic> json) => ReturnShipment(
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
        orderActivities: List<OrderActivityRetrun>.from(json["order_activities"].map((x) => OrderActivityRetrun.fromJson(x))),
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

class OrderActivityRetrun {
    OrderActivityRetrun({
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

    factory OrderActivityRetrun.fromJson(Map<String, dynamic> json) => OrderActivityRetrun(
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



class TrackingStatusRetrun {
    TrackingStatusRetrun({
        this.id,
        this.statusAr,
        this.statusEng,
        this.icon,
    });

    dynamic id;
    dynamic statusAr;
    dynamic statusEng;
    dynamic icon;

    factory TrackingStatusRetrun.fromJson(Map<String, dynamic> json) => TrackingStatusRetrun(
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
