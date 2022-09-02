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
  RxBool inViewLoading_allShipments = true.obs;
  RxBool inViewLoading_deliveredShipments = true.obs;
  RxBool inViewLoading_to_be_pickupShipments = true.obs;
  RxBool inViewLoading_to_be_deliveredShipments = true.obs;
  RxBool inViewLoading_returnedShipments = true.obs;
  RxBool inViewLoading_cancelledShipments = true.obs;
// //// load more
  RxBool loadMore = false.obs;
  RxBool loadMore_deliveredShipments = false.obs;
  RxBool loadMore_to_be_deliveredShipments = false.obs;
  RxBool loadMore_to_bePickup = false.obs;
  RxBool loadMore_returnShipments = false.obs;
  RxBool loadMore_cancelShipments = false.obs;

  RxBool isLoadingf = false.obs;

  // ////// lists
  RxInt dashboard_allShiments = 0.obs;
  RxInt dashboard_to_b_Pichup = 0.obs;
  RxInt dashboard_deliveredShipments = 0.obs;
  RxInt dashboard_to_b_Delivered = 0.obs;
  RxInt dashboard_returnedShipment = 0.obs;
  RxInt dashboard_CancelledShiments = 0.obs;

  RxInt dashboard_undeliverdShiments = 0.obs;
  RxInt dashboard_OFDShiments = 0.obs;

// ///////limts
  RxInt limit_allShiments = 0.obs;
  RxInt limit_to_b_Pichup = 0.obs;
  RxInt limit_deliveredShipments = 0.obs;
  RxInt limit_to_b_Delivered = 0.obs;
  RxInt limit_returnedShipment = 0.obs;
  RxInt limit_CancelledShiments = 0.obs;

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

    fetchAllShipemetData();
    fetchDeliverShipemetData();
    fetchRetrunShipemetData();
    fetchcancellShipemetData();
    fetchToBeDeliveredShipemetData();
    fetchToBePickupData();
    super.onInit();
  }

  String? currentrote;
  //---------------------Api------------------
  RxList<Shipment> allShipemet = <Shipment>[].obs;
  RxList<TrackingStatus> allList = <TrackingStatus>[].obs;
  RxInt allShipmentNumber = 0.obs;
  fetchAllShipemetData({bool isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) limit_allShiments.value = 0;
      var allData = await DashboardApi.fetchAllShipemetData(
          "shipments?shipment_offset=$limit_allShiments&activity_offset=0");
      inViewLoading_allShipments.value = false;
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
      // print("total==============" + allShipemet.length.toString());
      isLoading(false);
      return null;
    }
  }

  //---------------------Delivered shp------------
  RxList<DeliveredShipment> deliverShipemet = <DeliveredShipment>[].obs;
  RxList<TrackingStatusDelivered> deliverList = <TrackingStatusDelivered>[].obs;
  RxInt deliverShipmentNumber = 0.obs;

  fetchMainDashBoardData() async {
    try {
      isLoading(true);

      var data = await DashboardApi.fetchMAinDashBoardData('');
      if (data != null) {
        dashboard_allShiments.value = data.data!.totalShipments!;
        dashboard_to_b_Pichup.value = data.data!.toBePickups!;
        dashboard_to_b_Delivered.value = data.data!.toBeDelivered!;
        dashboard_returnedShipment.value = data.data!.returnedShipments!;
        dashboard_CancelledShiments.value = data.data!.cancelShipments!;
        dashboard_deliveredShipments.value = data.data!.deliveredShipments!;
        dashboard_OFDShiments.value = data.data!.ofdShipments!;
        dashboard_undeliverdShiments.value = data.data!.deliveredShipments!;
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
        limit_deliveredShipments.value = 0;
        loadMore_deliveredShipments.value = false;
      } else {
        loadMore_deliveredShipments.value = true;
      }
      var deliverData = await DashboardApi.fetchDeliveredShipemetData(
          offset: limit_deliveredShipments);
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
      loadMore_deliveredShipments.value = false;

      isLoading(false);
    }
  }

  //------------Return Shipmenet---------------
  RxList<ReturnShipment> returnShipemet = <ReturnShipment>[].obs;
  RxList<TrackingStatusRetrun> returnList = <TrackingStatusRetrun>[].obs;
  RxInt returnShipmentNumber = 0.obs;
  fetchRetrunShipemetData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limit_returnedShipment.value = 0;
        loadMore_returnShipments.value = false;
      } else {
        loadMore_returnShipments.value = true;
      }
      var deliverData = await DashboardApi.fetchRetrunShipemetData(
          limit: limit_returnedShipment.value);
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
      inViewLoading_returnedShipments.value = false;
      loadMore_returnShipments.value = false;
    }
  }

  //------------Cancell Shipmenet---------------
  RxList<CancellShipment> cancellShipemet = <CancellShipment>[].obs;
  RxList<TrackingStatusCanc> cancellList = <TrackingStatusCanc>[].obs;
  RxInt cancellShipmentNumber = 0.obs;
  fetchcancellShipemetData({isRefresh: false}) async {
    try {
      if (isRefresh) {
        limit_CancelledShiments.value = 0;
        loadMore_cancelShipments.value = false;
      } else {
        loadMore_cancelShipments.value = true;
      }
      // isLoading(true);

      var deliverData = await DashboardApi.fetchCancellShipemetData(
          limit: limit_CancelledShiments);
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
      print("------===========>>>>>>>cancel===>" +
          cancellShipemet.length.toString());
      isLoading(false);
      loadMore_cancelShipments.value = false;
    }
  }

  //------------To be Delivered Shipmenet---------------
  RxList<ToBeDeliveredShipment> tobeDelShipemet = <ToBeDeliveredShipment>[].obs;
  RxList<TrackingStatusTOBED> toBeDelvList = <TrackingStatusTOBED>[].obs;
  RxInt toBeDelShipmentNumber = 0.obs;
  fetchToBeDeliveredShipemetData({isRefresh: false}) async {
    try {
      // isLoading(true);
      if (isRefresh) {
        limit_to_b_Delivered.value = 0;
        loadMore_to_be_deliveredShipments.value = false;
      } else {
        loadMore_to_be_deliveredShipments.value = true;
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
      inViewLoading_to_be_deliveredShipments.value = false;

      if (DashboardApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        DashboardApi.checkAuth = false;
      }
      loadMore_to_be_deliveredShipments.value = false;
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
        limit_to_b_Pichup.value = 0;
        loadMore_to_bePickup.value = false;
      } else {
        loadMore_to_bePickup.value = true;
      }
      var tobeData = await DashboardApi.fetchTobePickupData(
          limit: limit_to_b_Pichup.value);
      print("----------to-be-total:=>" +
          tobeData!.toBePickups!.length.toString());
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
      loadMore_to_bePickup.value = false;
    }
  }
}
