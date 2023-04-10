import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/enquiry_controller.dart';
import 'package:dalile_customer/controllers/finance_controller.dart';
import 'package:dalile_customer/controllers/mange_account_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/menu/finances/finance_enquiry_details.dart';
import 'package:dalile_customer/view/menu/finances/otp_modal.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FinanceEnquiry extends StatelessWidget {
  FinanceEnquiry({Key? key}) : super(key: key);
  final EnquiryFinanceController controller =
      Get.put(EnquiryFinanceController(), permanent: true);

  final now = DateTime.now();
  final berlinWallFell = DateTime.utc(1989, 11, 9);
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  HelperController helperController = Get.put(HelperController());
  final FinanceController financeController = Get.put(FinanceController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: primaryColor,
          appBar: _buildAppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (financeController.openData.value.remaining < 1) {
                Get.snackbar('less_amount_warning'.tr.tr, " ",
                    backgroundColor: Colors.orange.withOpacity(0.9),
                    colorText: Colors.white);
                return;
              }
              controller.selectedAccountID(0);
              controller.selectedAccountName("");
              controller.estimatedAmount(
                  financeController.openData.value.remaining.toString());
              controller.description("");

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  content: Builder(builder: (context) {
                    return const _AlrtAddEnquryBody();
                  }),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: controller.enquriyData.isNotEmpty
                ? SmartRefresher(
                    header: WaterDropHeader(
                      waterDropColor: primaryColor,
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await controller.fetchEnquiryFinanceData();
                      refreshController.refreshCompleted();
                    },
                    child: ListView.separated(
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 10),
                      itemCount: controller.enquriyData.length,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      itemBuilder: (context, i) {
                        final _date = controller.enquriyData[i].updatedAt;

                        return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.grey.shade300,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'EnquiryNo'.tr +
                                          ' : ${controller.enquriyData[i].enqNo}',
                                      color: primaryColor,
                                      size: Get.locale.toString() == "ar"
                                          ? 12
                                          : 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => FinanceEnquiryDetails(
                                                    isOpen: controller
                                                        .enquriyData[i].status
                                                        .toString(),
                                                    createAt: _date.toString(),
                                                  ),
                                              transition: Transition.cupertino,
                                              duration: const Duration(
                                                  milliseconds: 700));
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    controller.enquriyData[i]
                                                                .status
                                                                .toString() ==
                                                            "Closed"
                                                        ? primaryColor
                                                        : textRedColor,
                                                    controller.enquriyData[i]
                                                                .status
                                                                .toString() ==
                                                            "Closed"
                                                        ? primaryColor
                                                            .withOpacity(0.5)
                                                        : textRedColor
                                                            .withOpacity(0.5)
                                                  ],
                                                  stops: const [0.3, 2],
                                                  end: Alignment.bottomCenter,
                                                  begin: Alignment.topCenter,
                                                ),
                                              ),
                                              //alignment: Alignment.center,
                                              child: Center(
                                                child: CustomText(
                                                  size: Get.locale.toString() ==
                                                          "ar"
                                                      ? 10
                                                      : 13,
                                                  text: controller
                                                              .enquriyData[i]
                                                              .status
                                                              .toString() ==
                                                          "Closed"
                                                      ? "Closed".tr
                                                      : 'Opened'.tr,
                                                  color: whiteColor,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                const Divider(
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      size: Get.locale.toString() == "ar"
                                          ? 11
                                          : 14,
                                      text: 'expectedAmount'.tr,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    CustomText(
                                      size: Get.locale.toString() == "ar"
                                          ? 11
                                          : 14,
                                      text: helperController
                                          .getCurrencyInFormat(controller
                                                  .enquriyData[i].amount ??
                                              "0"),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            size: Get.locale.toString() == "ar"
                                                ? 11
                                                : 14,
                                            text: 'requestDate'.tr,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          CustomText(
                                            size: Get.locale.toString() == "ar"
                                                ? 11
                                                : 14,
                                            text: ' ${_date?.split(" ")[0]}',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: CustomText(
                                    size:
                                        Get.locale.toString() == "ar" ? 11 : 14,
                                    text: 'Description'.tr,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: CustomText(
                                    text:
                                        controller.enquriyData[i].description ??
                                            "",
                                    maxLines: 4,
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                CustomText(
                                  text: 'notes'.tr,
                                  size: Get.locale.toString() == "ar" ? 11 : 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 15, bottom: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int p = 0;
                                          p <
                                              controller
                                                  .enquriyData[i].notes!.length;
                                          p++)
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (p > 0)
                                              Align(
                                                  alignment: Get.locale
                                                              .toString() ==
                                                          "en"
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                                  child: dottedLine(context)),
                                            SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: primaryColor,
                                                    size: 15.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    controller.enquriyData[i]
                                                        .notes![p].createdAt!
                                                        .split(" ")[0],
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      controller.enquriyData[i]
                                                          .notes![p].note!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyState(
                        label: 'NoData'.tr,
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.fetchEnquiryFinanceData();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: 'Updateddata'.tr,
                              color: Colors.grey,
                              alignment: Alignment.center,
                              size: 12,
                            ),
                            Icon(
                              Icons.refresh,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }

  Padding dottedLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, top: 5, right: 7),
      child: SizedBox(
        height: 30,
        child: DottedLine(
          lineThickness: 2,
          dashGapRadius: 0.5,
          direction: Axis.vertical,
          dashRadius: 0.5,
          dashColor: Colors.grey.shade500,
          dashGapColor: Colors.grey.shade500,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: 'FinanceInquiry'.tr.toUpperCase(),
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w600,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}

class _AlrtAddEnquryBody extends StatefulWidget {
  const _AlrtAddEnquryBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_AlrtAddEnquryBody> createState() => _AlrtAddEnquryBodyState();
}

class _AlrtAddEnquryBodyState extends State<_AlrtAddEnquryBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ManageAccountController());
    return GetBuilder<ManageAccountController>(builder: (_data) {
      return SizedBox(
        // height: 520,
        child: GetX<EnquiryFinanceController>(builder: (controller) {
          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'RequestInquiry'.tr,
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
                  CustomFormFiled(
                    select: controller.selectedAccountName.isEmpty
                        ? null
                        : controller.selectedAccountName.value,
                    items: List.generate(_data.accountData.length,
                        (index) => _data.accountData[index].name.toString()),

                    hint: 'selectaccount'.tr,
                    // select: controller.bankName.text,
                    text: 'bankaccount'.tr,
                    onSaved: (val) {
                      for (int i = 0; i < _data.accountData.length; i++) {
                        if (_data.accountData[i].name == val) {
                          controller.selectedAccountID.value =
                              _data.accountData[i].id ?? 0;
                          controller.selectedAccountName.value =
                              _data.accountData[i].name ?? "";
                          // Get.snackbar(
                          //     controller.selectedAccountID.value.toString(),
                          //     " ",
                          //     colorText: Colors.orange);
                        }
                      }
                      // _data.update();
                      // return null;
                    },
                    validator: (val) => val == null ? 'selectaccount'.tr : null,
                  ),

                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: CustomText(
                              size: Get.locale.toString() == "ar" ? 10 : 12,
                              text: "expected_amount".tr,
                              color: text1Color,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Colors.grey.shade400, // Set border color
                                  width: 1), // Set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  5.0)), // Set rounded corner radius
                            ),
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CustomText(
                                direction: TextDirection.ltr,
                                text: Get.put(HelperController())
                                    .getCurrencyInFormat(
                                        controller.estimatedAmount.value),
                                color: text1Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // CustomFormFiledWithTitle(
                  //   text: "expected_amount".tr,
                  //   initialValue: controller.estimatedAmount.value,
                  //   read: true,
                  //   keyboardType: TextInputType.number,
                  //   onChanged: (val) {
                  //     controller.estimatedAmount.value = val;
                  //   },
                  //   validator: (val) => val!.isEmpty
                  //       ? "expected_amount".tr + " " + "required".tr
                  //       : null,
                  //   hintText: "write_here",
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormFiledAreaWithTitle(
                      validator: (val) => val!.isEmpty ? null : null,
                      onChanged: (val) {
                        controller.description.value = val;
                      },
                      text: 'ExplainyourInquiry'.tr,
                      hintText: 'writing'.tr),
                  const SizedBox(
                    height: 70,
                  ),
                  controller.isAddwiting.value
                      ? WaiteImage()
                      :
                      // : OtpTimerButton(
                      //     controller: controller.otpTimerButtonController,
                      //     backgroundColor: primaryColor,
                      //     onPressed: () {
                      //       controller.sendOtp();

                      //       otpModal(context).show();
                      //       controller.otpTimerButtonController.startTimer();
                      //     },
                      //     text: Text('CreateInquiry'.tr),
                      //     duration: 10,
                      //     height: MediaQuery.of(context).size.height * 0.055,
                      //   ),
                      CustomButtom(
                          text: 'CreateInquiry'.tr,
                          onPressed: () async {
                            var res = await controller.sendOtp(context);

                            if (res) otpModal(context).show();
                          },
                        ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
