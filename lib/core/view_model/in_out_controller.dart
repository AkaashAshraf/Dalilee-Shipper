import 'dart:developer';

import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment_listing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class INOUTController extends GetxController {
  int defaultLimit = 50;

  RxBool loading = false.obs;
  RxBool loadMore = false.obs;

  RxInt totalOFD = 0.obs;
  RxInt totalDA1 = 0.obs;
  RxInt totalDA2 = 0.obs;
  RxInt totalCA1 = 0.obs;
  RxInt totalCA2 = 0.obs;
  RxInt totalAll = 0.obs;
  RxInt totalOUT = 0.obs;
  RxInt totalIN = 0.obs;

  RxList<Shipment> ordersOFD = <Shipment>[].obs;
  RxList<Shipment> ordersCA1 = <Shipment>[].obs;
  RxList<Shipment> ordersCA2 = <Shipment>[].obs;
  RxList<Shipment> ordersDA1 = <Shipment>[].obs;
  RxList<Shipment> ordersDA2 = <Shipment>[].obs;
  RxList<Shipment> ordersALL = <Shipment>[].obs;
  RxList<Shipment> ordersIN = <Shipment>[].obs;
  RxList<Shipment> ordersOUT = <Shipment>[].obs;

  setData({required Data data, required String type, bool isRefresh = false}) {
    switch (type) {
      case "all":
        {
          totalAll(data.totalShipments);
          ordersALL(!isRefresh ? ordersALL + data.shipments : data.shipments);
          break;
        }
      case "OFD":
        {
          totalOFD(data.totalShipments);
          ordersOFD(!isRefresh ? ordersOFD + data.shipments : data.shipments);
          break;
        }
      case "delivery_attempts1":
        {
          totalDA1(data.totalShipments);
          ordersDA1(!isRefresh ? ordersDA1 + data.shipments : data.shipments);
          break;
        }
      case "delivery_attempts2":
        {
          totalDA2(data.totalShipments);
          ordersDA2(!isRefresh ? ordersDA2 + data.shipments : data.shipments);
          break;
        }
      case "call_attempts1":
        {
          totalCA1(data.totalShipments);
          ordersCA1(!isRefresh ? ordersCA1 + data.shipments : data.shipments);
          break;
        }
      case "call_attempts2":
        {
          totalCA2(data.totalShipments);
          ordersCA2(!isRefresh ? ordersCA2 + data.shipments : data.shipments);
          break;
        }
      case "return":
        {
          totalOUT(data.totalShipments);
          ordersOUT(!isRefresh ? ordersOUT + data.shipments : data.shipments);
          break;
        }
      case "out":
        {
          totalIN(data.totalShipments);
          ordersIN(!isRefresh ? ordersIN + data.shipments : data.shipments);
          break;
        }
    }
  }

  @override
  void onInit() {
    fetchData(
        module: "all",
        type: "all",
        isRefresh: true,
        limit: defaultLimit,
        offset: 0,
        attempts: 1);
    // fetchData(
    //     module: "OFD",
    //     type: "OFD",
    //     isRefresh: true,
    //     limit: ordersOFD.length + defaultLimit,
    //     offset: ordersOFD.length,
    //     attempts: 1);
    // fetchData(
    //     module: "delivery_attempts",
    //     type: "delivery_attempts1",
    //     isRefresh: true,
    //     limit: ordersDA1.length + defaultLimit,
    //     offset: ordersDA1.length,
    //     attempts: 1);
    // fetchData(
    //     module: "delivery_attempts",
    //     type: "delivery_attempts2",
    //     isRefresh: true,
    //     limit: ordersDA2.length + defaultLimit,
    //     offset: ordersDA2.length,
    //     attempts: 2);
    // fetchData(
    //     module: "call_attempts",
    //     type: "call_attempts1",
    //     isRefresh: true,
    //     limit: ordersCA1.length + defaultLimit,
    //     offset: ordersCA1.length,
    //     attempts: 1);
    // fetchData(
    //     module: "call_attempts",
    //     type: "call_attempts2",
    //     isRefresh: true,
    //     limit: ordersCA2.length + defaultLimit,
    //     offset: ordersCA2.length,
    //     attempts: 2);
    // fetchData(
    //     module: "return",
    //     type: "return",
    //     isRefresh: true,
    //     limit: ordersIN.length + defaultLimit,
    //     offset: ordersIN.length,
    //     attempts: 1);

    super.onInit();
  }

  fetchData({
    required String module,
    required String type,
    bool isRefresh = true,
    String to = "",
    String from = "",
    int limit = 50,
    int offset = 0,
    int attempts = 1,
  }) async {
    try {
      if (isRefresh)
        loading(true);
      else
        loadMore(true);
      var response = await post("/shipments", {
        "module": module,
        "offset": offset.toString(),
        "limit": limit.toString(),
        "attempts": attempts.toString(),
      });
      // inspect(response);
      if (response != null) {
        var data = shipmentListAwsFromJson(response?.body);
        setData(
            data: data!.data!,
            type: to == "" ? type : "out",
            isRefresh: isRefresh);
      } else {
        Get.snackbar(response.statusCode.toString(), " ",
            colorText: Colors.orange);
      }
    } catch (e) {
      Get.snackbar(e.toString(), " ", colorText: Colors.red);
    } finally {
      loading(false);
      loadMore(false);
    }
  }
}
