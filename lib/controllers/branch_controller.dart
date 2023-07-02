import 'dart:async';

import 'package:dalile_customer/core/server/branches_api.dart';
import 'package:dalile_customer/model/branch_model.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchController extends GetxController {
  RxBool isLoading = false.obs;
  bool isMapOpen = false;

  duringMap() {
    isMapOpen = true;
    update();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (t.tick == 1) {
        isMapOpen = false;
        t.cancel();
      }

      update();
    });
  }

  var branchListData = <Branch>[].obs;
  void fetchBrnchListData() async {
    try {
      isLoading(true);
      var data = await BranchApi.fetchBranchData();
      if (data != null) {
        branchListData.value = data.branches!.toList();
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, BranchApi.mass);
        }
      }
    } finally {
      if (BranchApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        BranchApi.checkAuth = false;
      }
      isLoading(false);
      addMarkers();
    }
  }

  launchWhatsapp(number) async {
    final url = "https://wa.me/$number?text= Hi";
    await launch(url);
    Get.back();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
    Get.back();
  }

  RxDouble lat = 23.6339057.obs;
  RxDouble lng = 58.1403187.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          size: Size(
            2,
            2,
          ),
          devicePixelRatio: 2),
      "assets/images/dalilee.png",
    );

    for (int x = 0; x < branchListData.length; x++) {
      markers.add(Marker(
        markerId: MarkerId("${branchListData[x].name ?? "$x"}$x"),
        position: LatLng(
            double.parse(branchListData[x].lat.toString()),
            double.parse(
                branchListData[x].lng.toString())), //position of marker
        rotation: -90,

        infoWindow: InfoWindow(
          //popup info

          title: branchListData[x].name.toString(),
          snippet: 'Dalilee Office',
        ),

        icon: markerbitmap, //Icon for Marker
      ));
    }
  }

  Timer? timer;
  @override
  void onInit() {
    fetchBrnchListData();

    super.onInit();
  }

  TextEditingController searchConter = TextEditingController();

  var searchResult = <Branch?>[].obs;
  onSearchTextChanged(text) async {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    for (var out in branchListData) {
      if (out.name!.toString().toLowerCase().contains(text.toLowerCase()) ||
          out.nameAr!.toString().toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(out);
      }
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(googleUrl);
  }
}
