import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QrCodeController extends GetxController {
  RxString cdeQR = ''.obs;
  RxString loat = ''.obs;
  RxString lang = ''.obs;
  RxBool isWinting = false.obs;
  @override
  void onInit() {
    _getUserLocation();
    super.onInit();
  }

  Future<void> _getUserLocation() async {
    try {
      var position = await GeolocatorPlatform.instance.getCurrentPosition();

      final currentPostion = LatLng(position.latitude, position.longitude);
      lang.value = currentPostion.longitude.toString();
      lang.value = currentPostion.latitude.toString();
      print(
          "-----${lang.value}--------------------------${lang.value}---------->");
    } finally {
      print("finally");
    }
  }

  Future<void> scanQR(context) async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      cdeQR.value = barcodeScanRes;
      _getUserLocation();
    } on PlatformException {
      if (!Get.isSnackbarOpen)
        Get.snackbar("Failed on Scan", "please try again",
            backgroundColor: Colors.red, colorText: whiteColor);
    } finally {
      print('------cdeQR------------->${cdeQR.value}');
      _apiCallAdd(context);
    }
  }

  Future<void> _apiCallAdd(context) async {
    // var _url =
    //     "https://shaheen-test2.dalilee.om/api/v1/sales/create-pickup-by-qr";

    var _url = "$base_url/v1/sales/create-pickup-by-qr";
    try {
      final prefs = await SharedPreferences.getInstance();

      dynamic fromString = prefs.getString('loginData') ?? '';

      dynamic resLogin = json.decode(fromString!.toString());
      dynamic tokenLo = resLogin['data']["access_token"] ?? '';

      var response = await http.post(Uri.parse(_url), body: {
        "sticker_key": "${cdeQR.value}",
        "lat": "${lang.value}",
        "lng": "${lang.value}",
      }, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokenLo"
      });

      //final data = json.decode(response.body);

      if (response.statusCode == 200) {
        showDialog(
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBoxAl(
                title: "Done !!",
                des: "location picked successfully",
                icon: Icons.priority_high_outlined,
              );
            });
        Get.put(PickupController()).fetchTodayPickupData();
        Get.put(PickupController()).fetchAllPickupData();
      } else {
        Get.snackbar("Failed", "please check QRCode try again",
            backgroundColor: Colors.red, colorText: whiteColor);
      }
    } catch (e) {
    } finally {}
  }
}
