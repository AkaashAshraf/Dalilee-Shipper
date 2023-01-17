import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

class CustomFormFiled extends StatelessWidget {
  final String text, hint;
  final dynamic onSaved;
  final String? Function(String?)? validator;
  final String? select;
  final List<String>? items;
  const CustomFormFiled(
      {Key? key,
      required this.text,
      required this.hint,
      required this.onSaved,
      required this.validator,
      required this.items,
      this.select})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: text,
              color: text1Color,
              alignment: "ENORAR".tr == "ar"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownSearch<String>(
          selectedItem: select,
          mode: Mode.MENU,
          showSelectedItems: true,
          validator: validator,
          onChanged: onSaved,

          autoValidateMode: AutovalidateMode.onUserInteraction,
          items: items,
          showAsSuffixIcons: true,
          //label: "Menu mode",
          dropdownSearchDecoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.2))),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              fillColor: whiteColor,
              filled: true),

          popupItemDisabled: (String s) => s.startsWith('Select'),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
