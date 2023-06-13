import 'dart:developer';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/assign_store/assign_store.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStoreController extends GetxController {
  RxBool loading = false.obs;
  RxBool assignLoading = false.obs;

  RxList<Store> stores = <Store>[].obs;
  RxBool loadMore = false.obs;

  @override
  void onInit() {
    searchData();

    super.onInit();
  }

  assignStore({required int storeID, required BuildContext context}) async {
    try {
      assignLoading(true);

      var data = await postAccountManager(
          accountManagerBaseUrl + "/assign-store",
          {"store_id": storeID.toString()});
      Get.back();
      if (data != null) {
        showDialog(
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBoxAl(
                title: "Success".tr,
                des: "store_has_been_assigned_Successfully".tr,
                icon: Icons.priority_high_outlined,
              );
            });
      } else {
        showDialog(
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBoxAl(
                title: "error".tr,
                error: true,
                des: "something_went_wrong".tr,
                icon: Icons.priority_high_outlined,
              );
            });
      }
    } finally {
      loading(false);
      assignLoading(false);
    }
  }

  searchData({
    bool isRefresh = false,
    String searchText = "",
  }) async {
    try {
      if (searchText.isEmpty) {
        stores.value = [];
        return;
      }
      loading(true);
      if (!isRefresh) loadMore(true);

      var data = await getWithUrl(accountManagerBaseUrl +
          "/search-all-stores?search_value=" +
          searchText);
      if (data != null) {
        var res = assignStoreFromJson(data?.body);
        // if (!isRefresh)
        stores.value = [...stores, ...res.data.stores];
        // else
        //   shipments.value = [...res!.data?.shipments ?? []];

        // totalShipments.value = res.data?.totalShipments ?? 0;
      } else {}
    } finally {
      loading(false);

      loadMore(false);
    }
  }
}
