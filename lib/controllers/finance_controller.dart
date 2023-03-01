import 'dart:developer';

import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/controllers/download_controller.dart';
import 'package:dalile_customer/model/close_finance_model.dart';
import 'package:dalile_customer/model/finance_open_model.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceController extends GetxController {
  RxBool loadMoreClosed = false.obs;
  RxInt totalCloseInvoices = 0.obs;

  @override
  void onInit() {
    fetchOpenData();
    fetchCloseData(isRefresh: true);

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
  var closeData = <ClosingRequest>[].obs;
  fetchOpenData() async {
    try {
      isLoading(true);
      var open = await FinanceApi.fetchopenData();
      if (open != null) {
        openData(open);
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, FinanceApi.mass);
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

  fetchCloseData({bool isRefresh: false}) async {
    try {
      // isLoading(true);

      var limit = "100";
      var offset = closeData.length.toString();
      if (isRefresh) {
        limit = "100";
        offset = "0";
      }
      final body = {"offset": offset, "limit": limit};
      var close = await FinanceApi.fetchCloseData(body);
      if (close != null) {
        totalCloseInvoices.value = close.totalInvoices!;
        if (isRefresh)
          closeData.value = close.closingRequests ?? [];
        else
          closeData.value += close.closingRequests ?? [];
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, FinanceApi.mass);
        }
      }
    } finally {
      print('finally');
      if (FinanceApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        FinanceApi.checkAuth = false;
      }
      loadMoreClosed(false);
      isLoading(false);
    }
  }
//----------------Api Data----------------------

  launchFile(id, {required String type}) async {
    Get.dialog(const WaiteImage(), barrierColor: Colors.transparent);
    try {
      var pdf = await FinanceApi.fetchPDFCloseData(id, type: type)
          .whenComplete(() => Get.back());
      inspect(pdf);
      // Get.snackbar(pdf.toString(), " ", colorText: Colors.orange);

      if (pdf != null) {
        // print('pdf----$pdf');
        Get.snackbar(pdf, " ", colorText: Colors.orange);
        var url = pdf;
        Get.put(DownloadController()).startDownloadingExcellOrPdf(url, "pdf");
        // await launchUrl(Uri.parse(url));
        // await launch(url);
      }
    } catch (e) {
      Get.snackbar(e.toString(), " ", colorText: Colors.orange);
    } finally {
      print('finally');
    }
  }

  launchCSV(id, {bool isAllOrders = false}) async {
    Get.dialog(const WaiteImage(), barrierColor: Colors.transparent);
    try {
      var csv = await FinanceApi.fetchCSVCloseData(id, isAllOrders: isAllOrders)
          .whenComplete(() => Get.back());

      if (csv != null) {
        // print('pdf----$pdf');
        Get.snackbar(csv, " ", colorText: Colors.orange);
        var url = csv;
        Get.put(DownloadController())
            .startDownloadingExcellOrPdf(url, isAllOrders ? "pdf" : "csv");
        // await launchUrl(Uri.parse(url));
        // await launch(url);
      }
    } catch (e) {
      Get.snackbar(e.toString(), " ", colorText: Colors.orange);
    } finally {
      print('finally');
    }
  }
}
