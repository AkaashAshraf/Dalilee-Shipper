import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/finance_controller.dart';
import 'package:dalile_customer/controllers/view_order_controller.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/menu/finances/view_closed_invoice_order.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ColusedView extends StatefulWidget {
  const ColusedView({Key? key, required this.c}) : super(key: key);

  final FinanceController c;

  @override
  State<ColusedView> createState() => _ColusedViewState();
}

class _ColusedViewState extends State<ColusedView> {
  ScrollController? scrollController;
  HelperController helperController = Get.put(HelperController());
  ViewOrderController viewOrderController = Get.put(ViewOrderController());

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore();
    });

    super.dispose();
  }

  _loadMore() {
    if (widget.c.loadMoreClosed.value) return;

    if (widget.c.totalCloseInvoices > widget.c.closeData.length &&
        scrollController!.position.extentAfter < 1000.0) {
      widget.c.loadMoreClosed.value = true;
      widget.c.loadMoreClosed(true);
      widget.c.fetchCloseData(isRefresh: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: true);
    return Obx(() {
      if (widget.c.isLoading.value) {
        return const WaiteImage();
      }
      if (widget.c.closeData.isNotEmpty) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 12,
                  child: SmartRefresher(
                    header: WaterDropHeader(
                      waterDropColor: primaryColor,
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await widget.c.fetchCloseData(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                      itemCount: widget.c.closeData.length,
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
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 10, top: 10),
                            child: Column(
                              children: [
                                _rowWithImage(
                                    widget.c.closeData[i].id.toString(),
                                    widget.c.closeData[i].id.toString()),
                                const Divider(
                                  thickness: 3,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                _buildRowText('closingDate'.tr,
                                    '${widget.c.closeData[i].closingDate}'),
                                _buildRowText('totalOrderDeliver'.tr,
                                    '${widget.c.closeData[i].totalOrders}'),
                                _buildRowText(
                                    'COD'.tr,
                                    helperController.getCurrencyInFormat(
                                        widget.c.closeData[i].cod)),
                                _buildRowText(
                                    'ShippingCost'.tr,
                                    helperController.getCurrencyInFormat(
                                        widget.c.closeData[i].shipping)),
                                _buildRowText(
                                    'CC'.tr,
                                    helperController.getCurrencyInFormat(
                                        widget.c.closeData[i].cc)),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'invoiceAmoint'.tr,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                        size: 14,
                                      ),
                                      CustomText(
                                        text: helperController
                                            .getCurrencyInFormat(widget
                                                .c
                                                .closeData[i]
                                                .amountTransferred),
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (widget.c.loadMoreClosed.value) bottomLoadingIndicator()
              ],
            ),
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
              widget.c.fetchCloseData(isRefresh: true);
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

  Row _rowWithImage(String text, id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: 'Invoice'.tr + ' : $text',
          color: primaryColor,
          size: Get.locale.toString() == "ar" ? 14 : 18,
          fontWeight: FontWeight.bold,
        ),
        Row(
          children: [
            // Image.asset(
            //   'assets/images/csv.png',
            //   width: 25,
            //   height: 25,
            // ),
            // const SizedBox(
            //   width: 10,
            // ),
            GestureDetector(
              onTap: () {
                viewOrderController.closedOrderData.value = [];
                viewOrderController.totalClosedOrders.value = 0;
                Get.to(ViewClosedInvoiceOrderView(
                  invoiceId: id.toString(),
                ));
              },
              child: Icon(
                Icons.remove_red_eye,
                color: primaryColor,
                size: 30.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: 'CSV ' + 'File'.tr,
                    titlePadding: const EdgeInsets.all(15),
                    contentPadding: const EdgeInsets.all(5),
                    middleText: 'AreDownloadpdf'.tr,
                    textCancel: 'Cancel'.tr,
                    textConfirm: 'Ok'.tr,
                    buttonColor: primaryColor,
                    confirmTextColor: Colors.white,
                    cancelTextColor: Colors.black,
                    radius: 10,
                    backgroundColor: whiteColor,
                    onConfirm: () {
                      widget.c.launchCSV(
                        id,
                      );
                    });
              },
              child: Image.asset(
                'assets/images/csv.png',
                width: 25,
                height: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    title: 'PDF ' + 'File'.tr,
                    titlePadding: const EdgeInsets.all(15),
                    contentPadding: const EdgeInsets.all(5),
                    middleText: 'AreDownloadpdf'.tr,
                    textCancel: 'Cancel'.tr,
                    textConfirm: 'Ok'.tr,
                    buttonColor: primaryColor,
                    confirmTextColor: Colors.white,
                    cancelTextColor: Colors.black,
                    radius: 10,
                    backgroundColor: whiteColor,
                    onConfirm: () {
                      widget.c.launchFile(id, type: "pdf");
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
            size: Get.locale.toString() == "ar" ? 10 : 12,
            text: title,
            fontWeight: FontWeight.w500,
            color: text1Color,
          ),
          CustomText(
            size: Get.locale.toString() == "ar" ? 10 : 12,
            text: subTilte,
            fontWeight: FontWeight.w500,
            color: text1Color,
          ),
        ],
      ),
    );
  }
}
