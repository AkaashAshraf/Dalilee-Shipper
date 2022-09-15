import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/core/server/shipments.dart';
import 'package:dalile_customer/core/view_model/complain_view_model.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/core/view_model/name_icons.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ShipmentViewModel extends GetxController {
  bool isOpen = false;
  RxBool inLoadMore = false.obs;
  RxBool outLoadMore = false.obs;

  RxInt total_in = 0.obs;
  RxInt total_out = 0.obs;

  isOpenFuncjation(i) {
    update();
  }

  final controller = ScrollController();
  bool isSDown = false;
  @override
  void dispose() {
    super.dispose();
  }

  List<NameWithIcon> callList = [
    NameWithIcon(icon: Icons.call, name: 'Call'),
    NameWithIcon(icon: Icons.mail_outlined, name: 'Send Message'),
    NameWithIcon(icon: Icons.whatsapp_outlined, name: 'WhatsApp Message'),
    NameWithIcon(icon: Icons.content_copy_outlined, name: 'Copy Number'),
  ];
  List<NameWithIcon> menuList = [
    NameWithIcon(icon: Icons.info_outlined, name: 'Generate Ticket'),
    NameWithIcon(icon: Icons.picture_as_pdf_outlined, name: 'Download Bill'),
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
                          makePhoneCall("$number");
                          break;

                        case 1:
                          _textMe("$number");
                          break;

                        case 2:
                          launchWhatsapp(number);
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

  launchPDF(id) async {
    Get.dialog(const WaiteImage(), barrierColor: Colors.transparent);
    try {
      var pdf =
          await FinanceApi.fetchPDFCloseData(id).whenComplete(() => Get.back());
      if (pdf != null) {
        var url = pdf;
        await launch(url);
      } else {
        Get.snackbar('Filed', "This Id can't be launch $id",
            colorText: whiteColor);
      }
    } finally {}
  }

  menuAlert(context, number, orderN, dImage, undImage, pickupImage) async {
    final ReceivePort _port = ReceivePort();

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
    });

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
                  return Stack(
                    children: [
                      ListTile(
                        leading: Text(
                          menuList[index].name,
                          style: const TextStyle(color: Colors.black),
                        ),
                        trailing: Icon(
                          menuList[index].icon,
                          color: Colors.black,
                        ),
                        onTap: () async {
                          DownloadController controller =
                              Get.put(DownloadController());
                          await Permission.storage.request();

                          switch (index) {
                            case 0:
                              Get.back();
                              showD(context, orderN);
                              break;
                            case 1:
                              try {
                                controller.startDownloadingSingle(
                                    orderN.toString(),
                                    isGoBack: true);
                              } catch (r) {}
                              break;
                            case 2:
                              try {
                                controller.startDownloadingImage(pickupImage);
                              } catch (r) {}
                              break;
                            case 3:
                              try {
                                controller.startDownloadingImage(dImage);
                              } catch (r) {}
                              break;
                            case 4:
                              try {
                                controller.startDownloadingImage(undImage);
                              } catch (r) {}
                              break;
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        });
  }

  Future<void> _textMe(String number) async {
    if (Platform.isAndroid) {
      var uri = 'sms:$number?body=hello';
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      var uri = 'sms:$number&body=hello%20there';
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
    Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

//----------API-------------------

  @override
  void onInit() {
    fetchOutShipemetData();
    fetchInShipemetData(isRefresh: true);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  var isLoadingOut = true.obs;
  var isLoadingIN = true.obs;
  var outList = <Shipment?>[].obs;
  var inList = <Shipment?>[].obs;

  fetchInShipemetData({isRefresh: false}) async {
    try {
      var limit = "100";
      var offset = inList.length.toString();

      if (isRefresh) {
        limit = "100";
        offset = "0";
      } else
        inLoadMore(true);
      // if (inList.length == 0) isLoadingOut(true);

      var body = {"offset": offset, "limit": limit, "tab": "in"};
      var inData = await ShipmentApi.fetchShipemetData(body);
      if (inData != null) {
        total_in.value = inData.totalShipments!;
        if (isRefresh)
          inList.value = inData.shipments!.toList();
        else
          inList.value += inData.shipments!.toList();
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Failed', ShipmentApi.mass);
        }
      }
    } finally {
      if (ShipmentApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        ShipmentApi.checkAuth = false;
      }
      isLoadingIN(false);
      inLoadMore(false);
    }
  }

  fetchOutShipemetData({isRefresh: false}) async {
    try {
      var limit = "100";
      var offset = outList.length.toString();

      if (isRefresh) {
        limit = "100";
        offset = "0";
      } else
        outLoadMore(true);
      // if (outList.length == 0) isLoadingOut(true);
      var body = {"offset": offset, "limit": limit, "tab": "out"};
      var outData = await ShipmentApi.fetchShipemetData(body);
      if (outData != null) {
        if (isRefresh)
          outList.value = outData.shipments!.toList();
        else
          outList.value += outData.shipments!.toList();

        total_out.value = outData.totalShipments!;
      }
    } finally {
      if (ShipmentApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        ShipmentApi.checkAuth = false;
      }
      isLoadingOut(false);
      outLoadMore.value = false;
    }
  }

//----------API-------------------

  TextEditingController searchConter = TextEditingController();

  var searchResult = <Shipment?>[].obs;
  onSearchTextChanged(text) async {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    for (var out in inList) {
      out!.isOpen = false;
      if (out.orderId!.toString().toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(out);
      }
    }
  }

  onSearchTextChanged2(text) async {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    for (var out in outList) {
      out!.isOpen = false;
      if (out.orderId!.toString().toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(out);
      }
    }
  }

  showD(context, orderN) {
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
          return ShowCreateComplain2(
            orderN: orderN,
          );
        }),
      ),
    );
  }
}

class ShowCreateComplain2 extends StatelessWidget {
  const ShowCreateComplain2({Key? key, this.orderN}) : super(key: key);
  final dynamic orderN;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplainController>(builder: (_model) {
      return Form(
        key: _model.formKay,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Request Ticket',
                  alignment: Alignment.topLeft,
                  color: primaryColor,
                  size: 15,
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.clear_outlined,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormFiledWithTitle(
              read: true,
              text: 'Order No',
              hintText: '$orderN',
              onChanged: (v) {
                _model.orderID.text = orderN.toString();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormFiled(
              select:
                  _model.typeName.text.isNotEmpty ? _model.typeName.text : null,
              hint: 'Ticket Type',
              // select: controller.bankName.text,
              text: 'Select Ticket Type',
              onSaved: (val) {
                _model.orderID.text = orderN.toString();
                for (int i = 0; i < _model.typeData.length; i++) {
                  if (_model.typeData[i].name == val) {
                    _model.typeID.text = _model.typeData[i].id.toString();
                    _model.typeName.text = _model.typeData[i].name.toString();
                  }
                }
                return null;
              },
              validator: (val) => val == null
                  ? 'select Ticket type'
                  : val.length > 100
                      ? "max number 100"
                      : null,
              items: List.generate(_model.typeData.length,
                  (index) => _model.typeData[index].name),
            ),
            CustomFormFiledAreaWithTitle(
              text: 'Explain your Ticket',
              hintText: 'Please explain your Ticket here',
              onChanged: (value) {
                _model.desc = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            _model.isLoadingCreate == true
                ? WaiteImage()
                : CustomButtom(
                    text: 'Create ',
                    onPressed: () {
                      _model.formVal(context);
                    },
                  ),
          ],
        ),
      );
    });
  }
}
