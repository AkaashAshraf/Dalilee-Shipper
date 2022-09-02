import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/what3word_view_model.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class What3WordsView extends StatelessWidget {
  const What3WordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: GetBuilder<What3WordController>(
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
                        child: CustomFormFiledWithTitle(
                          controller: _data.twaController,
                          validator: (val) => val!.isEmpty
                              ? "please enter 3 word"
                              : !val.contains('.')
                                  ? "should contains ( . )"
                                  : null,
                          text: 'Enter what3words',
                          hintText: '/// limit.broom.flip',
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
