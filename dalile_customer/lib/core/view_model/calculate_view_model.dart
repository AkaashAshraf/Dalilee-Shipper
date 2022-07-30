import 'package:dalile_customer/core/server/pickup_api.dart';
import 'package:dalile_customer/model/muhafaza_model.dart';
import 'package:dalile_customer/model/region_model.dart';
import 'package:dalile_customer/model/wilayas_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculateController extends GetxController {
  //--------------validate----------------
  //--------------validate----------------
  //--------------validate----------------
  //--------------validate----------------

  muhafazaVal1(value) {
    cWFrom.clear();

    for (int i = 0; i < muhafazaList.length; i++) {
      if (muhafazaList[i]!.name == value) {
      
        muhafazaNameFrom.text = value!;

        fetchWilayaDataFrom(muhafazaList[i]!.id);
        break;
      }
    }
  }

  muhafazaVal2(value) async {
   

    cWTo.clear();

    for (int i = 0; i < muhafazaList.length; i++) {
      if (muhafazaList[i]!.name == value) {
       
        muhafazaNameTo.text = value!;
        fetchWilayaDataTo(muhafazaList[i]!.id);
        break;
      }
    }
  }

  waliaVal1(val) {
    cRFrom.clear();
    regionListFrom.clear();

    for (int i = 0; i < wilayaListFrom.length; i++) {
      if (wilayaListFrom[i]!.name == val) {
       
        cWFrom.text = val!;
        fetchRegionDataFrom(wilayaListFrom[i]!.id);

        break;
      }
    }
  }

  waliaVal2(val) {
    cRTO.clear();
    regionListTo.clear();

    for (int i = 0; i < wilayaListTo.length; i++) {
      if (wilayaListTo[i]!.name == val) {
      
        cWTo.text = val!;
        fetchRegionDataTo(wilayaListTo[i]!.id);
        break;
      }
    }
  }

  regionVal1(val) {
    for (int i = 0; i < regionListFrom.length; i++) {
      if (regionListFrom[i]!.name == val) {
      
        cRFrom.text = val!;
        break;
      }
    }
  }

  regionVal2(val) {
    for (int i = 0; i < regionListTo.length; i++) {
      if (regionListTo[i]!.name == val) {
     
        cRTO.text = val!;
        regionID = regionListTo[i]!.id;
        break;
      }
    }
  }

  GlobalKey<FormState> keyFromF = GlobalKey<FormState>();

  onSave() {
    if (keyFromF.currentState!.validate()) {
      keyFromF.currentState!.save();
      fetchPriceData();
      //_controller.whenComplated();
    }
  }
  //--------------validate----------------
  //--------------validate----------------
  //--------------validate----------------
  //--------------validate----------------

  @override
  void onInit() {
    fetchMuhafazaData();

    super.onInit();
  }

  ///----------------APIS--------------
  ///----------------APIS--------------
  ///----------------APIS--------------
  var isLoading = false.obs;
  var muhafazaList = <Governate?>[].obs;

  var wilayaListFrom = <WilayaOM?>[].obs;
  var wilayaListTo = <WilayaOM?>[].obs;
  var regionListFrom = <AreaRegion?>[].obs;
  var regionListTo = <AreaRegion?>[].obs;
  int? muhafazaID, wilayaID, regionID;
  TextEditingController muhafazaNameFrom = TextEditingController();
  TextEditingController muhafazaNameTo = TextEditingController();
  TextEditingController cWFrom = TextEditingController();
  TextEditingController cRFrom = TextEditingController();
  TextEditingController cNameTo = TextEditingController();
  TextEditingController cWTo = TextEditingController();
  TextEditingController cRTO = TextEditingController();
  TextEditingController wighetController = TextEditingController();

  void fetchMuhafazaData() async {
    try {
      isLoading(true);

      var muhafaza = await PickupApi.fetchMuhafazaData();
      if (muhafaza != null) {
        muhafazaList.value = muhafaza.data!.governates!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', PickupApi.mass);
        }
      }
    } finally {
   

      isLoading(false);
    }
  }

  void fetchWilayaDataFrom(muhafazaId) async {
    try {
      Get.dialog(
        const Center(child: CupertinoActivityIndicator()),
        barrierColor: Colors.transparent,
      );
      var waliaya = await PickupApi.fetchWilayaData(muhafazaId)
          .whenComplete(() => Get.back());
      if (waliaya != null) {
        wilayaListFrom.value = waliaya.data.wilayaOMs!;
      } else {
        if (!Get.isSnackbarOpen) {
           Get.snackbar('Error', PickupApi.mass);
        }
       
      }
    } finally {}
  }

  void fetchWilayaDataTo(muhafazaId) async {
    try {
      Get.dialog(
        const Center(child: CupertinoActivityIndicator()),
        barrierColor: Colors.transparent,
      );
      var waliaya = await PickupApi.fetchWilayaData(muhafazaId)
          .whenComplete(() => Get.back());
      if (waliaya != null) {
        wilayaListTo.value = waliaya.data.wilayaOMs!;
      } else {
        if (!Get.isSnackbarOpen) {
           Get.snackbar('Error', PickupApi.mass);
        }
      }
    } finally {}
  }

  void fetchRegionDataFrom(wId) async {
    Get.dialog(
      const Center(child: CupertinoActivityIndicator()),
      barrierColor: Colors.transparent,
    );
    try {
      var region =
          await PickupApi.fetchRegionData(wId).whenComplete(() => Get.back());
      if (region != null) {
        regionListFrom.value = region.data!.areaRegions!;
      } else {
      if (!Get.isSnackbarOpen) {
           Get.snackbar('Error', PickupApi.mass);
        }
      }
    } finally {}
  }

  void fetchRegionDataTo(wId) async {
    Get.dialog(
      const Center(child: CupertinoActivityIndicator()),
      barrierColor: Colors.transparent,
    );
    try {
      var region =
          await PickupApi.fetchRegionData(wId).whenComplete(() => Get.back());
      if (region != null) {
        regionListTo.value = region.data!.areaRegions!;
      } else {
      if (!Get.isSnackbarOpen) {
           Get.snackbar('Error', PickupApi.mass);
        }
      }
    } finally {}
  }

  RxString calPrice = '0.00'.obs;
  RxBool isLoadingPrice = false.obs;
  RxBool isCompleted = false.obs;

  void fetchPriceData() async {
  

    try {
      isLoadingPrice(true);
      var price =
          await PickupApi.fetchPriceValueData(regionID, wighetController.text);
      if (price != null) {
        calPrice.value = price["data"]["priceValue"].toString();

     
      } else {
        if (PickupApi.mass.isEmpty) {
          if (!Get.isSnackbarOpen) {
         Get.snackbar('Error', "please check your input");
        }
          
        } else {
            if (!Get.isSnackbarOpen) {
           Get.snackbar('Error', PickupApi.mass);
        }
       
        }
      }
    } finally {
      isLoadingPrice(false);
      isCompleted(true);
    }
  }

  ///----------------APIS--------------
  ///----------------APIS--------------
  ///----------------APIS--------------

  RxInt currentStep = 0.obs;
  onStepTapped(x) {
    currentStep.value = x;
  }

  inc() {
    currentStep.value += 1;
  }

  decr() {
    currentStep -= 1;
  }

  first() {
    currentStep.value = 0;
   
    isCompleted(false);
    //_model.update();
  }

  second() {
    currentStep.value = 1;
    isCompleted(false);
    //_model.update();
  }

  thired() {
    currentStep.value = 2;
    isCompleted(false);
    //_model.update();
  }
}
