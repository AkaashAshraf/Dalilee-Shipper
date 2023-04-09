import 'dart:async';
import 'dart:developer';

import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/core/server/pickup_api.dart';
import 'package:dalile_customer/model/Pickup/PickupModel.dart';
import 'package:dalile_customer/model/Pickup/fetch_auto_pickup_status.dart';
import 'package:dalile_customer/model/muhafaza_model.dart';
import 'package:dalile_customer/model/pickup_deatils.dart';
import 'package:dalile_customer/model/region_model.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment_listing.dart';
import 'package:dalile_customer/model/wilayas_model.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PickupController extends GetxController {
//---------------- validation----------------------
  int? muhafazaID, wilayaID, regionID;

  final GlobalKey<FormState> _formKeyRequest = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyRequest => _formKeyRequest;
  RxBool loadMoreAllPickup = false.obs;
  RxString pickupTime = "08:00".obs;
  RxBool loadMoreTodayPickup = false.obs;
  RxBool isAutoDailyPickup = false.obs;
  RxBool autoPickupLoading = false.obs;
  RxList<Shipment> pickupShipments = <Shipment>[].obs;

  RxInt totalAllPickup = 0.obs;
  RxInt totalTodayPickup = 0.obs;

  // requrstValidation(context) {
  //   if (_formKeyRequest.currentState!.validate()) {
  //     showDialog(
  //         barrierDismissible: true,
  //         barrierColor: Colors.transparent,
  //         context: context,
  //         builder: (BuildContext context) {
  //           return const CustomDialogBoxAl(
  //             title: "Done !!",
  //             des: "pickup requested successfully",
  //             icon: Icons.priority_high_outlined,
  //           );
  //         });
  //   }
  // }

  muhafazaVal(value) async {
    wCont.clear();
    wilayaID = null;
    for (int i = 0; i < muhafazaList.length; i++) {
      if (muhafazaList[i]!.name == value) {
        muhafazaID = muhafazaList[i]!.id;
        muhafazaCont.text = value;
        fetchWilayaData(muhafazaList[i]!.id);
      }
    }
  }

  wilayaVal(value) {
    rCont.clear();
    regionID = null;
    for (int i = 0; i < wilayaList.length; i++) {
      if (wilayaList[i]!.name == value) {
        wCont.text = value;
        wilayaID = wilayaList[i]!.id;
        fetchRegionData(wilayaList[i]!.id);
      }
    }

    update();
  }

  regionVal(value) {
    for (int i = 0; i < regionList.length; i++) {
      if (regionList[i]!.name == value) {
        regionID = regionList[i]!.id;
        rCont.text = value;
      }
    }

    update();
  }
//---------------- validation----------------------

  var isLoadingToday = true.obs;
  var isLoadingDetails = false.obs;

  var isLoadingAll = true.obs;
  var muhafazaList = <Governate?>[].obs;
  RxList<Reference?> allPickup = <Reference?>[].obs;
  RxList<Reference?> today = <Reference?>[].obs;

  var wilayaList = <WilayaOM?>[].obs;
  var regionList = <AreaRegion?>[].obs;

  @override
  void onInit() {
    fetchMuhafazaData();
    fetchTodayPickupData();
    fetchAllPickupData(isRefresh: true);

    super.onInit();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
//----------------Api Data----------------------

  fetchAllPickupData({bool isRefresh = false}) async {
    try {
      if (!isRefresh) loadMoreAllPickup(true);

      var pickup = await PickupApi.fetchAllPickupData("",
          listLength: allPickup.length, isRefresh: isRefresh, tab: "all");
      if (pickup != null) {
        totalAllPickup.value = pickup.totalReferences!;
        if (isRefresh)
          allPickup.value = pickup.references!;
        else
          allPickup.value += pickup.references!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', PickupApi.mass);
        }
      }
    } finally {
      if (PickupApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        PickupApi.checkAuth = false;
      }
      loadMoreAllPickup.value = false;

      isLoadingAll(false);
    }
  }

  fetchAutoPickupStatus() async {
    autoPickupLoading(true);
    try {
      final result = await post("/pickup/trader-pickup-time", {});
      if (result != null) {
        final jsonData = fetchAutoPickupResponseFromJson(result?.body);
        // print(jsonData.data?.isActive);
        pickupTime.value = jsonData.data?.pickupTime ?? "08:00";
        isAutoDailyPickup.value = jsonData.data?.isActive ?? false;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      autoPickupLoading(false);
    }
  }

  void fetchAllPostData(context) async {
    try {
      if (_formKeyRequest.currentState!.validate()) {
        Get.dialog(const WaiteImage(),
            barrierColor: Colors.transparent, barrierDismissible: false);

        bool? postRequst = await PickupApi.fetchPostRequestPickupData(
            1, wilayaID, regionID,
            context: context);

        if (postRequst != null && postRequst == true) {
        } else {
          Get.back();

          if (!Get.isSnackbarOpen) {
            Get.snackbar('Failed', PickupApi.mass);
          }
        }
      }
    } finally {
      muhafazaCont.clear();
      rCont.clear();
      wCont.clear();
      wilayaID = null;
      regionID = null;
    }
  }

  fetchTodayPickupData({bool isRefresh = false}) async {
    try {
      // print("pickup called ");
      // isLoadingToday(true);
      if (!isRefresh) loadMoreTodayPickup(true);

      var pickupToday = await PickupApi.fetchAllPickupData("",
          listLength: today.length, isRefresh: isRefresh, tab: "today");
      if (pickupToday != null) {
        totalTodayPickup.value = pickupToday.totalReferences!;
        if (isRefresh)
          today.value = pickupToday.references!;
        else
          today.value += pickupToday.references!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', PickupApi.mass);
        }
      }
    } finally {
      isLoadingToday(false);
      loadMoreTodayPickup.value = false;
    }
  }

  RxList<Order> pickupDetailsList = <Order>[].obs;
  void fetcPickupDetailsDataOld(ref) async {
    try {
      // isLoadingToday(true);
      isLoadingDetails(true);
      var data = await PickupApi.fetchPickupDetailsData(ref);
      if (data != null) {
        pickupDetailsList.value = data.data!.orders!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, PickupApi.mass);
        }
      }
    } finally {
      isLoadingDetails(false);
    }
  }

  void fetcPickupDetailsData(
      {bool isRefresh = false, required String collectionID}) async {
    try {
      // isLoadingToday(true);
      isLoadingDetails(true);
      var data = await post("/dashboard/shipments", {
        "module": "collection_orders",
        "limit": "500",
        "offset": "0",
        "collection_id": collectionID
      });
      inspect(data);
      if (data != null) {
        var res = shipmentListAwsFromJson(data?.body);
        pickupShipments.value = res?.data?.shipments ?? [];
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, PickupApi.mass);
        }
      }
    } finally {
      isLoadingDetails(false);
    }
  }

  void fetchMuhafazaData() async {
    try {
      isLoadingToday(true);

      var muhafaza = await PickupApi.fetchMuhafazaData();
      if (muhafaza != null) {
        muhafazaList.value = muhafaza.data!.governates!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', PickupApi.mass);
        }
      }
    } finally {
      isLoadingToday(false);
    }
  }

  void fetchWilayaData(muhafazaId) async {
    Get.dialog(
      const Center(child: CupertinoActivityIndicator()),
      barrierColor: Colors.transparent,
    );
    try {
      var waliaya = await PickupApi.fetchWilayaData(muhafazaId)
          .whenComplete(() => Get.back());
      if (waliaya != null) {
        wilayaList.value = waliaya.data.wilayaOMs!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Error', PickupApi.mass);
        }
      }
    } finally {}
  }

  void fetchRegionData(muhafazaId) async {
    Get.dialog(
      const Center(child: CupertinoActivityIndicator()),
      barrierColor: Colors.transparent,
    );
    try {
      var region = await PickupApi.fetchRegionData(muhafazaId)
          .whenComplete(() => Get.back());
      if (region != null) {
        regionList.value = region.data!.areaRegions!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Error', PickupApi.mass);
        }
      }
    } finally {}
  }

  TextEditingController muhafazaCont = TextEditingController();
  TextEditingController wCont = TextEditingController();
  TextEditingController rCont = TextEditingController();
//----------------Api Data----------------------

}
