import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/dashbord_api.dart';
import 'package:dalile_customer/model/Dashboard/MainDashboardModel.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DashbordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool inViewLoadingallShipments = true.obs;
  RxBool inViewLoadingdeliveredShipments = true.obs;
  RxBool inViewLoadingToBePickupShipments = true.obs;
  RxBool inViewLoadingToBeDeliveredShipments = true.obs;
  RxBool inViewLoadingOFDShipments = true.obs;
  RxBool inViewLoadingUndeliver = true.obs;
  RxBool inViewLoadingReturnedShipments = true.obs;
  RxBool inViewLoadingCancelledShipments = true.obs;
  RxBool isIOSVersionServerCheck = false.obs;
  RxBool isAndroidVersionServerCheck = false.obs;
  RxInt iosServerVerison = 0.obs;
  RxInt androidServerVerison = 0.obs;

// //// load more
  RxBool loadMore = false.obs;
  RxBool loadMoreDeliveredShipments = false.obs;
  RxBool loadMoreToBeDeliveredShipments = false.obs;
  RxBool loadMoreUndeliver = false.obs;
  RxBool loadMoreToBePickup = false.obs;
  RxBool loadMoreReturnShipments = false.obs;
  RxBool loadMoreCancelShipments = false.obs;
  RxBool loadMoreOFDShipments = false.obs;

  RxBool isLoadingf = false.obs;

  // ////// lists
  RxInt dashboardAllShiments = 0.obs;
  RxInt dashboardToBePichup = 0.obs;
  RxInt dashboardUndeliver = 0.obs;
  RxInt dashboardDeliveredShipments = 0.obs;
  RxInt dashboardToBeDelivered = 0.obs;
  RxInt dashboardReturnedShipment = 0.obs;
  RxInt dashboardCancelledShiments = 0.obs;
  RxInt dashboardUndeliverdShiments = 0.obs;
  RxInt dashboardOFDShiments = 0.obs;

  RxString totalAmount = "0".obs;
  RxString paidAmount = "0".obs;
  RxString codPendingAmount = "0".obs;
  RxString readyToPayAmount = "0".obs;
  RxString codReturnAmount = "0".obs;
  RxString codWithDriversAmount = "0".obs;
  RxString codReturn = "0".obs;
  RxString shipmentCost = "0".obs;

  RxString totalOrderAmountOrdersCount = "".obs;
  RxString paidAmountOrdersCount = "".obs;
  RxString codPendingOrdersCount = "".obs;
  RxString readyToPayOrdersCount = "".obs;
  RxString codOfdOrdersCount = "".obs;
  RxString shippingCostOrdersCount = "".obs;
  RxString codReturnedOrdersCount = "".obs;

  @override
  void onInit() {
    fetchMainDashBoardData();
    fetchFinanceDashbordData();
    fetchAllShipmentData(isRefresh: true);
    fetchDeliverShipemetData(isRefresh: true);
    fetchUnDeliverShipemetData(isRefresh: true);
    fetchRetrunShipemetData(isRefresh: true);
    fetchcancellShipemetData(isRefresh: true);
    fetchOFDShipemetData(isRefresh: true);
    super.onInit();
  }

  //---------------------Api------------------
  RxList<Shipment?> allShipemet = <Shipment?>[].obs;
  RxList<Shipment?> deliverShipemet = <Shipment?>[].obs;
  RxList<Shipment?> undeliverShipemet = <Shipment?>[].obs;
  RxList<TrackingStatus> trackingStatuses = <TrackingStatus>[].obs;
  RxList<Shipment?> returnShipemet = <Shipment?>[].obs;
  RxList<Shipment?> cancellShipemet = <Shipment?>[].obs;
  RxList<Shipment?> ofdShipemet = <Shipment?>[].obs;
  RxList<Shipment?> tobeDelShipemet = <Shipment?>[].obs;

  fetchMainDashBoardData() async {
    try {
      isLoading(true);

      var data = await DashboardApi.fetchMainDashBoardData('');
      if (data != null) {
        dashboardAllShiments.value = data.data!.stats!.totalShipments!;
        // dashboardToBePichup.value = data.data!.toBePickups!;
        dashboardToBeDelivered.value = data.data!.stats!.toBeDelivered!;
        dashboardReturnedShipment.value = data.data!.stats!.returnedShipments!;
        dashboardCancelledShiments.value = data.data!.stats!.cancelShipments!;
        dashboardDeliveredShipments.value =
            data.data!.stats!.deliverdShipments!;
        dashboardOFDShiments.value = data.data!.stats!.ofdShipments!;
        dashboardUndeliverdShiments.value =
            data.data!.stats!.undeliveredShipments!;
        trackingStatuses.value = data.data!.trackingStatuses!;
        isIOSVersionServerCheck(data.isIosVersionCheck);
        isAndroidVersionServerCheck(data.isAndroidVersionCheck);
        iosServerVerison(data.iosVersion);
        androidServerVerison(data.andriodVersion);
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      isLoading(false);
    }
  }

  fetchFinanceDashbordData() async {
    try {
      // isLoadingf(true);
      var data = await DashboardApi.fetchFinanceDashData();

      if (data != null) {
        totalAmount.value = data.totalAmount.toString();
        paidAmount.value = data.paid.toString();
        codPendingAmount.value = data.codPending.toString();
        readyToPayAmount.value = data.readyToPay.toString();
        codWithDriversAmount.value = data.codWithDrivers.toString();
        codReturn.value = data.codReturned.toString();
        shipmentCost.value = data.totalShippingAmount.toString();

        totalOrderAmountOrdersCount(data.totalAmountCount.toString());
        paidAmountOrdersCount(data.paidCount.toString());
        shippingCostOrdersCount(data.totalShippingAmountCount.toString());
        codPendingOrdersCount(data.codPendingCount.toString());
        readyToPayOrdersCount(data.readyToPayCount.toString());
        codOfdOrdersCount(data.codWithDriversCount.toString());
        codReturnedOrdersCount(data.codReturnedCount.toString());
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } catch (err) {
      // print(err.toString());
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      isLoadingf(false);
    }
  }

  fetchAllShipmentData({bool isRefresh: false}) async {
    try {
      var limit = "50";
      var offset = allShipemet.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "50";
        offset = "0";
      }
      // limit = "1";
      // offset = "249";
      var body = {"limit": limit, "offset": offset, "module": "shipments"};
      var data = await DashboardApi.fetchShipmentList(body);
      // inspect(data);
      // var allData = await DashboardApi.fetchAllShipemetData("");
      loadMore.value = false;
      // return;

      if (data != null) {
        dashboardAllShiments.value = data.data!.totalShipments!;
        if (isRefresh)
          allShipemet.value = data.data!.shipments;
        else
          allShipemet.value += data.data!.shipments;
        return data.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingallShipments(false);
      isLoading(false);
    }
  }

  fetchDeliverShipemetData({isRefresh: false}) async {
    try {
      var limit = "50";
      var offset = deliverShipemet.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "50";
        offset = "0";
      } else
        loadMoreDeliveredShipments(true);
      var body = {
        "limit": limit,
        "offset": offset,
        "module": "delivered_shipments"
      };
      var data = await DashboardApi.fetchShipmentList(body);

      if (data != null) {
        dashboardDeliveredShipments.value = data.data!.totalShipments!;
        if (isRefresh)
          deliverShipemet.value = data.data!.shipments;
        else
          deliverShipemet.value += data.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingdeliveredShipments(false);
      loadMoreDeliveredShipments.value = false;

      isLoading(false);
    }
  }

  fetchUnDeliverShipemetData({isRefresh: false}) async {
    try {
      var limit = "50";
      var offset = undeliverShipemet.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "50";
        offset = "0";
      } else
        loadMoreUndeliver(true);
      var body = {
        "limit": limit,
        "offset": offset,
        "module": "undelivered_shipments"
      };
      var data = await DashboardApi.fetchShipmentList(body);

      if (data != null) {
        dashboardUndeliver.value = data.data!.totalShipments!;
        if (isRefresh)
          undeliverShipemet.value = data.data!.shipments;
        else
          undeliverShipemet.value += data.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingUndeliver(false);
      loadMoreUndeliver.value = false;

      isLoading(false);
    }
  }

  fetchRetrunShipemetData({isRefresh: false}) async {
    try {
      var limit = "50";
      var offset = returnShipemet.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "50";
        offset = "0";
      } else
        loadMoreReturnShipments(true);
      var body = {
        "limit": limit,
        "offset": offset,
        "module": "return_shipments"
      };
      var data = await DashboardApi.fetchShipmentList(body);

      if (data != null) {
        dashboardReturnedShipment.value = data.data!.totalShipments!;
        if (isRefresh)
          returnShipemet.value = data.data!.shipments;
        else
          returnShipemet.value += data.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingReturnedShipments(false);
      loadMoreReturnShipments.value = false;

      isLoading(false);
    }
  }

  fetchcancellShipemetData({isRefresh: false}) async {
    try {
      var limit = "50";
      var offset = cancellShipemet.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "50";
        offset = "0";
      } else
        loadMoreCancelShipments(true);
      var body = {
        "limit": limit,
        "offset": offset,
        "module": "cancel_shipments"
      };
      var data = await DashboardApi.fetchShipmentList(body);

      if (data != null) {
        dashboardCancelledShiments.value = data.data!.totalShipments!;
        if (isRefresh)
          cancellShipemet.value = data.data!.shipments;
        else
          cancellShipemet.value += data.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingCancelledShipments(false);
      loadMoreCancelShipments.value = false;

      isLoading(false);
    }
  }

  fetchOFDShipemetData({isRefresh: false}) async {
    try {
      var limit = "50";
      var offset = ofdShipemet.length.toString();

      // isLoading(true);
      if (isRefresh) {
        limit = "50";
        offset = "0";
      } else
        loadMoreOFDShipments(true);
      var body = {"limit": limit, "offset": offset, "module": "ofd_shipments"};
      var data = await DashboardApi.fetchShipmentList(body);

      if (data != null) {
        dashboardOFDShiments.value = data.data!.totalShipments!;
        if (isRefresh)
          ofdShipemet.value = data.data!.shipments;
        else
          ofdShipemet.value += data.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingOFDShipments(false);
      loadMoreOFDShipments.value = false;

      isLoading(false);
    }
  }

  void checkAppExpiry(BuildContext context) {
    if ((Platform.isAndroid &&
            isAndroidVersionServerCheck.value &&
            androidServerVerison.value != androidVersionLocal) ||
        (Platform.isIOS &&
            isIOSVersionServerCheck.value &&
            iosServerVerison.value != iosVersionLocal))
      Alert(
          onWillPopActive: true,
          closeIcon: Container(),
          context: context,
          type: AlertType.error,
          title: "app_expired".tr,
          desc: "please_update".tr,
          content: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    onPressed: () {
                      LaunchReview.launch(
                          androidAppId: "thiqatech.dalilee.account_manager",
                          iOSAppId: "1633078775");
                      // Navigator.pop(context);
                    },
                    child: Text("upgrade_now".tr)),
              )
            ],
          ),
          buttons: []).show();
  }
}
