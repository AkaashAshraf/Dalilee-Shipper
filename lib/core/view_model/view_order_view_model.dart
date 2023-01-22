import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/core/view_model/name_icons.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/shipments/complain_body_shipement.dart';
import 'package:dalile_customer/view/shipments/edit_shipement_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewOrderController extends GetxController {
  @override
  void onInit() {
    fetchViewOrderData();
    super.onInit();
  }

  var isLoading = true.obs;
  RxBool loadMore = false.obs;

  RxList<Shipment> viewOrderData = <Shipment>[].obs;
  RxList<Shipment> closedOrderData = <Shipment>[].obs;
  RxInt totalOrders = 0.obs;
  RxInt totalClosedOrders = 0.obs;

  fetchViewOrderData({isRefresh: false}) async {
    try {
      var limit = "100";
      var offset = viewOrderData.length.toString();

      if (isRefresh) {
        limit = "100";
        offset = "0";
        loadMore.value = false;
      } else {
        loadMore.value = true;
      }
      var body = {"offset": offset, "limit": limit, "module": "open_finance"};
      var viewOrder = await FinanceApi.fetchViewOrdersData(body,
          url: "/dashboard/shipments");
      if (viewOrder != null) {
        totalOrders.value = viewOrder.totalShipments!;
        if (isRefresh)
          viewOrderData.value = viewOrder.shipments;
        else
          viewOrderData.value += viewOrder.shipments;
      } else {
        if (FinanceApi.mass.isEmpty) {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Failed', "please try agian later");
          }
        }
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', FinanceApi.mass);
        }
      }
    } finally {
      isLoading(false);
      loadMore(false);
    }
  }

  fetchClosedInvoiceData({isRefresh: false, required String invoiceID}) async {
    try {
      var limit = "100";
      var offset = closedOrderData.length.toString();

      if (isRefresh) {
        isLoading(true);
        limit = "100";
        offset = "0";
        loadMore.value = false;
      } else {
        loadMore.value = true;
      }
      var body = {
        "offset": offset,
        "limit": limit,
        "module": "invoice_shipments",
        "invoice_id": invoiceID
      };
      var viewOrder = await FinanceApi.fetchViewOrdersData(body,
          url: "/dashboard/shipments");
      if (viewOrder != null) {
        totalClosedOrders.value = viewOrder.totalShipments!;
        if (isRefresh)
          closedOrderData.value = viewOrder.shipments;
        else
          closedOrderData.value += viewOrder.shipments;
      } else {
        if (FinanceApi.mass.isEmpty) {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Failed'.tr, "please try agian later");
          }
        }
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed'.tr, FinanceApi.mass);
        }
      }
    } finally {
      isLoading(false);
      loadMore(false);
    }
  }

  List<NameWithIcon> callList = [
    NameWithIcon(icon: Icons.call, name: 'Call'),
    NameWithIcon(icon: Icons.mail_outlined, name: 'Send Message'),
    NameWithIcon(icon: Icons.mail_outlined, name: 'WhatsApp Message'),
    NameWithIcon(icon: Icons.content_copy_outlined, name: 'Copy Number'),
    NameWithIcon(icon: Icons.person_add_outlined, name: 'Create New Contact'),
  ];
  List<NameWithIcon> menuList = [
    NameWithIcon(icon: Icons.info_outlined, name: 'Complain'),
    NameWithIcon(icon: Icons.mode_edit_outlined, name: 'Edit'),
  ];

  callAlert(context, number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: callList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(
                      callList[index].name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: Icon(
                      callList[index].icon,
                      color: Colors.black,
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          makePhoneCall("123");
                          break;

                        case 1:
                          _textMe();
                          break;

                        case 2:
                          launchWhatsapp("123");
                          break;
                        case 3:
                          Clipboard.setData(ClipboardData(text: "$number"))
                              .then((value) {
                            Get.snackbar('Copy phone number',
                                "phone number copy successful",
                                colorText: whiteColor);
                          });
                          break;
                        case 4:
                          launchWhatsapp("123");
                          break;
                      }
                      Get.back();
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  menuAlert(context, number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(
                      menuList[index].name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: Icon(
                      menuList[index].icon,
                      color: Colors.black,
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.back();
                          showComplain(context);
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  Future<void> _textMe() async {
    if (Platform.isAndroid) {
      const uri = 'sms:123?body=hello';
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      const uri = 'sms:123&body=hello%20there';
      await launch(uri);
    }
  }

  Future<void> launchWhatsapp(number) async {
    final url = "https://wa.me/$number?text= Hi";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  showComplain(context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        scrollable: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(builder: (context) {
          return const ShowComplainShipement();
        }),
      ),
    );
  }

  showEdit(context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        scrollable: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(builder: (context) {
          return const ShowEditShipment(title: 'Edit');
        }),
      ),
    );
  }
}
