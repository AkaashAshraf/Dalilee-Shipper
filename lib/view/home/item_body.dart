import 'package:dalile_customer/components/common/loading_indicator.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/download_controller.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainCardBodyView extends StatelessWidget {
  MainCardBodyView(
      {Key? key,
      required this.controller,
      required this.module,
      this.onUplod,
      required this.title})
      : super(key: key);
  final String title;
  final String module;

  final Widget controller;
  final void Function()? onUplod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: primaryColor,
        appBar: _buildAppBar(module),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 25),
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: controller,
        ));
  }

  AppBar _buildAppBar(String module) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      actions: [
        if (module.isNotEmpty)
          GetX<DownloadController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: controller.isDownloading.value
                  ? DalileeLoadingIndicator(
                      color: whiteColor,
                      height: 20,
                      width: 20,
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.startDownloadingListWithoutDateRange(
                            "csv", module);
                      },
                      child: Icon(Icons.download)),
            );
          }),
      ],
      title: CustomText(
          text: title,
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
