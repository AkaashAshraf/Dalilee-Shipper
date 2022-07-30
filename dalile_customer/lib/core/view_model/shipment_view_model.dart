import 'dart:async';
import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/finance_api.dart';
import 'package:dalile_customer/core/server/shipments.dart';
import 'package:dalile_customer/core/view_model/complain_view_model.dart';
import 'package:dalile_customer/core/view_model/name_icons.dart';
import 'package:dalile_customer/model/out_in_shipments.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShipmentViewModel extends GetxController {
  bool isOpen = false;

  isOpenFuncjation(i) {
    update();
  }

  final controller = ScrollController();
  bool isSDown = false;

  void listenScrolling() {
    if (controller.position.maxScrollExtent / 2 > controller.position.pixels) {
      isSDown = false;
      update();
    } else {
      isSDown = true;
      update();
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
    NameWithIcon(icon: Icons.info_outlined, name: 'Ticket'),
   
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
    } finally {
    
    }
  }

  menuAlert(context, number, orderN) {
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
                   //   Get.put(ComplainController()).fetchTypeComplainData();
                      Get.put(ComplainController()).typeID.clear();
                      Get.put(ComplainController()).typeName.clear();
                      Get.put(ComplainController()).orderID.clear();
                      switch (index) {
                        case 0:
                          Get.back();
                          showD(context, orderN);
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
    fetchShipemetData();
    controller.addListener(listenScrolling);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  var isLoadingOut = true.obs;
  var isLoadingIN = true.obs;
  var outList = <Request?>[].obs;
  var inList = <Request?>[].obs;
  List<TrackingStatus> shipList = [];
  List<TrackingStatus> outshipList = [];

  void fetchShipemetData() async {
    try {
      isLoadingIN(true);

      var outInData = await ShipmentApi.fetchShipemetData("receive");
      if (outInData != null) {
        inList.value = outInData.requests!.reversed.toList();
        shipList = outInData.trackingStatuses!;
      } else {
         if (!Get.isSnackbarOpen) {
           Get.snackbar('Filed', ShipmentApi.mass);
         }
       
      }
    } finally {
      if (ShipmentApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        ShipmentApi.checkAuth = false;
      }
      isLoadingIN(false);
    }
  }

  void fetchOutShipemetData() async {
    try {
      isLoadingOut(true);

      var outData = await ShipmentApi.fetchShipemetData("sent");
      if (outData != null) {
        outList.value = outData.requests!.reversed.toList();
        outshipList = outData.trackingStatuses!;
        if (outList.length > 0) {}
      } else {
          if (!Get.isSnackbarOpen) {
           Get.snackbar('Filed', ShipmentApi.mass);
         }
        
      }
    } finally {
     if (ShipmentApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        ShipmentApi.checkAuth = false;
      }
      isLoadingOut(false);
     
    }
  }

//----------API-------------------

  TextEditingController searchConter = TextEditingController();

  var searchResult = <Request?>[].obs;
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
              select: _model.typeName.text.isNotEmpty
                  ? _model.typeName.text
                  : null,
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
