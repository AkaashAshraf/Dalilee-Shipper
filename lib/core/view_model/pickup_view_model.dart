import 'dart:async';

import 'package:dalile_customer/core/server/pickup_api.dart';
import 'package:dalile_customer/model/all_pickup_model.dart';
import 'package:dalile_customer/model/muhafaza_model.dart';
import 'package:dalile_customer/model/pickup_deatils.dart';
import 'package:dalile_customer/model/region_model.dart';
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
  var isLoadingAll = true.obs;
  var muhafazaList = <Governate?>[].obs;
  var allPickup = <Reference?>[].obs;
  var today = <Reference?>[].obs;

  var wilayaList = <WilayaOM?>[].obs;
  var regionList = <AreaRegion?>[].obs;

  @override
  void onInit() {
    fetchMuhafazaData();
    fetchTodayPickupData();
    fetchAllPickupData();

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

  void fetchAllPickupData() async {
    try {
      isLoadingAll(true);

      var pickup = await PickupApi.fetchAllPickupData("");
      if (pickup != null) {
        allPickup.value = pickup.references!.reversed.toList();
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
      isLoadingAll(false);
    }
  }

  void fetchAllPostData(context) async {
    try {
      if (_formKeyRequest.currentState!.validate()) {
        Get.dialog(const WaiteImage(),
            barrierColor: Colors.transparent, barrierDismissible: false);

        bool? postRequst =
            await PickupApi.fetchPostRequestPickupData(1, wilayaID, regionID);
        Get.back();
        if (postRequst != null && postRequst == true) {
          showDialog(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBoxAl(
                  title: "Done !!",
                  des: "pickup requested successfully",
                  icon: Icons.priority_high_outlined,
                );
              });
        } else {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Filed', PickupApi.mass);
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

  void fetchTodayPickupData() async {
    try {
      isLoadingToday(true);

      var pickupToday = await PickupApi.fetchAllPickupData("today");
      if (pickupToday != null) {
        today.value = pickupToday.references!.reversed.toList();
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', PickupApi.mass);
        }
      }
    } finally {
      isLoadingToday(false);
    }
  }

  RxList<Order> pickupDetailsList = <Order>[].obs;
  void fetcPickupDetailsData(ref) async {
    try {
      isLoadingToday(true);

      var data = await PickupApi.fetchPickupDetailsData(ref);
      if (data != null) {
        pickupDetailsList.value = data.data!.orders!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', PickupApi.mass);
        }
      }
    } finally {
      isLoadingToday(false);
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
