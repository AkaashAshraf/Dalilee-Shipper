import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/model/add_inqury_list_caterogry_model.dart';
import 'package:dalile_customer/model/enquiry_model.dart';
import 'package:dalile_customer/model/sub_cat_list_model.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryFinanceController extends GetxController {
  @override
  void onInit() {
    fetchCatListData();
    fetchEnquiryFinanceData();

    super.onInit();
  }

  var isLoading = false.obs;

  var enquriyData = <EnquiryList>[].obs;
  void fetchEnquiryFinanceData() async {
    try {
      isLoading(true);
      var enquriy = await FinanceApi.fetchEnquiryFinanceData();
      if (enquriy != null) {
        enquriyData.value = enquriy;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', FinanceApi.mass);
        }
      }
    } finally {
      print('finally');
      if (FinanceApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        FinanceApi.checkAuth = false;
      }
      isLoading(false);
    }
  }

  TextEditingController catListName = TextEditingController();
  TextEditingController catListId = TextEditingController();
  List<CatList> catListData = [];
  void fetchCatListData() async {
    try {
      var enquriy = await FinanceApi.fetchCatList();
      if (enquriy != null) {
        catListData = enquriy;
        update();
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', FinanceApi.mass);
        }
      }
    } finally {
      print('finally');
    }
  }

  TextEditingController subcatListName = TextEditingController();
  TextEditingController subcatListId = TextEditingController();
  List<SubCatList> subcatListData = [];
  void fetchSubCatListData() async {
    subcatListId.clear();
    subcatListName.clear();
    subcatListData.clear();
    Get.dialog(
      const Center(
          child: CupertinoActivityIndicator(
        color: primaryColor,
      )),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
    try {
      var enquriy = await FinanceApi.fetchSubCatList(catListId.text);
      if (enquriy != null) {
        subcatListData = enquriy;
      }
    } finally {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      update();
      print('finally');
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String decConteroller = '';

  checkval(context) {
    if (formKey.currentState!.validate()) {
      fetchAddEnquiryFinanceData(context);
    }
  }

  bool isAddwiting = false;

  void fetchAddEnquiryFinanceData(context) async {
    isAddwiting = true;
    update();
    try {
      dynamic enquriyAdd = await FinanceApi.fetchAddEnquiryData(
              catListId.text, subcatListId.text, decConteroller)
          .whenComplete(() {
        isAddwiting = false;
        Get.back();
        update();
      });

      if (enquriyAdd != null) {
        if (enquriyAdd == "success") {
          showDialog(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBoxAl(
                  title: "Done !!",
                  des: "add enquiry successfully",
                  icon: Icons.priority_high_outlined,
                );
              });
        } else {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Filed', "please check your data",
                colorText: whiteColor);
          }
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed', FinanceApi.mass);
        }
      }
    } finally {
      fetchEnquiryFinanceData();
      print('finally');
    }
  }
}
