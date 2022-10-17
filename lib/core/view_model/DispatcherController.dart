import 'dart:convert';

import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/core/server/pickup_api.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:dalile_customer/model/Dispatcher/add_orders_response.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/model/wilayas_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispatcherController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchWillaya();
  }

  RxList<WilayaOM> willayas = <WilayaOM>[].obs;

  RxList<Area> regions = <Area>[].obs;
  RxBool loading = false.obs;
  RxBool loadingMyOrders = false.obs;
  RxInt totalOrder = 0.obs;

  RxList<Order> addList = <Order>[new Order()].obs;
  Rx<Order> currentOrder = Order().obs;

  RxList<Shipment> myOders = <Shipment>[].obs;
  fetchWillaya() async {
    final data = await PickupApi.fetchWilayaData(0);
    // print(data?.data.wilayaOMs?[0]);
    // List<DropDownListTemplate> res = willayas.map((element) {
    //   return DropDownListTemplate(label: element.name, id: element.id);
    // }).toList();

    regions.value = data?.data.areas ?? [];
    willayas.value = data?.data.wilayaOMs ?? [];
  }

  handleAddOrders(BuildContext context) async {
    try {
      loading(true);
      var arrToUpload = [];
      for (int i = 0; i < addList.length; i++) {
        arrToUpload.add({
          "name": addList[i].name,
          "phone": addList[i].phone,
          "cod": addList[i].cod.toString(),
          "address": addList[i].address,
          "wilaya_id": addList[i].willayaID.toString(),
          "area_id": addList[i].regionID.toString()
        });
      }
      var res = await postWithJsonBody(
          "/pickup/add-orders", json.encode({"orders": arrToUpload}));
      if (res != null) {
        var response = addOrderResponseFromJson(res.body);
        Get.snackbar('Successfull', response.message ?? "");
        Navigator.pop(context);
        Navigator.pop(context);

        // print(response.message);
      }
    } catch (e) {
    } finally {
      loading(false);
    }
  }

  fetchMyOrders({isRefresh: false}) async {
    try {
      var limit = "500";
      var offset = myOders.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "500";
        offset = "0";
      } else
        loadingMyOrders(true);
      var body = {
        "limit": limit,
        "offset": offset,
        "module": "shipper_self_orders"
      };
      var data = await dalileePost("/getStoresOrders", body);

      if (data != null) {
        final jsonData = shipmentListingFromJson(data.body);

        if (isRefresh)
          myOders.value = jsonData.data?.shipments ?? [];
        else
          myOders.value += jsonData.data?.shipments ?? [];
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', "Something went wrong. Try again");
        }
      }
    } finally {
      // myOders.value = [new Shipment()];
      loadingMyOrders(false);
    }
  }
}
