import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/branch_view_model.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OficesListView extends StatelessWidget {
  OficesListView({Key? key, required this.controller}) : super(key: key);
  final BranchController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WaiteImage();
      } else {
        if (controller.branchListData.isNotEmpty) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              MyInput(
                keyboardType: TextInputType.name,
                hintText: 'Search',
                controller: controller.searchConter,
                onChanged: controller.onSearchTextChanged,
                suffixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
              Expanded(
                flex: 13,
                child: controller.searchResult.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 10),
                        itemCount: controller.searchResult.length,
                        itemBuilder: (context, i) => InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: primaryColor.withOpacity(0.1),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text:
                                          '${controller.searchResult[i]!.name}',
                                      color: text1Color,
                                      fontWeight: FontWeight.w500,
                                      size: 15,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title: 'Google map',
                                                titlePadding:
                                                    const EdgeInsets.all(15),
                                                contentPadding:
                                                    const EdgeInsets.all(5),
                                                middleText:
                                                    'Open View In Gooole Map',
                                                textCancel: 'Cancel',
                                                textConfirm: 'Ok',
                                                buttonColor: primaryColor,
                                                confirmTextColor: Colors.white,
                                                cancelTextColor: Colors.black,
                                                radius: 10,
                                                backgroundColor: whiteColor,
                                                onConfirm: () {
                                                  MapUtils.openMap(
                                                      double.parse(controller
                                                          .searchResult[i]!.lat
                                                          .toString()),
                                                      double.parse(controller
                                                          .searchResult[i]!.lng
                                                          .toString()));
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              CustomText(
                                                text: 'Go To Location',
                                                color: primaryColor,
                                              ),
                                              Icon(
                                                Icons.near_me,
                                                color: primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title: 'Whatsapp',
                                                titlePadding:
                                                    const EdgeInsets.all(15),
                                                contentPadding:
                                                    const EdgeInsets.all(5),
                                                middleText:
                                                    'Are you want to go to whatsapp?',
                                                textCancel: 'Cancel',
                                                textConfirm: 'Ok',
                                                buttonColor: primaryColor,
                                                confirmTextColor: Colors.white,
                                                cancelTextColor: Colors.black,
                                                radius: 10,
                                                backgroundColor: whiteColor,
                                                onConfirm: () {
                                                  controller.launchWhatsapp(
                                                      "${controller.searchResult[i]!.phone}");
                                                });
                                          },
                                          child: Image.asset(
                                            'assets/images/what.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                                title: 'Call',
                                                titlePadding:
                                                    const EdgeInsets.all(15),
                                                contentPadding:
                                                    const EdgeInsets.all(5),
                                                middleText:
                                                    'Are you want to call?',
                                                textCancel: 'Cancel',
                                                textConfirm: 'Ok',
                                                buttonColor: primaryColor,
                                                confirmTextColor: Colors.white,
                                                cancelTextColor: Colors.black,
                                                radius: 10,
                                                backgroundColor: whiteColor,
                                                onConfirm: () {
                                                  controller.makePhoneCall(
                                                      "${controller.searchResult[i]!.phone}");
                                                });
                                          },
                                          child: Image.asset(
                                            'assets/images/call.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const CustomText(
                                  text:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis sit feugiat a. Sed luctus mattis sed sed pellentesque donec.',
                                  color: text1Color,
                                  fontWeight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : controller.searchResult.isEmpty &&
                            controller.searchConter.text.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const EmptyState(
                                label: 'no Data ',
                              ),
                              MaterialButton(
                                onPressed: () {
                                  controller.branchListData();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CustomText(
                                      text: 'Updated data ',
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
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            separatorBuilder: (context, i) =>
                                const SizedBox(height: 10),
                            itemCount: controller.branchListData.length,
                            itemBuilder: (context, i) => InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        color: primaryColor.withOpacity(0.1),
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              '${controller.branchListData[i].name}',
                                          color: text1Color,
                                          fontWeight: FontWeight.w500,
                                          size: 15,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.defaultDialog(
                                                    title: 'Google map',
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    contentPadding:
                                                        const EdgeInsets.all(5),
                                                    middleText:
                                                        'Open View In Gooole Map',
                                                    textCancel: 'Cancel',
                                                    textConfirm: 'Ok',
                                                    buttonColor: primaryColor,
                                                    confirmTextColor:
                                                        Colors.white,
                                                    cancelTextColor:
                                                        Colors.black,
                                                    radius: 10,
                                                    backgroundColor: whiteColor,
                                                    onConfirm: () {
                                                      MapUtils.openMap(
                                                          double.parse(controller
                                                              .branchListData[i]
                                                              .lat
                                                              .toString()),
                                                          double.parse(controller
                                                              .branchListData[i]
                                                              .lng
                                                              .toString()));
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    text: 'Go To Location',
                                                    color: primaryColor,
                                                  ),
                                                  Icon(
                                                    Icons.near_me,
                                                    color: primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                Get.defaultDialog(
                                                    title: 'Whatsapp',
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    contentPadding:
                                                        const EdgeInsets.all(5),
                                                    middleText:
                                                        'Are you want to go to whatsapp?',
                                                    textCancel: 'Cancel',
                                                    textConfirm: 'Ok',
                                                    buttonColor: primaryColor,
                                                    confirmTextColor:
                                                        Colors.white,
                                                    cancelTextColor:
                                                        Colors.black,
                                                    radius: 10,
                                                    backgroundColor: whiteColor,
                                                    onConfirm: () {
                                                      controller.launchWhatsapp(
                                                          "${controller.branchListData[i].phone}");
                                                    });
                                              },
                                              child: Image.asset(
                                                'assets/images/what.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                Get.defaultDialog(
                                                    title: 'Call',
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    contentPadding:
                                                        const EdgeInsets.all(5),
                                                    middleText:
                                                        'Are you want to call?',
                                                    textCancel: 'Cancel',
                                                    textConfirm: 'Ok',
                                                    buttonColor: primaryColor,
                                                    confirmTextColor:
                                                        Colors.white,
                                                    cancelTextColor:
                                                        Colors.black,
                                                    radius: 10,
                                                    backgroundColor: whiteColor,
                                                    onConfirm: () {
                                                      controller.makePhoneCall(
                                                          "${controller.branchListData[i].phone}");
                                                    });
                                              },
                                              child: Image.asset(
                                                'assets/images/call.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    const CustomText(
                                      text:
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis sit feugiat a. Sed luctus mattis sed sed pellentesque donec.',
                                      color: text1Color,
                                      fontWeight: FontWeight.w400,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              ),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EmptyState(
                label: 'no Data ',
              ),
              MaterialButton(
                onPressed: () {
                  controller.fetchBrnchListData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CustomText(
                      text: 'Updated data ',
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
          );
        }
      }
    });
  }
}
