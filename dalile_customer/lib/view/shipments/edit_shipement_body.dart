import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowEditShipment extends StatelessWidget {
  const ShowEditShipment({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  alignment: Alignment.topRight,
                  color: primaryColor,
                  size: 15,
                  fontWeight: FontWeight.w500,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon:const Icon(
                    Icons.clear_outlined,
                    size: 20,
                  ),
                ),
              ],
            ),
           const SizedBox(
              height: 5,
            ),
            CustomFormFiled(
              select: '',
              hint: 'Phone Number',
              text: 'Bank',
              onSaved: (val) {
                return null;
              },
              validator: (val) => val == null
                  ? 'please enter your account number'
                  : val.length > 20
                      ? "max number 20"
                      : null,
              items: const ["select"],
            ),
            CustomFormFiledWithTitle(
              validator: (val) => val!.isEmpty
                  ? 'please enter your account number'
                  : val.length > 20
                      ? "max number 20"
                      : null,
              keyboardType: TextInputType.number,
              text: 'COD',
              hintText: '2.500',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormFiledWithTitle(
              validator: (val) => val!.isEmpty
                  ? 'please enter your name'
                  : val.length > 20
                      ? "name is to long"
                      : null,
              text: 'Region',
              hintText: 'Seeb',
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButtom(
              text: 'Update',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
