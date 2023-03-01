import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/complain_controller.dart';
import 'package:dalile_customer/controllers/ticket_details_controller.dart';
import 'package:dalile_customer/model/complian_model.dart';
import 'package:dalile_customer/view/menu/complains/complain_details_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainOpendView extends StatelessWidget {
  ComplainOpendView(
      {Key? key,
      this.onPressed,
      required this.controller,
      required this.listData,
      required this.color1,
      required this.color2,
      required this.text})
      : super(key: key);
  final ComplainController controller;
  final void Function()? onPressed;
  final List<Ticket> listData;
  final String text;
  final Color color1, color2;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading1.value || controller.isLoading2.value) {
        return const WaiteImage();
      }
      if (listData.isNotEmpty) {
        return Column(
          children: [
            MaterialButton(
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'Updateddata'.tr,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    size: 11,
                  ),
                  Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 5),
                separatorBuilder: (context, i) => const SizedBox(height: 16),
                itemCount: listData.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Get.put(TicketDetailsController())
                          .fetchTicketDatilsData("7");
                      Get.to(
                          () => ComplainDetails(id: listData[i].id.toString()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: primaryColor.withOpacity(0.1),
                            ),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CustomText(
                              text: 'TicketNo'.tr + ' : ${listData[i].id}',
                              color: primaryColor,
                              size: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(
                            thickness: 3,
                            indent: 0,
                            endIndent: 0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _buildRowText(
                              'OrderNo'.tr + ' : ${listData[i].orderNo}',
                              'TicketType'.tr + ' : ${listData[i].categoryId}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Subject".tr +
                                      " : ${listData[i].subject}",
                                  fontWeight: FontWeight.w400,
                                  size: 12,
                                  color: text1Color,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "status".tr + " : ",
                                      fontWeight: FontWeight.w400,
                                      color: text1Color,
                                      size: 14,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [color1, color2],
                                          stops: const [0, 2],
                                          end: Alignment.bottomCenter,
                                          begin: Alignment.topCenter,
                                        ),
                                      ),
                                      //alignment: Alignment.center,
                                      child: CustomText(
                                        text: text,
                                        color: whiteColor,
                                        alignment: Alignment.center,

                                        // onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyState(
            label: 'NoData'.tr,
          ),
          MaterialButton(
            onPressed: () {
              controller.fetchComplainData();
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
      );
    });
  }

  Widget _buildRowText(String title, String subTilte) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w400,
              size: 12,
              color: text1Color,
            ),
          ),
          Expanded(
            child: CustomText(
              text: subTilte,
              fontWeight: FontWeight.w400,
              size: 12,
              color: text1Color,
            ),
          ),
        ],
      ),
    );
  }
}
