import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:get/get.dart';

class FinanceListingController extends GetxController {
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
      var res = await dalileePost("/storeFinanceOrders", body);

      return res;
    } catch (e) {
      return e;
    } finally {}
  } //getlist

  getAllOrders({bool isRefresh: false}) async {
    var limit = "50";
    var offset = listAll.length.toString();

    if (isRefresh) {
      limit = "50";
      offset = "0";
    } else {
      loadMoreAll(true);
    }

    try {
      var res = await getList(
          {"limit": limit, "offset": offset, "module": "total_amount"});
      if (res != null) {
        var json = shipmentListingFromJson(res.body);
        totalAll(json.data!.totalShipments);
        if (isRefresh)
          listAll.value = json.data!.shipments!;
        else
          listAll.value += json.data!.shipments!;
      }
    } catch (e) {
    } finally {
      loadMoreAll(false);
      loadingAll(false);
      inViewLoadingAll.value = false;
    }
  }

  getPaidOrders({bool isRefresh: false}) async {
    var limit = "50";
    var offset = listPaid.length.toString();

    if (isRefresh) {
      limit = "50";
      offset = "0";
    } else {
      loadMorePaid(true);
    }

    try {
      var res =
          await getList({"limit": limit, "offset": offset, "module": "paid"});
      if (res != null) {
        var json = shipmentListingFromJson(res.body);
        totalPaid(json.data!.totalShipments);
        if (isRefresh)
          listPaid.value = json.data!.shipments!;
        else
          listPaid.value += json.data!.shipments!;
      }
    } catch (e) {
    } finally {
      loadMorePaid(false);
      loadingPaid(false);
      inViewLoadingPaid(false);
    }
  }

  getCodPendingOrders({bool isRefresh: false}) async {
    var limit = "50";
    var offset = listCodPending.length.toString();

    if (isRefresh) {
      limit = "50";
      offset = "0";
    } else {
      loadMoreCodPending(true);
    }

    try {
      var res = await getList(
          {"limit": limit, "offset": offset, "module": "cod_pending"});
      if (res != null) {
        var json = shipmentListingFromJson(res.body);
        totalCodPending(json.data!.totalShipments);
        if (isRefresh)
          listCodPending.value = json.data!.shipments!;
        else
          listCodPending.value += json.data!.shipments!;
      }
    } catch (e) {
    } finally {
      loadMoreCodPending(false);
      loadingCodPending(false);
      inViewLoadingCodPending(false);
    }
  }

  getReadyToPayOrders({bool isRefresh: false}) async {
    var limit = "50";
    var offset = listReadyToPay.length.toString();

    if (isRefresh) {
      limit = "50";
      offset = "0";
    } else {
      loadMoreReadyToPay(true);
    }

    try {
      var res = await getList(
          {"limit": limit, "offset": offset, "module": "ready_to_pay"});
      if (res != null) {
        var json = shipmentListingFromJson(res.body);
        totalReadyToPay(json.data!.totalShipments);
        if (isRefresh)
          listReadyToPay.value = json.data!.shipments!;
        else
          listReadyToPay.value += json.data!.shipments!;
      }
    } catch (e) {
    } finally {
      loadMoreReadyToPay(false);
      loadingReadyToPay(false);
      inViewLoadingReadyToPay(false);
    }
  }

  getCodWithDriversOrders({bool isRefresh: false}) async {
    var limit = "50";
    var offset = listCodWithDrivers.length.toString();

    if (isRefresh) {
      limit = "50";
      offset = "0";
    } else {
      loadMoreCodWithDrivers(true);
    }

    try {
      var res = await getList(
          {"limit": limit, "offset": offset, "module": "cod_with_drivers"});
      if (res != null) {
        var json = shipmentListingFromJson(res.body);
        totalCodWithDrivers(json.data!.totalShipments);
        if (isRefresh)
          listCodWithDrivers.value = json.data!.shipments!;
        else
          listCodWithDrivers.value += json.data!.shipments!;
      }
    } catch (e) {
    } finally {
      loadMoreCodWithDrivers(false);
      loadingCodWithDrivers(false);
      inViewLoadingCodWithDrivers(false);
    }
  }

  getCodReturnOrders({bool isRefresh: false}) async {
    var limit = "50";
    var offset = listCodReturn.length.toString();

    if (isRefresh) {
      limit = "50";
      offset = "0";
    } else {
      loadMoreCodReturn(true);
    }

    try {
      var res = await getList(
          {"limit": limit, "offset": offset, "module": "cod_returned"});
      if (res != null) {
        var json = shipmentListingFromJson(res.body);
        totalCodReturn(json.data!.totalShipments);
        if (isRefresh)
          listCodReturn.value = json.data!.shipments!;
        else
          listCodReturn.value += json.data!.shipments!;
      }
    } catch (e) {
    } finally {
      loadMoreCodReturn(false);
      loadingCodReturn(false);
      inViewLoadingCodReturn(false);
    }
  }
}
