import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/complain_api.dart';
import 'package:dalile_customer/model/complain_type_model.dart';
import 'package:dalile_customer/model/complian_model.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainController extends GetxController {
  @override
  void onInit() {
    fetchComplainData();

    fetchOpenComplainData();
    super.onInit();
  }

  //--------------------formVal------------
  //--------------------formVal------------
  //--------------------formVal------------
  GlobalKey<FormState> formKay = GlobalKey<FormState>();
  formVal(context) {
    if (formKay.currentState!.validate()) {
      fetchCreateComplinData(context);
    }
  }

  //--------------------formVal------------
  //--------------------formVal------------
  //--------------------formVal------------
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;

  var comCloseData = <Ticket>[].obs;
  var comOpenData = <Ticket>[].obs;
  List<Category> typeData = [];
  void fetchComplainData() async {
    try {
      isLoading2(true);
      var data = await ComplainApi.fetchComplainData("2");
      if (data != null) {
        comCloseData.value = data.reversed.toList();
      } else {
        Get.snackbar('Filed'.tr, ComplainApi.mass);
      }
    } finally {
      if (ComplainApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        ComplainApi.checkAuth = false;
      }
      isLoading2(false);
    }
  }

  void fetchOpenComplainData() async {
    try {
      isLoading1(true);
      var data = await ComplainApi.fetchComplainData("1");
      if (data != null) {
        comOpenData.value = data.reversed.toList();
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed'.tr, ComplainApi.mass);
        }
      }
    } finally {
      if (ComplainApi.checkAuth == true) {
        Get.offAll(() => LoginView());
        ComplainApi.checkAuth = false;
      }
      isLoading1(false);
    }
  }

  void fetchTypeComplainData() async {
    try {
      var data = await ComplainApi.fetchTypeListData();
      if (data != null) {
        typeData = data.categories!;
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed'.tr, ComplainApi.mass);
        }
      }
    } finally {
      update();
    }
  }

  var isLoadingCreate = false;
  void fetchCreateComplinData(context) async {
    isLoadingCreate = true;
    update();
    try {
      dynamic data = await ComplainApi.fetchCreateComplainData(
              orderID.text, typeID.text, typeName.text, desc)
          .whenComplete(() {
        if (Get.isDialogOpen != true) {
          Get.back();
        }
      });

      if (data == 1 || data == "1") {
        showDialog(
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return  CustomDialogBoxAl(
                title: "Done !!",
                des: "addcomplainsuccessfully".tr,
                icon: Icons.priority_high_outlined,
              );
            });
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Filed'.tr, "somedatamissing".tr);
        }
      }
    } finally {
      orderID.clear();
      fetchOpenComplainData();
      isLoadingCreate = false;
      update();
    }
  }

  TextEditingController orderID = TextEditingController();
  TextEditingController typeName = TextEditingController();
  TextEditingController typeID = TextEditingController();
  String desc = "";
  showD(context) {
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
          return const ShowCreateComplain();
        }),
      ),
    );
  }
}

class ShowCreateComplain extends StatelessWidget {
  const ShowCreateComplain({
    Key? key,
  }) : super(key: key);

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
                CustomText(
                  text: 'RequestTicket'.tr,
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
              controller: _model.orderID,
              text: 'OrderNo'.tr,
              hintText: 'P00000',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormFiled(
              select:
                  _model.typeName.text.isNotEmpty ? _model.typeName.text : null,
              hint: 'TicketType'.tr,
              // select: controller.bankName.text,
              text: 'SelectTicketType'.tr,
              onSaved: (val) {
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
              validator: (val) =>
                  val!.isEmpty ? 'please explain your ticket' : null,
              text: 'ExplainyourTicket'.tr,
              hintText: 'writing'.tr,
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
                    text: 'Create'.tr,
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
