// To parse this JSON data, do
//
//     final CancelldashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';


CancellDashbordModel dashbordCancellModelFromJson(String str) => CancellDashbordModel.fromJson(json.decode(str));

String cancelldashbordModelToJson(CancellDashbordModel data) => json.encode(data.toJson());

class CancellDashbordModel {
    CancellDashbordModel({
        this.success,
        this.data,
    });

    String? success;
    CancellData? data;

    factory CancellDashbordModel.fromJson(Map<String, dynamic> json) => CancellDashbordModel(
        success: json["success"],
        data: CancellData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class CancellData {
    CancellData({
        this.totalShipments,
        this.cancellshipments,
        this.trackingStatuses,
    });

    int? totalShipments;
    List<CancellShipment>? cancellshipments;
    List<TrackingStatusCanc>? trackingStatuses;

    factory CancellData.fromJson(Map<String, dynamic> json) => CancellData(
        totalShipments: json["total_cancel_shipments"],
        cancellshipments: List<CancellShipment>.from(json["cancel_shipments"].map((x) => CancellShipment.fromJson(x))),
        trackingStatuses: List<TrackingStatusCanc>.from(json["tracking_statuses"].map((x) => TrackingStatusCanc.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_cancel_shipments": totalShipments,
        "cancel_shipments": List<dynamic>.from(cancellshipments!.map((x) => x.toJson())),
        "tracking_statuses": List<dynamic>.from(trackingStatuses!.map((x) => x.toJson())),
    };
}

class CancellShipment {
    CancellShipment({
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
    List<OrderActivityCancell>? orderActivities;
    bool isOpen;

    factory CancellShipment.fromJson(Map<String, dynamic> json) => CancellShipment(
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
        orderActivities: List<OrderActivityCancell>.from(json["order_activities"].map((x) => OrderActivityCancell.fromJson(x))),
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

class OrderActivityCancell {
    OrderActivityCancell({
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

    factory OrderActivityCancell.fromJson(Map<String, dynamic> json) => OrderActivityCancell(
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



class TrackingStatusCanc {
    TrackingStatusCanc({
        this.id,
        this.statusAr,
        this.statusEng,
        this.icon,
    });

    dynamic id;
    dynamic statusAr;
    dynamic statusEng;
    dynamic icon;

    factory TrackingStatusCanc.fromJson(Map<String, dynamic> json) => TrackingStatusCanc(
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
