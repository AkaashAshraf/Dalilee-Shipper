import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import "package:get/get.dart";

class TermsCondition extends StatefulWidget {
  TermsCondition({Key? key}) : super(key: key);

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("terms&conditions".tr),
        ),
        backgroundColor: bgColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              WebView(
                initialUrl: terms_url,
                onWebViewCreated: (controller) {},
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                onPageFinished: (_) {
                  setState(() {
                    loading = false;
                  });
                },
              ),
              loading
                  ? Center(
                      child: WaiteImage(),
                    )
                  : Stack(),
            ],
          ),
        ));
  }
}
