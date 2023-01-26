import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/what3word_view_model.dart';
import 'package:dalile_customer/model/W3Words.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class What3WordsView extends StatefulWidget {
  const What3WordsView({Key? key}) : super(key: key);

  @override
  State<What3WordsView> createState() => _What3WordsViewState();
}

class _What3WordsViewState extends State<What3WordsView> {
  List<String> added = [];
  String currentText = "";
  String backupCurrentText = "";

  @override
  void initState() {
    textController = TextEditingController(text: currentText);
    super.initState();
  }

  var textController;
  // GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Get.put(What3WordController()).currentWords.value = "";
    final _data = Get.put(What3WordController());
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
            child: Form(
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
                        CustomText(
                          text: "Enter what3words",
                          color: text1Color,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // AutocompleteBasicExample(),
                        TypeAheadField(
                          hideOnError: true,
                          // getImmediateSuggestions: true,

                          // onSuggestionsBoxToggle: (p0) => {print(p0)},
                          animationDuration: Duration(microseconds: 0),
                          debounceDuration: Duration(microseconds: 0),
                          animationStart: 0,
                          minCharsForSuggestions: 1,

                          textFieldConfiguration: TextFieldConfiguration(
                              controller: TextEditingController(
                                  text: _data.readyToSubmitWords.value),
                              maxLines: 1,
                              autocorrect: false,
                              onEditingComplete: () {
                                setState(() {
                                  backupCurrentText =
                                      _data.readyToSubmitWords.value.toString();
                                });
                                // print(object)
                              },
                              onChanged: ((value) {
                                _data.readyToSubmitWords(value);
                                _data.currentWords.value = value;
                                final dots = value.split(".");

                                if (dots.length > 1)
                                  Get.put(What3WordController())
                                      .getMyWords(words: value);
                                else
                                  Get.put(What3WordController())
                                      .getMyWords(words: '..');
                              }),
                              autofocus: true,
                              // style: DefaultTextStyle.of(context)
                              //     .style
                              //     .copyWith(fontStyle: FontStyle.italic),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder())),
                          suggestionsCallback: (pattern) async {
                            return _data.suggestions;
                          },
                          hideOnEmpty: true,

                          // hideSuggestionsOnKeyboardHide: false,

                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              // leading: Icon(Icons.shopping_cart),
                              title: Row(
                                children: [
                                  Text(
                                    "///",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(suggestion.toString()),
                                ],
                              ),
                              subtitle: _data.suggestions.indexOf(suggestion) <
                                      _data.list.length
                                  ? Text(
                                      _data
                                          .list[_data.suggestions
                                              .indexOf(suggestion)]
                                          .nearestPlace
                                          .toString(),
                                      style: TextStyle(fontSize: 10),
                                    )
                                  : Text(''),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            print(suggestion);
                            setState(() {
                              _data.readyToSubmitWords(suggestion.toString());
                            });
                          },
                        ),
                        if (_data.readyToSubmitWords.split(".").length < 3)
                          CustomText(
                            text: "should contains ( . )",
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        // if (false)
                        // SimpleAutoCompleteTextField(
                        //     key: key,

                        //     // autofocus: true,
                        //     decoration: InputDecoration(
                        //         border: const OutlineInputBorder(
                        //             // borderSide: BorderSide(
                        //             //     color: Colors.blue, width: 0.5),
                        //             ),
                        //         hintText: "/// limit.broom.flip",
                        //         errorText:
                        //             !_data.currentWords.value.contains(".")
                        //                 ? " "
                        //                 : ""),
                        //     controller:
                        //         TextEditingController(text: currentText),
                        //     suggestions: [],
                        //     textChanged: (text) {
                        //       final dots = text.split(".");

                        //       _data.currentWords.value = text;
                        //       // if (dots.length > 1)
                        //       //   Get.put(What3WordController())
                        //       //       .getMyWords(words: text);
                        //     },
                        //     clearOnSubmit: false,
                        //     textSubmitted: (text) => {
                        //           _data.currentWords.value = text,
                        //         }),
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
                                _data.chickWhat3Word(context,
                                    words: _data.readyToSubmitWords.value);
                              }
                            },
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
