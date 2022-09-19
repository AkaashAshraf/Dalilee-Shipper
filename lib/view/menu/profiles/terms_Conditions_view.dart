// ignore_for_file: file_names

import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
          title: CustomText(
            text: 'Terms&Conditions'.tr,
            color: whiteColor,
            size: 17,
            alignment: Alignment.center,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
        ),
        body: Container(
            // height: double.infinity,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: bgColor,
              // borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            alignment: Alignment.topCenter,
            child: WebView(
              initialUrl: terms_url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
            )));
  }
}
