import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/what3word_view_model.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class What3WordsView extends StatefulWidget {
  const What3WordsView({Key? key}) : super(key: key);

  @override
  State<What3WordsView> createState() => _What3WordsViewState();
}

class _What3WordsViewState extends State<What3WordsView> {
  List<String> added = [];
  String currentText = "";

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Get.put(What3WordController()).currentWords.value = "";
    Get.put(What3WordController()).getMyWords();

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.3),
      body: Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 1)
              ]),
          child: GetX<What3WordController>(
              init: What3WordController(),
              builder: (_data) {
                return Form(
                  key: _data.formKeyG,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.clear_outlined,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child:
                            // CustomFormFiledWithTitle(
                            //   controller: _data.twaController,
                            //   validator: (val) => val!.isEmpty
                            //       ? "please enter 3 word"
                            //       : !val.contains('.')
                            //           ? "should contains ( . )"
                            //           : null,
                            //   text: 'Enter what3words',
                            //   hintText: '/// limit.broom.flip',
                            // ),
                            Column(
                          children: [
                            CustomText(
                              text: "Enter what3words",
                              color: text1Color,
                              fontWeight: FontWeight.w400,
                            ),
                            SimpleAutoCompleteTextField(
                                key: key,

                                // autofocus: true,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        // borderSide: BorderSide(
                                        //     color: Colors.blue, width: 0.5),
                                        ),
                                    hintText: "/// limit.broom.flip",
                                    errorText:
                                        !_data.currentWords.value.contains(".")
                                            ? "invalid patterens"
                                            : ""),
                                controller:
                                    TextEditingController(text: currentText),
                                suggestions: _data.suggestions,
                                textChanged: (text) =>
                                    _data.currentWords.value = text,
                                clearOnSubmit: false,
                                textSubmitted: (text) => {
                                      _data.currentWords.value = text,
                                    }),
                          ],
                        ),
                      ),
                      //SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: _data.isWaiting
                            ? WaiteImage()
                            : CustomButtom(
                                text: "Pick ",
                                onPressed: () {
                                  if (_data.formKeyG.currentState!.validate()) {
                                    _data.chickWhat3Word(context);
                                  }
                                },
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
