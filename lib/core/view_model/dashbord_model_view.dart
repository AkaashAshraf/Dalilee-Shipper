import 'package:dalile_customer/core/server/dashbord_api.dart';
import 'package:dalile_customer/model/all_shipment.dart';
import 'package:dalile_customer/model/cancelled_shipment.dart';
import 'package:dalile_customer/model/delivered_shipment.dart';
import 'package:dalile_customer/model/finance_dashbord.dart';
import 'package:dalile_customer/model/return_shipment.dart';
import 'package:dalile_customer/model/to_be_delivered.dart';
import 'package:dalile_customer/model/to_be_picku.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:get/get.dart';

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

// ///////limts
  RxInt limitAllShiments = 0.obs;
  RxInt limitToBePichup = 0.obs;
  RxInt limitUndeliver = 0.obs;
  RxInt limitDeliveredShipments = 0.obs;
  RxInt limitToBeDelivered = 0.obs;
  RxInt limitReturnedShipment = 0.obs;
  RxInt limitCancelledShiments = 0.obs;
  RxInt limitOfdShiments = 0.obs;

  Rx<FinanceDashbordData> dashData = FinanceDashbordData().obs;
  fetchFinanceDashbordData() async {
    try {
      isLoadingf(true);
      var data = await DashboardApi.fetchFinanceDashData();
      if (data != null) {
        dashData(data);
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      isLoadingf(false);
    }
  }

  @override
  void onInit() {
    fetchMainDashBoardData();
    fetchFinanceDashbordData();

    fetchAllShipemetData(isRefresh: true);
    fetchDeliverShipemetData(isRefresh: true);
    fetchRetrunShipemetData(isRefresh: true);
    fetchcancellShipemetData(isRefresh: true);
    // fetchToBeDeliveredShipemetData(isRefresh: true);
    fetchToBePickupData(isRefresh: true);
    fetchUnDeliverShipemetData(isRefresh: true);
    fetchOFDShipemetData(isRefresh: true);
    super.onInit();
  }

  String? currentrote;
  //---------------------Api------------------
  RxList<Shipment> allShipemet = <Shipment>[].obs;
  RxList<TrackingStatus> allList = <TrackingStatus>[].obs;
  RxList<TrackingStatus> unDeliverStatuses = <TrackingStatus>[].obs;

  RxInt allShipmentNumber = 0.obs;
  fetchAllShipemetData({bool isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) limitAllShiments.value = 0;
      var allData = await DashboardApi.fetchAllShipemetData(
          "shipments?shipment_offset=$limitAllShiments&activity_offset=0");
      // var allData = await DashboardApi.fetchAllShipemetData("");
      loadMore.value = false;

      if (allData != null) {
        allShipmentNumber.value = allData.data!.totalShipments!;
        if (isRefresh)
          allShipemet.value = allData.data!.shipments!;
        else
          allShipemet.value += allData.data!.shipments!;
        allList.value = allData.data!.trackingStatuses!;
        return allData.data!.shipments;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingallShipments(false);
      isLoading(false);
      return null;
    }
  }

  //---------------------Delivered shp------------
  RxList<Shipment> deliverShipemet = <Shipment>[].obs;
  RxList<Shipment> undeliverShipemet = <Shipment>[].obs;
  RxList<TrackingStatusDelivered> deliverList = <TrackingStatusDelivered>[].obs;
  RxInt deliverShipmentNumber = 0.obs;

  fetchMainDashBoardData() async {
    try {
      isLoading(true);

      var data = await DashboardApi.fetchMAinDashBoardData('');
      if (data != null) {
        dashboardAllShiments.value = data.data!.totalShipments!;
        dashboardToBePichup.value = data.data!.toBePickups!;
        dashboardToBeDelivered.value = data.data!.toBeDelivered!;
        dashboardReturnedShipment.value = data.data!.returnedShipments!;
        dashboardCancelledShiments.value = data.data!.cancelShipments!;
        dashboardDeliveredShipments.value = data.data!.deliveredShipments!;
        dashboardOFDShiments.value = data.data!.ofdShipments!;
        dashboardUndeliverdShiments.value = data.data!.deliveredShipments!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
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

  fetchDeliverShipemetData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limitDeliveredShipments.value = 0;
        loadMoreDeliveredShipments.value = false;
      } else {
        loadMoreDeliveredShipments.value = true;
      }
      var deliverData = await DashboardApi.fetchDeliveredShipemetData(
          offset: limitDeliveredShipments);
      if (deliverData != null) {
        if (isRefresh) {
          deliverShipemet.value = deliverData.data!.deliveredShipment!;
        } else
          deliverShipemet.value += deliverData.data!.deliveredShipment!;

        deliverShipmentNumber.value = deliverData.data!.totalShipments!;
        deliverList.value = deliverData.data!.trackingStatuses!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      loadMoreDeliveredShipments.value = false;
      inViewLoadingdeliveredShipments(false);
      isLoading(false);
    }
  }

  fetchUnDeliverShipemetData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limitUndeliver.value = 0;
        loadMoreUndeliver.value = false;
      } else {
        loadMoreUndeliver.value = true;
      }
      var undeliverData = await DashboardApi.fetchUnDeliveredShipemetData(
          offset: limitUndeliver);
      if (undeliverData != null) {
        unDeliverStatuses.value = undeliverData.data!.trackingStatuses!;

        if (isRefresh) {
          undeliverShipemet.value = undeliverData.data!.undeliveredShipments!;
        } else
          undeliverShipemet.value += undeliverData.data!.undeliveredShipments!;

        dashboardUndeliver.value =
            undeliverData.data!.totalUndeliveredShipments!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      loadMoreDeliveredShipments.value = false;

      inViewLoadingUndeliver(false);
    }
  }

  //------------Return Shipmenet---------------
  RxList<Shipment> returnShipemet = <Shipment>[].obs;
  RxList<TrackingStatusRetrun> returnList = <TrackingStatusRetrun>[].obs;
  RxInt returnShipmentNumber = 0.obs;
  fetchRetrunShipemetData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limitReturnedShipment.value = 0;
        loadMoreReturnShipments.value = false;
      } else {
        loadMoreReturnShipments.value = true;
      }
      var deliverData = await DashboardApi.fetchRetrunShipemetData(
          limit: limitReturnedShipment.value);
      if (deliverData != null) {
        if (isRefresh) {
          returnShipemet.value = deliverData.data!.retrunShipment!;
        } else
          returnShipemet.value += deliverData.data!.retrunShipment!;

        returnShipmentNumber.value = deliverData.data!.totalShipments!;
        returnList.value = deliverData.data!.trackingStatuses!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      isLoading(false);
      inViewLoadingReturnedShipments.value = false;
      loadMoreReturnShipments.value = false;
    }
  }

  //------------Cancell Shipmenet---------------
  RxList<Shipment> cancellShipemet = <Shipment>[].obs;
  RxList<TrackingStatusCanc> cancellList = <TrackingStatusCanc>[].obs;
  RxInt cancellShipmentNumber = 0.obs;
  fetchcancellShipemetData({isRefresh: false}) async {
    try {
      if (isRefresh) {
        limitCancelledShiments.value = 0;
        loadMoreCancelShipments.value = false;
      } else {
        loadMoreCancelShipments.value = true;
      }
      // isLoading(true);

      var deliverData = await DashboardApi.fetchCancellShipemetData(
          limit: limitCancelledShiments);
      if (deliverData != null) {
        if (isRefresh) {
          cancellShipemet.value = deliverData.data!.cancellshipments!;
        } else
          cancellShipemet.value += deliverData.data!.cancellshipments!;

        cancellShipmentNumber.value = deliverData.data!.totalShipments!;
        cancellList.value = deliverData.data!.trackingStatuses!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      isLoading(false);
      inViewLoadingCancelledShipments(false);
      loadMoreCancelShipments.value = false;
    }
  }

  RxList<Shipment> ofdShipemet = <Shipment>[].obs;
  RxList<TrackingStatus> ofdlList = <TrackingStatus>[].obs;
  fetchOFDShipemetData({isRefresh: false}) async {
    try {
      if (isRefresh) {
        limitOfdShiments.value = 0;
        loadMoreOFDShipments.value = false;
      } else {
        loadMoreOFDShipments.value = true;
      }
      // isLoading(true);

      var ofdData =
          await DashboardApi.fetchOFDShipemetData(limit: limitOfdShiments);
      if (ofdData != null) {
        if (isRefresh) {
          ofdShipemet.value = ofdData.data!.ofdShipments!;
        } else
          ofdShipemet.value += ofdData.data!.ofdShipments!;

        dashboardOFDShiments.value = ofdData.data!.totalOfdShipments!;
        ofdlList.value = ofdData.data!.trackingStatuses!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      inViewLoadingOFDShipments(false);
      isLoading(false);
      loadMoreOFDShipments.value = false;
    }
  }

  //------------To be Delivered Shipmenet---------------
  RxList<Shipment> tobeDelShipemet = <Shipment>[].obs;
  RxList<TrackingStatusTOBED> toBeDelvList = <TrackingStatusTOBED>[].obs;
  RxInt toBeDelShipmentNumber = 0.obs;
  fetchToBeDeliveredShipemetData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limitToBeDelivered.value = 0;
        loadMoreToBeDeliveredShipments.value = false;
      } else {
        loadMoreToBeDeliveredShipments.value = true;
      }

      var deliverData = await DashboardApi.fetchTobeDeliveredData();
      if (deliverData != null) {
        if (isRefresh) {
          tobeDelShipemet.value = deliverData.data!.ofdShipments!;
        } else {
          tobeDelShipemet.value += deliverData.data!.ofdShipments!;
        }
        toBeDelShipmentNumber.value = deliverData.data!.totalOfdShipments!;
        toBeDelvList.value = deliverData.data!.trackingStatuses!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      inViewLoadingToBeDeliveredShipments.value = false;

      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      loadMoreToBeDeliveredShipments.value = false;
      isLoading(false);
    }
  }

  //------------To be Pickup--------------
  RxList<ToBePickup> tobePickup = <ToBePickup>[].obs;

  RxInt toBePickupNumber = 0.obs;

  fetchToBePickupData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limitToBePichup.value = 0;
        loadMoreToBePickup.value = false;
      } else {
        loadMoreToBePickup.value = true;
      }
      ToBePickupData? tobeData =
          await DashboardApi.fetchTobePickupData(limit: limitToBePichup.value);
     
      if (tobeData != null) {
        if (isRefresh) {
          tobePickup.value = tobeData.toBePickups!;
        } else {
          tobePickup.value += tobeData.toBePickups!;
        }
        toBePickupNumber.value = tobeData.totalToBePickups!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', DashboardApi.mass);
        }
      }
    } finally {
      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      isLoading(false);
      loadMoreToBePickup.value = false;
    }
  }
}
