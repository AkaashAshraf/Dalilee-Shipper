import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class What3WordController extends GetxController {
  var twaController = TextEditingController();
  bool isWaiting = false;
  String long = '';
  String lat = '';
  final formKeyG = GlobalKey<FormState>();

  chickWhat3Word(context) async {
    isWaiting = true;
    update();
    // var _url =
    //     "http://shaheen-test2.dalilee.om/api/w3w/convert-to-coordinates/?words=${twaController.text}";

    var _url =
        "$base_url/w3w/convert-to-coordinates/?words=${twaController.text}";
    try {
      var response = await http.get(
        Uri.parse(_url),
      );

      final data = json.decode(response.body);

      if (data["status"] == "success") {
        lat = "${data["coordinates"]['lng']}";
        long = "${data["coordinates"]['lat']}";

        if (Get.isDialogOpen == true) {
          Get.back();
        }
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
        if (!Get.isSnackbarOpen)
          Get.snackbar("Failed ",
              "please check 3 word, it should be like limit.broom.flip",
              backgroundColor: Colors.red, colorText: whiteColor);
      }
    } catch (e) {
    } finally {
      isWaiting = false;
      update();
    }
  }
}
