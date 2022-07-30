import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        title: const CustomText(
          text: 'PROFILE',
          color: whiteColor,
          size: 18,
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              CustomFormFiledWithTitle(
                hintText: 'Store Name',
                text: 'Store Name',
                prefix: const Icon(
                  Icons.storefront_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Image.asset(
                    'assets/images/edits.png',
                    height: 10,
                    width: 10,
                    color: Colors.grey,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormFiledWithTitle(
                text: 'Username',
                hintText: 'Admin',
                prefix: const Icon(
                  Icons.person_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Image.asset(
                    'assets/images/edits.png',
                    height: 10,
                    width: 10,
                    color: Colors.grey,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormFiledWithTitle(
                text: 'Mobile Number',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Image.asset(
                    'assets/images/edits.png',
                    height: 10,
                    width: 10,
                    color: Colors.grey,
                    fit: BoxFit.fill,
                  ),
                ),
                hintText: '+968 9xxx xxxx',
                prefix: const Icon(
                  Icons.phone_iphone_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButtom(
                text: 'Save',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
