import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowComplainShipement extends StatelessWidget {
  const ShowComplainShipement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const  CustomText(
                text: 'Ticket',
                alignment: Alignment.topLeft,
                color: primaryColor,
                size: 15,
                fontWeight: FontWeight.w500,
              ),
              Padding(
                padding:const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon:const Icon(
                    Icons.clear_outlined,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
         const SizedBox(
            height: 20,
          ),
          CustomFormFiled(
            select: '',
            hint: 'Select Ticket Type',
            // select: controller.bankName.text,
            text: 'Ticket Type',
            onSaved: (val) {
              return null;
            },
            validator: (val) => val == null
                ? 'select Ticket type'
                : val.length > 100
                    ? "max number 100"
                    : null,
            items: const ['select'],
          ),
          const CustomFormFiledAreaWithTitle(
              text: 'Explain your Ticket',
              hintText: 'Please explain your complain here'),
          const SizedBox(
            height: 10,
          ),
          CustomButtom(
            text: 'Update',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
