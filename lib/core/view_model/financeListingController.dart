import 'package:dalile_customer/model/Finance/finance_Listing.dart';
import 'package:get/get.dart';
import 'package:dalile_customer/model/all_shipment.dart';

import 'package:dalile_customer/core/http/http.dart';

import '../../model/all_shipment.dart';

class FinanceListingController extends GetxController {
  RxList<TrackingStatus> trackingStatuses = <TrackingStatus>[].obs;
// limit
  RxInt limitAll = 0.obs;
  RxInt limitPaid = 0.obs;
  RxInt limitCodPending = 0.obs;
  RxInt limitReadyToPay = 0.obs;
  RxInt limitCodWithDrivers = 0.obs;
  RxInt limitCodReturn = 0.obs;

// total
  RxInt totalAll = 0.obs;
  RxInt totalPaid = 0.obs;
  RxInt totalCodPending = 0.obs;
  RxInt totalReadyToPay = 0.obs;
  RxInt totalCodWithDrivers = 0.obs;
  RxInt totalCodReturn = 0.obs;

// loading
  RxBool loadingAll = false.obs;
  RxBool loadingPaid = false.obs;
  RxBool loadingCodPending = false.obs;
  RxBool loadingReadyToPay = false.obs;
  RxBool loadingCodWithDrivers = false.obs;
  RxBool loadingCodReturn = false.obs;

// loadMore
  RxBool loadMoreAll = false.obs;
  RxBool loadMorePaid = false.obs;
  RxBool loadMoreCodPending = false.obs;
  RxBool loadMoreReadyToPay = false.obs;
  RxBool loadMoreCodWithDrivers = false.obs;
  RxBool loadMoreCodReturn = false.obs;

// ///// in view loading
  RxBool inViewLoadingAll = true.obs;
  RxBool inViewLoadingPaid = true.obs;
  RxBool inViewLoadingCodPending = true.obs;
  RxBool inViewLoadingReadyToPay = true.obs;
  RxBool inViewLoadingCodWithDrivers = true.obs;
  RxBool inViewLoadingCodReturn = true.obs;

// list
  var listAll = <Shipment>[].obs;
  var listPaid = <Shipment>[].obs;
  var listCodPending = <Shipment>[].obs;
  var listReadyToPay = <Shipment>[].obs;
  var listCodWithDrivers = <Shipment>[].obs;
  var listCodReturn = <Shipment>[].obs;
  @override
  void onInit() async {
    // getAll_orders();
    try {
      getAllOrders(isRefresh: true);
      getPaidOrders(isRefresh: true);
      getCodPendingOrders(isRefresh: true);
      getReadyToPayOrders(isRefresh: true);
      getCodWithDriversOrders(isRefresh: true);
      getCodReturnOrders(isRefresh: true);
    } catch (e) {}

    super.onInit();
  }

  getList(dynamic body) async {
    try {
      var res = await post('/dashboard/shipments-finance', body);

      return res;
    } catch (e) {
      return e;
    } finally {}
  } //getlist

  getAllOrders({bool isRefresh: false}) async {
    // print('call again');
    if (isRefresh)
      limitAll(0);
    else
      loadMoreAll(true);
    if (limitAll.value != 0 && limitAll.value >= totalAll.value) {
      loadMoreAll(false);
      loadingAll(false);
      return;
    }
    try {
      var res = await getList(
          {"shipment_offset": limitAll.toString(), "module": "total_amount"});
      var json = financeListingFromJson(res.body);
      totalAll(json.data!.totalShipments);
      trackingStatuses.value = json.data!.trackingStatuses!;
      limitAll.value += 10;
      if (isRefresh)
        listAll.value = json.data!.shipments!;
      else
        listAll.value += json.data!.shipments!;
      print(listAll.value);
    } catch (e) {
      print(e);
    } finally {
      loadMoreAll(false);
      loadingAll(false);
      inViewLoadingAll.value = false;
    }
  }

  getPaidOrders({bool isRefresh: false}) async {
    if (isRefresh)
      limitPaid(0);
    else
      loadMorePaid(true);
    if (limitPaid.value != 0 && limitPaid.value >= totalPaid.value) {
      loadMorePaid(false);
      loadingPaid(false);
      return;
    }
    try {
      var res = await getList(
          {"shipment_offset": limitPaid.toString(), "module": "paid"});
      var json = financeListingFromJson(res.body);
      totalPaid(json.data!.totalShipments);
      trackingStatuses.value = json.data!.trackingStatuses!;
      limitPaid.value += 10;
      if (isRefresh)
        listPaid.value = json.data!.shipments!;
      else
        listPaid.value += json.data!.shipments!;
    } catch (e) {
      print(e);
    } finally {
      loadMorePaid(false);
      loadingPaid(false);
      inViewLoadingPaid(false);
    }
  }

  getCodPendingOrders({bool isRefresh: false}) async {
    if (isRefresh)
      limitCodPending(0);
    else
      loadMoreCodPending(true);
    if (limitCodPending.value != 0 &&
        limitCodPending.value >= totalCodPending.value) {
      loadMoreCodPending(false);
      loadingCodPending(false);
      return;
    }
    try {
      var res = await getList({
        "shipment_offset": limitCodPending.toString(),
        "module": "cod_pending"
      });
      var json = financeListingFromJson(res.body);
      totalCodPending(json.data!.totalShipments);
      trackingStatuses.value = json.data!.trackingStatuses!;
      limitCodPending.value += 10;
      if (isRefresh)
        listCodPending.value = json.data!.shipments!;
      else
        listCodPending.value += json.data!.shipments!;
    } catch (e) {
    } finally {
      loadMoreCodPending(false);
      loadingCodPending(false);
      inViewLoadingCodPending(false);
    }
  }

  getReadyToPayOrders({bool isRefresh: false}) async {
    if (isRefresh)
      limitReadyToPay(0);
    else {
      loadMoreReadyToPay(true);
      if (limitReadyToPay.value != 0 &&
          limitReadyToPay.value >= totalReadyToPay.value) {
        loadMoreReadyToPay(false);
        loadingReadyToPay(false);

        return;
      }
    }
    try {
      print('its fetching');

      var res = await getList({
        "shipment_offset": limitReadyToPay.toString(),
        "module": "ready_to_pay"
      });

      var json = financeListingFromJson(res.body);
      totalReadyToPay(json.data!.totalShipments);
      trackingStatuses.value = json.data!.trackingStatuses!;
      limitReadyToPay.value += 10;
      if (isRefresh)
        listReadyToPay.value = json.data!.shipments!;
      else
        listReadyToPay.value += json.data!.shipments!;
    } catch (e) {
      print(e);
    } finally {
      loadMoreReadyToPay(false);
      loadingReadyToPay(false);
      inViewLoadingReadyToPay(false);
    }
  }

  getCodWithDriversOrders({bool isRefresh: false}) async {
    if (isRefresh)
      limitCodWithDrivers(0);
    else {
      loadMoreCodWithDrivers(true);
      if (limitCodWithDrivers.value != 0 &&
          limitCodWithDrivers.value >= totalCodWithDrivers.value) {
        loadMoreCodWithDrivers(false);
        loadingCodWithDrivers(false);
        return;
      }
    }
    try {
      print('its fetching');

      var res = await getList({
        "shipment_offset": limitCodWithDrivers.toString(),
        "module": "cod_with_drivers"
      });
      var json = financeListingFromJson(res.body);
      totalCodWithDrivers(json.data!.totalShipments);
      trackingStatuses.value = json.data!.trackingStatuses!;
      limitCodWithDrivers.value += 10;
      if (isRefresh)
        listCodWithDrivers.value = json.data!.shipments!;
      else
        listCodWithDrivers.value += json.data!.shipments!;
    } catch (e) {
      print(e);
    } finally {
      loadMoreCodWithDrivers(false);
      loadingCodWithDrivers(false);
      inViewLoadingCodWithDrivers(false);
    }
  }

  getCodReturnOrders({bool isRefresh: false}) async {
    if (isRefresh)
      limitCodReturn(0);
    else
      loadMoreCodReturn(true);
    if (limitCodReturn.value != 0 &&
        limitCodReturn.value >= totalCodReturn.value) {
      loadMoreCodReturn(false);
      loadingCodReturn(false);
      return;
    }
    try {
      var res = await getList({
        "shipment_offset": limitCodReturn.toString(),
        "module": "cod_returned"
      });
      var json = financeListingFromJson(res.body);
      totalCodReturn(json.data!.totalShipments);
      trackingStatuses.value = json.data!.trackingStatuses!;
      limitCodReturn.value += 10;
      if (isRefresh)
        listCodReturn.value = json.data!.shipments!;
      else
        listCodReturn.value += json.data!.shipments!;
    } catch (e) {
      print(e);
    } finally {
      loadMoreCodReturn(false);
      loadingCodReturn(false);
      inViewLoadingCodReturn(false);
    }
  }
}
