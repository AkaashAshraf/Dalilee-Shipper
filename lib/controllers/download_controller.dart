import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/http/FromDalilee.dart';
import 'package:dalile_customer/core/http/http.dart';
import 'package:dalile_customer/model/export_model.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:dalile_customer/components/popups/downloadProgressBarNew.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadController extends GetxController {
  Rx<bool> isDownloading = false.obs;
  Rx<bool> loading = false.obs;
  RxInt currentDownloadingRefId = 0.obs;
  Rx<bool> isEmail = false.obs;

  Rx<OrderTypes> selectedOrderType = OrderTypes('', '').obs;

  Rx<String> startDate = "".obs;
  Rx<String> endDate = "".obs;
  Rx<String> comments = "".obs;

  List<OrderTypes> orderTypes = [
    OrderTypes('shipments', "All Orders"),
    OrderTypes('delivered_shipments', "Delivered Orders"),
    // OrderTypes(
    // 'delivered_shipments', "Un-Delivered Orders"), //pending from server
    OrderTypes('cancel_shipments', "Cancelled Orders"),
    // OrderTypes('ofd_shipments', "OFD Orders"), //pending from server
    OrderTypes('returned_shipments', "Returened Orders"),
    OrderTypes('to_be_delivered', "To Be Delivered Orders"),

    // OrderTypes('cod_pending', "COD Pending Orders"), //pending from server
    // OrderTypes('ready_to_pay', "Ready to Pay Orders"), //pending from server
  ];

  downloadReferenceOrders(int ref) async {
    try {
      currentDownloadingRefId(ref);
      loading(true);
      var res = await postAccountManager(
          accountManagerBaseUrl + "/collection-orders",
          {"collection_id": ref.toString()});
      if (res != null) {
        var body = exportResponseFromJson(res.body);

        startDownloadingExcellOrPdf(body.data!.url.toString(), "csv");
        print(res.toString());
      }
    } catch (e) {
    } finally {
      currentDownloadingRefId(0);

      loading(false);
    }
  }

  download(BuildContext context) {
    DownloadingDialog(context).show();
  }

  startDownloadingImage(String url, {bool isGoBack: true}) async {
    try {
      if (isGoBack) Get.back();

      if (url == "") {
        Get.snackbar('Failed', "No Image Available",
            backgroundColor: Colors.red.withOpacity(0.7));

        return;
      }
      // Get.snackbar('Downloading Image', "Image is downloading",
      //     backgroundColor: primaryColor.withOpacity(0.9));
      isDownloading(true);
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return;
      }
      // var path = await ImageDownloader.findPath(imageId);
      // OpenFile.open(path);

      Get.snackbar('Download Done', "Image is downloaded",
          backgroundColor: primaryColor.withOpacity(0.7));
    } catch (e) {
      // Get.back();

      Get.snackbar('Failed', "No Image Available",
          backgroundColor: Colors.red.withOpacity(0.7));
    } finally {
      isDownloading(false);
      // Get.back();
    }
  } //startDownloadingImage

  addComment({String problemId = "", required BuildContext context}) async {
    loading(true);

    try {
      final response = await dalileePost("/update_shipper_comments",
          {"problem_id": problemId, "trader_comments": comments.value});
      // print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
            'Success'.tr, "Problem comments has been updated successfully".tr);
        Navigator.pop(context);
        // print(response.body["data"]["message"]);
      } else
        Get.snackbar(
            'Failed'.tr, "Something went wront. Please try again later".tr);
    } catch (e) {
      Get.snackbar(
          'Failed'.tr, "Something went wront. Please try again later".tr);

      // print(e.toString());
    } finally {
      loading(false);
    }
  }

  String hotfixYear(String _) =>
      _.substring(0, _.length - 2) +
      "20" +
      (_.substring(_.length - 2, _.length));

  startDownloadingList(String type) async {
    try {
      if (startDate.value == "")
        startDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (endDate.value == "") endDate.value = startDate.value;
      isDownloading(true);
      var isSendToEmail = Platform.isIOS
          ? 1
          : isEmail.value
              ? 1
              : 0;
      // print(
      //     "/dashboard/export?email=$isSendToEmail&type=$type&module=${selectedOrderType.value.key}&from_date=${startDate.value}&to_date=${endDate.value}&pdf_type=listing");
      var res = await get(
          '/dashboard/export?email=$isSendToEmail&type=$type&module=${selectedOrderType.value.key}&from_date=${startDate.value}&to_date=${endDate.value}&pdf_type=listing');
      if (res != null) {
        var body = exportResponseFromJson(res.body);

        startDownloadingExcellOrPdf(body.data!.url.toString(), type);
        print(res.toString());
      } else
        print(res);
    } catch (e) {
      print(e);
    } finally {
      isDownloading(false);
    }
  } //startDownloadingList

  startDownloadingListWithoutDateRange(String type, String module) async {
    try {
      if (startDate.value == "")
        startDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (endDate.value == "") endDate.value = startDate.value;
      isDownloading(true);

      // print(
      //     "/dashboard/export?type=$type&email=0&module=$module&pdf_type=listing");
      var res = await get(
          '/dashboard/export?type=$type&email=0&module=$module&pdf_type=listing');
      if (res != null) {
        var body = exportResponseFromJson(res.body);

        startDownloadingExcellOrPdf(body.data!.url.toString(), type,
            isGoBack: false);
        // print(res.toString());
      } else
        print(res);
    } catch (e) {
      print(e);
    } finally {
      isDownloading(false);
    }
  } //startDownloadingList

  startDownloadingSingle(String billId, {bool isGoBack: false}) async {
    try {
      if (isGoBack) Get.back();
      isDownloading(true);
      var isSendToEmail = Platform.isIOS ? 1 : 0;
      var res = await get(
          '/dashboard/order-pdf?order_id=$billId&email=$isSendToEmail');
      if (res != null) {
        var body = exportResponseFromJson(res.body);
        print('/dashboard/order-pdf?order_id=$billId&email=$isSendToEmail');

        startDownloadingExcellOrPdf(body.data!.url.toString(), 'pdf');
      } else
        print(res);
    } catch (e) {
      print(e);
    } finally {
      isDownloading(false);
    }
  } //startDownloadingList

  startDownloadingExcellOrPdf(String url, String extension,
      {bool isGoBack = true}) async {
    try {
      // Get.snackbar(
      //     'Successfully Exported', "File has been sent to your email address.",
      //     backgroundColor: primaryColor.withOpacity(0.7));
      // isDownloading(true);
      if (Platform.isIOS) {
        final Uri _url = Uri.parse(url);

        launchUrl(_url);
        return;
      } else {
        if (url == "") return;

        if (Platform.isAndroid) {
          Get.snackbar('Downloading...', "Your file start downloading",
              backgroundColor: primaryColor.withOpacity(0.7));
        }

        if (Platform.isIOS == true) {
          Get.snackbar('File Sent...',
              "Your file has been sent to your registered email",
              backgroundColor: primaryColor.withOpacity(0.7));
        }
        isDownloading(true);
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        String fileName = "$timestamp.$extension";
        String path = await _getFilePath(fileName);
        var dio = Dio();
        await dio
            .download(
          url,
          path,
          options: Options(),
        )
            .then((_) {
          OpenFile.open(path);
        });
      }
      if (isGoBack) Get.back();
    } catch (e) {
      // print(e);
    } finally {
      if (!Platform.isIOS) Get.back();

      isDownloading(false);
    }
  }

  Future<String> _getFilePath(String filename) async {
    // final dir = await getApplicationDocumentsDirectory();
    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);

    return "$path/$filename";
  }
}

class OrderTypes {
  final String key;
  final String label;

  OrderTypes(this.key, this.label);
}
