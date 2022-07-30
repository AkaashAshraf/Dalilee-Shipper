// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
    OrderDetailsModel({
        this.success,
        this.data,
    });

    String? success;
    Data? data;

    factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.order,
    });

    List<Order>? order;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order!.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.storeId,
        this.orderId,
        this.storeName,
        this.storeContact,
        this.receiverName,
        this.receiverContact,
        this.cod,
        this.cc,
        this.wilaya,
        this.area,
        this.driverName,
        this.orderDate,
        this.orderStatus,
    });

    dynamic storeId;
    dynamic orderId;
    dynamic storeName;
    dynamic storeContact;
    dynamic receiverName;
    dynamic receiverContact;
    dynamic cod;
    dynamic cc;
    dynamic wilaya;
    dynamic area;
    dynamic driverName;
    dynamic orderDate;
    dynamic orderStatus;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        storeId: json["store_id"],
        orderId: json["order_id"],
        storeName: json["store_name"],
        storeContact: json["store_contact"],
        receiverName: json["receiver_name"],
        receiverContact: json["receiver_contact"],
        cod: json["cod"],
        cc: json["cc"],
        wilaya: json["wilaya"],
        area: json["area"],
        driverName: json["driver_name"],
        orderDate: json["order_date"],
        orderStatus: json["order_status"],
    );

    Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "order_id": orderId,
        "store_name": storeName,
        "store_contact": storeContact,
        "receiver_name": receiverName,
        "receiver_contact": receiverContact,
        "cod": cod,
        "cc": cc,
        "wilaya": wilaya,
        "area": area,
        "driver_name": driverName,
        "order_date": orderDate,
        "order_status": orderStatus,
    };
}
