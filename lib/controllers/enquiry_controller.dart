import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/model/add_inqury_list_caterogry_model.dart';
import 'package:dalile_customer/model/crm/account_enquiries.dart';
import 'package:dalile_customer/model/crm/general_response.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryFinanceController extends GetxController {
  var selectedAccountID = 0.obs;
  var selectedAccountName = "".obs;
  var estimatedAmount = "".obs;
  var description = "".obs;
  @override
  void onInit() {
    fetchCatListData();
    fetchEnquiryFinanceData();

    super.onInit();
  }

  var isLoading = false.obs;

  var enquriyData = <Enquiry>[].obs;
  fetchEnquiryFinanceData() async {
    try {
      isLoading(true);
      var enquriy = await FinanceApi.fetchEnquiryFinanceData();
      if (enquriy != null) {
        enquriyData.value = enquriy;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, FinanceApi.mass);
        }
      }
    } finally {
      isLoading(false);

      if (FinanceApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        FinanceApi.checkAuth = false;
      }
    }
  }

  List<CatList> catListData = [];
  void fetchCatListData() async {
    try {
      var enquriy = await FinanceApi.fetchCatList();
      if (enquriy != null) {
        catListData = enquriy;
        update();
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, FinanceApi.mass);
        }
      }
    } finally {}
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String decConteroller = '';

  checkval(context) {
    if (formKey.currentState!.validate()) {
      fetchAddEnquiryFinanceData(context);
    }
  }

  RxBool isAddwiting = false.obs;

  void fetchAddEnquiryFinanceData(context) async {
    isAddwiting.value = true;
    update();
    try {
      //  dynamic enquriyAdd = await FinanceApi.fetchAddEnquiryData(
      //         catListId.text, subcatListId.text, decConteroller)
      Crmgenralresponse enquriyAdd = await FinanceApi.fetchAddEnquiryData(
              context: context,
              accountId: selectedAccountID.value.toString(),
              description: description.value,
              amount: estimatedAmount.value)
          .whenComplete(() {
        isAddwiting.value = false;
        Get.back();
        update();
      });

      {
        if (enquriyAdd.status == 1) {
          showDialog(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBoxAl(
                  title: "done".tr,
                  des: "enq_addedd".tr,
                  icon: Icons.priority_high_outlined,
                );
              });
        } else {
          showDialog(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBoxAl(
                  title: "Failed".tr,
                  error: true,
                  des: Get.locale.toString() == "en"
                      ? enquriyAdd.messageEn ?? ""
                      : enquriyAdd.messageAr ?? "",
                  icon: Icons.cancel,
                );
              });
        }
      }
      //else {
      //     if (!Get.isSnackbarOpen) {
      //       Get.snackbar('Failed'.tr, "check_data".tr, colorText: whiteColor);
      //     }
      //   }
      // } else {
      //   if (!Get.isSnackbarOpen) {
      //     Get.snackbar('Failed'.tr, FinanceApi.mass);
      //   }
      // }
    } finally {
      fetchEnquiryFinanceData();
    }
  }
}
