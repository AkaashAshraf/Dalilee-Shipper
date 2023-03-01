import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/mange_account_controller.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAccountsView extends StatelessWidget {
  ManageAccountsView({Key? key}) : super(key: key);

  final ManageAccountController controller =
      Get.put(ManageAccountController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: primaryColor,
          appBar: _buildAppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              controller.editBankAccount(context, "AddBankAccount".tr);
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
            child: controller.isLoading.value
                ? const WaiteImage()
                : controller.accountData.isNotEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  controller.fetchManageAccountData();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Updateddata'.tr,
                                      color: Colors.grey,
                                      alignment: Alignment.center,
                                      size: 10,
                                    ),
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 13,
                                child: ListView.separated(
                                  separatorBuilder: (context, i) =>
                                      const SizedBox(height: 13),
                                  itemCount: controller.accountData.length,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10, top: 5),
                                  itemBuilder: (context, i) {
                                    return Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                color: Colors.grey.shade300,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    child: CustomText(
                                                      direction:
                                                          TextDirection.ltr,
                                                      text:
                                                          'Mr. ${controller.accountData[i].name}',
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {},
                                                  //   child: Image.asset(
                                                  //     'assets/images/edits.png',
                                                  //     height: 20,
                                                  //     width: 20,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: CustomText(
                                                  direction: TextDirection.ltr,
                                                  text:
                                                      '${controller.accountData[i].bankName}',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: CustomText(
                                                  direction: TextDirection.ltr,
                                                  text:
                                                      "Account Number: ${controller.accountData[i].accounttNo.toString()}",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                  },
                                )),
                          ],
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
                              controller.fetchManageAccountData();
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

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: 'ManageAccounts'.tr,
          color: whiteColor,
          size: 18,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
