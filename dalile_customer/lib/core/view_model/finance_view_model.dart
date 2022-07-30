import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/model/close_finance_model.dart';
import 'package:dalile_customer/model/finance_open_model.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FinanceController extends GetxController {
  @override
  void onInit() {
    fetchOpenData();
    fetchCloseData();

    super.onInit();
  }

  void onLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(child: CupertinoActivityIndicator()),
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }

//----------------Api Data----------------------
  var isLoading = false.obs;

  var openData = OpenData().obs;
  var closeData = <Invoice>[].obs;
  void fetchOpenData() async {
    try {
      isLoading(true);
      var open = await FinanceApi.fetchopenData();
      if (open != null) {
        openData(open);
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

  void fetchCloseData() async {
    try {
      isLoading(true);
      var close = await FinanceApi.fetchCloseData();
      if (close != null) {
        closeData.value = close.invoices!;
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
//----------------Api Data----------------------

  launchPDF(id) async {
    Get.dialog(const WaiteImage(), barrierColor: Colors.transparent);
    try {
      var pdf =
          await FinanceApi.fetchPDFCloseData(id).whenComplete(() => Get.back());
      if (pdf != null) {
        print('pdf----$pdf');
        var url = pdf;
        await launch(url);
      }
    } finally {
      print('finally');
    }
  }
}
