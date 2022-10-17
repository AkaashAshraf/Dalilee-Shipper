import 'package:dalile_customer/constants.dart';
import 'package:flutter/material.dart';

// TextFormField _customTextInput(
//     {required String label,
//     required String initialValue,
//     int maxLines = 1,
//     dynamic validator,
//     TextInputType keyboardType: TextInputType.text,
//     AutovalidateMode autovalidateMode: AutovalidateMode.disabled,
//     required dynamic onTextChange}) {
//   return TextFormField(
//     onChanged: (val) {
//       onTextChange(val);
//     },
//     autocorrect: false,
//     initialValue: initialValue,
//     autovalidateMode: autovalidateMode,
//     validator: validator,
//     keyboardType: keyboardType,
//     maxLines: maxLines,
//     decoration: InputDecoration(
//       labelText: label,
//       isDense: true,
//       contentPadding: const EdgeInsets.all(15),
//       labelStyle: const TextStyle(color: text1Color, fontSize: 12),
//       hintStyle: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
//       focusedBorder: const OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.blue, width: 1),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: Colors.red),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: Colors.red),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//     ),
//   );
// }

class textInputCustom extends StatelessWidget {
  const textInputCustom(
      {Key? key,
      required this.label,
      required this.initialValue,
      this.maxLines: 1,
      this.validator,
      this.keyboardType: TextInputType.text,
      this.autovalidateMode: AutovalidateMode.disabled,
      required this.onTextChange})
      : super(key: key);
  final String label;
  final String initialValue;
  final int maxLines;
  final dynamic validator;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final dynamic onTextChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {
        onTextChange(val);
      },
      autocorrect: false,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        contentPadding: const EdgeInsets.all(15),
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
      ),
    );
  }
}
