
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
  RxBool isLoadingf = false.obs;
  Rx<FinanceDashbordData> dashData = FinanceDashbordData().obs;
  void fetchFinanceDashbordData() async {
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
  
    fetchAllShipemetData();
    fetchDeliverShipemetData();
    fetchRetrunShipemetData();
    fetchcancellShipemetData();
    fetchToBeDeliveredShipemetData();
    fetchToBePickupData();
    fetchFinanceDashbordData();
    super.onInit();
  }

  String? currentrote;
  //---------------------Api------------------
  RxList<Shipment> allShipemet = <Shipment>[].obs;
  RxList<TrackingStatus> allList = <TrackingStatus>[].obs;
  RxInt allShipmentNumber = 0.obs;
  void fetchAllShipemetData() async {
  
    try {
      isLoading(true);

      var allData = await DashboardApi.fetchAllShipemetData("shipments");
      if (allData != null) {
        allShipmentNumber.value = allData.data!.totalShipments!;
        allShipemet.value = allData.data!.shipments!;
        allList.value = allData.data!.trackingStatuses!;
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

  //---------------------Delivered shp------------
  RxList<DeliveredShipment> deliverShipemet = <DeliveredShipment>[].obs;
  RxList<TrackingStatusDelivered> deliverList = <TrackingStatusDelivered>[].obs;
  RxInt deliverShipmentNumber = 0.obs;
  void fetchDeliverShipemetData() async {
    try {
      isLoading(true);

      var deliverData = await DashboardApi.fetchDeliveredShipemetData();
      if (deliverData != null) {
        deliverShipmentNumber.value = deliverData.data!.totalShipments!;
        deliverShipemet.value = deliverData.data!.deliveredShipment!;
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
      isLoading(false);
    }
  }

  //------------Return Shipmenet---------------
  RxList<ReturnShipment> returnShipemet = <ReturnShipment>[].obs;
  RxList<TrackingStatusRetrun> returnList = <TrackingStatusRetrun>[].obs;
  RxInt returnShipmentNumber = 0.obs;
  void fetchRetrunShipemetData() async {
    try {
      isLoading(true);

      var deliverData = await DashboardApi.fetchRetrunShipemetData();
      if (deliverData != null) {
        returnShipmentNumber.value = deliverData.data!.totalShipments!;
        returnShipemet.value = deliverData.data!.retrunShipment!;
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
    }
  }

  //------------Cancell Shipmenet---------------
  RxList<CancellShipment> cancellShipemet = <CancellShipment>[].obs;
  RxList<TrackingStatusCanc> cancellList = <TrackingStatusCanc>[].obs;
  RxInt cancellShipmentNumber = 0.obs;
  void fetchcancellShipemetData() async {
    try {
      isLoading(true);

      var deliverData = await DashboardApi.fetchCancellShipemetData();
      if (deliverData != null) {
        cancellShipmentNumber.value = deliverData.data!.totalShipments!;
        cancellShipemet.value = deliverData.data!.cancellshipments!;
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
    }
  }

  //------------To be Delivered Shipmenet---------------
  RxList<ToBeDeliveredShipment> tobeDelShipemet = <ToBeDeliveredShipment>[].obs;
  RxList<TrackingStatusTOBED> toBeDelvList = <TrackingStatusTOBED>[].obs;
  RxInt toBeDelShipmentNumber = 0.obs;
  void fetchToBeDeliveredShipemetData() async {
    try {
      isLoading(true);

      var deliverData = await DashboardApi.fetchTobeDeliveredData();
      if (deliverData != null) {
        toBeDelShipmentNumber.value = deliverData.data!.totalShipments!;
        tobeDelShipemet.value = deliverData.data!.shipmentsToDelivered!;
        toBeDelvList.value = deliverData.data!.trackingStatuses!;
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

  //------------To be Pickup--------------
  RxList<ToBePickup> tobePickup = <ToBePickup>[].obs;

  RxInt toBePickupNumber = 0.obs;

  void fetchToBePickupData() async {
    try {
      isLoading(true);

      var tobeData = await DashboardApi.fetchTobePickupData();
      if (tobeData != null) {
        toBePickupNumber.value = tobeData.totalToBePickups!;
        tobePickup.value = tobeData.toBePickups!;
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
}
