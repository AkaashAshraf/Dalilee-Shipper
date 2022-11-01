import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class MainCardBodyView extends StatelessWidget {
  MainCardBodyView(
      {Key? key, required this.controller, this.onUplod, required this.title})
      : super(key: key);
  final String title;
  final Widget controller;
  final void Function()? onUplod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 25),
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: controller,
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
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
