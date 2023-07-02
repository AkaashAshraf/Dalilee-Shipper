import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyInput extends StatelessWidget {
  MyInput(
      {Key? key,
      this.suffixIcon,
      this.hintText,
      this.prefix,
      this.labelText,
      this.initialValue,
      this.controller,
      this.keyboardType,
      this.validator,
      this.obsecure = false,
      this.limitCharacters: 100,
      this.onChanged})
      : super(key: key);
  final TextInputType? keyboardType;
  final limitCharacters;
  final bool obsecure;
  final Widget? suffixIcon, prefix;
  final String? hintText, labelText;
  final String? initialValue;
  String? Function(String?)? validator;
  TextEditingController? controller;
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        obscureText: obsecure,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(limitCharacters),
        ],
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        controller: controller,
        initialValue: initialValue,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          fontSize: 13,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          isDense: true,
          contentPadding: const EdgeInsets.all(15),
          hintText: hintText,
          labelStyle: const TextStyle(color: text1Color, fontSize: 12),
          hintStyle:
              TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefix,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class CustomFormFiledWithTitle extends StatelessWidget {
  const CustomFormFiledWithTitle(
      {Key? key,
      required this.text,
      this.suffixIcon,
      this.hintText,
      this.prefix,
      this.labelText,
      this.initialValue,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.onEditingComplete,
      this.limitCharacters: 50,
      this.read = false})
      : super(key: key);

  final String text;

  final TextInputType? keyboardType;
  final Widget? suffixIcon, prefix;
  final limitCharacters;
  final String? hintText, labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool read;
  final Function()? onEditingComplete;

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
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          inputFormatters: [
            new LengthLimitingTextInputFormatter(limitCharacters),
          ],
          autofocus: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onEditingComplete: onEditingComplete,
          readOnly: read,
          onChanged: onChanged,
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          validator: validator,
          style: read == false
              ? TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                )
              : TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey,
                ),
          textDirection: Get.locale.toString() == "ar"
              ? TextDirection.ltr
              : TextDirection.ltr,
          decoration: InputDecoration(
            labelText: labelText,
            isDense: true,
            contentPadding: const EdgeInsets.all(15),
            hintText: hintText,
            labelStyle: const TextStyle(color: text1Color, fontSize: 12),
            hintStyle:
                TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5),
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: prefix,
            suffixIcon: suffixIcon,
          ),
        )
      ],
    );
  }
}

class CustomFormFiledAreaWithTitle extends StatelessWidget {
  const CustomFormFiledAreaWithTitle(
      {Key? key,
      required this.text,
      this.suffixIcon,
      this.hintText,
      this.prefix,
      this.labelText,
      this.initialValue,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onChanged})
      : super(key: key);

  final String text;

  final TextInputType? keyboardType;
  final Widget? suffixIcon, prefix;
  final String? hintText, labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(
              fontSize: 12,
            ),
            maxLines: 10,
            minLines: 5,
            decoration: InputDecoration(
              labelText: labelText,
              isDense: true,
              hintText: hintText,
              labelStyle: const TextStyle(color: text1Color, fontSize: 12),
              hintStyle:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(5),
              ),
              filled: true,
              fillColor: whiteColor,
              prefixIcon: prefix,
              suffixIcon: suffixIcon,
            ),
          ),
        )
      ],
    );
  }
}
