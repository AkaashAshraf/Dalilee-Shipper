// ignore_for_file: file_names

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
          title:const CustomText(
            text: 'Terms & Conditions',
            color: whiteColor,
            size: 17,
            alignment: Alignment.center,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
        ),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int e = 0; e < 7; e++)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomText(
                        text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitant dapibus feugiat ornare leo ligula iaculis nisl morbi quisque. Massa dignissim nibh tellus fames mattis.',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            )));
  }
}
