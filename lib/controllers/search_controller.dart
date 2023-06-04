import 'dart:developer';

import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment_listing.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool loading = false.obs;

  RxBool loadMore = false.obs;

  RxInt totalShipments = 0.obs;
  RxList<Shipment> shipments = <Shipment>[].obs;

  @override
  void onInit() {
    searchData();

    super.onInit();
  }

  searchData({
    bool isRefresh = false,
    String searchText = "",
  }) async {
    try {
      loading(true);
      if (!isRefresh) loadMore(true);

      var data = await post(
          "/shipments/order-search",
          {
            "order_id": searchText,
            "limit": "50",
            "offset": isRefresh ? "0" : shipments.length.toString(),
          },
          withAuth: false);
      // inspect(data);
      if (data != null) {
        var res = shipmentListAwsFromJson(data?.body);
        if (!isRefresh)
          shipments.value = [...shipments, ...res!.data?.shipments ?? []];
        else
          shipments.value = [...res!.data?.shipments ?? []];

        totalShipments.value = res.data?.totalShipments ?? 0;
      } else {}
    } finally {
      loading(false);

      loadMore(false);
    }
  }
}
