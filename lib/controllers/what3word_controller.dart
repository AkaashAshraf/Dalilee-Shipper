import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/model/W3Words.dart';
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
  RxString currentWords = ''.obs;
  RxString readyToSubmitWords = ''.obs;

  RxList suggestions = [].obs;
  RxList<Suggestion> list = [Suggestion()].obs;

  final formKeyG = GlobalKey<FormState>();

  @override
  void onInit() {
    getMyWords(words: "..");

    super.onInit();
  }

  chickWhat3Word(context, {required String words}) async {
    isWaiting = true;
    update();
    // var _url =
    //     "http://shaheen-test2.dalilee.om/api/w3w/convert-to-coordinates/?words=${twaController.text}";

    var _url = "$base_url/w3w/convert-to-coordinates/?words=$words";
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

  getMyWords({required String words}) async {
    try {
      final response =
          await getWithUrl("$base_url/w3w/auto-suggest/?words=$words");
      if (response != null) {
        final jsonData = w3WordsModelFromJson(response.body);

        final words = List<String>.from(
            jsonData.suggestions!.map((e) => (e.words.toString())));
        suggestions.value = words;
        list.value = jsonData.suggestions ?? [];
      }
    } catch (e) {
    } finally {
      isWaiting = false;
      update();
    }
  }
}
