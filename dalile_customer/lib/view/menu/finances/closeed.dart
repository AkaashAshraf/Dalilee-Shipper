import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/finance_view_model.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColusedView extends StatelessWidget {
  const ColusedView({Key? key, required this.c}) : super(key: key);
  final FinanceController c;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.isLoading.value) {
        return const WaiteImage();
      }
      if (c.closeData.isNotEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  c.fetchCloseData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CustomText(
                      text: 'Updated data ',
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
              flex: 12,
              child: ListView.separated(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 5),
                separatorBuilder: (context, i) => const SizedBox(height: 15),
                itemCount: c.closeData.length,
                itemBuilder: (context, i) {
                  return Container(
                    constraints: const BoxConstraints(
                      minHeight: 175,
                    ),
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
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 10, top: 10),
                      child: Column(
                        children: [
                          _rowWithImage(c.closeData[i].id.toString(),
                              c.closeData[i].id.toString()),
                          const Divider(
                            thickness: 3,
                            indent: 0,
                            endIndent: 0,
                          ),
                          _buildRowText('Closing Date :',
                              '${c.closeData[i].closingDate}'),
                          _buildRowText('COD :', '${c.closeData[i].cod} OMR'),
                          _buildRowText('Shipping Cost :',
                              '${c.closeData[i].shippingCost} OMR'),
                          _buildRowText('Total Orders Delivered :',
                              '${c.closeData[i].totalOrders}'),
                          _buildRowText('CC :', '${c.closeData[i].cc} OMR'),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: 'Invoices Amount :',
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  size: 14,
                                ),
                                CustomText(
                                  text:
                                      '${c.closeData[i].amountTransferred ?? 0.00} OMR',
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
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
          const EmptyState(
            label: 'no Data ',
          ),
          MaterialButton(
            onPressed: () {
                 c.fetchCloseData();
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
    });
  }

  Row _rowWithImage(String text, id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: 'Invoice : $text',
          color: primaryColor,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/csv.png',
              width: 25,
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: 'PDF File',
                    titlePadding: const EdgeInsets.all(15),
                    contentPadding: const EdgeInsets.all(5),
                    middleText: 'Are you sure to download pdf file?',
                    textCancel: 'Cancel',
                    textConfirm: 'Ok',
                    buttonColor: primaryColor,
                    confirmTextColor: Colors.white,
                    cancelTextColor: Colors.black,
                    radius: 10,
                    backgroundColor: whiteColor,
                    onConfirm: () {
                      c.launchPDF(id);
                    });
              },
              child: Image.asset(
                'assets/images/pdf.png',
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRowText(String title, String subTilte) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontWeight: FontWeight.w500,
            color: text1Color,
          ),
          CustomText(
            text: subTilte,
            fontWeight: FontWeight.w500,
            color: text1Color,
          ),
        ],
      ),
    );
  }
}
