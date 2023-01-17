import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/calculate_view_model.dart';
import 'package:dalile_customer/helper/helper.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CalculateView extends StatefulWidget {
  const CalculateView({Key? key}) : super(key: key);

  @override
  State<CalculateView> createState() => _CalculateViewState();
}

class _CalculateViewState extends State<CalculateView> {
  final CalculateController _controller = Get.put(CalculateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        title: CustomText(
            text: 'Calculate'.tr.toUpperCase(),
            color: whiteColor,
            size: 18,
            alignment: Alignment.center),
        centerTitle: true,
      ),
      body: Obx(() {
        return Container(
          decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
          ),
          child: _controller.isCompleted.value
              ? ComplatedScreen(text: _controller.calPrice.value)
              : _controller.isLoading.value
                  ? const WaiteImage()
                  : SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                            primary: primaryColor,
                          )),
                          child: Form(
                            key: _controller.keyFromF,
                            child: Stepper(
                              physics: const NeverScrollableScrollPhysics(),
                              elevation: 0,
                              type: StepperType.horizontal,
                              steps: [
                                Step(
                                  state: _controller
                                              .muhafazaNameFrom.text.isEmpty ||
                                          _controller.cWFrom.text.isEmpty ||
                                          _controller.cRFrom.text.isEmpty
                                      ? StepState.editing
                                      : _controller.currentStep.value > 0
                                          ? StepState.complete
                                          : StepState.indexed,
                                  isActive: _controller.currentStep.value >= 0,
                                  title: CustomText(
                                    text: 'FROM'.tr,
                                    fontWeight: FontWeight.w500,
                                    size: 13,
                                  ),
                                  content: _buildFirstPage(context),
                                ),
                                Step(
                                    state: _controller
                                                .muhafazaNameTo.text.isEmpty ||
                                            _controller.cWTo.text.isEmpty ||
                                            _controller.cRTO.text.isEmpty
                                        ? StepState.editing
                                        : _controller.currentStep.value > 1
                                            ? StepState.complete
                                            : StepState.indexed,
                                    isActive:
                                        _controller.currentStep.value >= 1,
                                    title: CustomText(
                                      text: 'TO'.tr,
                                      fontWeight: FontWeight.w500,
                                      size: 13,
                                    ),
                                    content: _buildScandPage(context)),
                                Step(
                                    state: _controller
                                            .wighetController.text.isEmpty
                                        ? StepState.editing
                                        : StepState.indexed,
                                    isActive:
                                        _controller.currentStep.value >= 2,
                                    title: CustomText(
                                      text: 'Weight'.tr.toUpperCase(),
                                      fontWeight: FontWeight.w500,
                                      size: 13,
                                    ),
                                    content: _buildThierdPage(context)),
                              ],
                              currentStep: _controller.currentStep.value,
                              onStepTapped: (val) {
                                _controller.onStepTapped(val);
                              },
                              controlsBuilder: (context, onStep) {
                                final isLastStep =
                                    _controller.currentStep.value == 2;
                                if (_controller.isLoadingPrice.value) {
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: WaiteImage(),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CustomButtom(
                                            text: isLastStep
                                                ? 'Proceed'.tr
                                                : 'Next'.tr,
                                            onPressed: () {
                                              if (isLastStep) {
                                                //send server
                                                _controller.onSave();
                                              } else {
                                                _controller.inc();
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        if (_controller.currentStep.value != 0)
                                          Expanded(
                                            child: CustomButtom(
                                              text: 'Back'.tr,
                                              onPressed: _controller
                                                          .currentStep.value ==
                                                      0
                                                  ? null
                                                  : () {
                                                      _controller.decr();
                                                    },
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
        );
      }),
    );
  }

  Widget _buildFirstPage(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: CustomText(
            text: 'ShippingType'.tr,
            fontWeight: FontWeight.w400,
            size: 13,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ToggleSwitch(
          minWidth: 140,
          borderColor: [
            primaryColor.withOpacity(0.2),
            primaryColor.withOpacity(0.2)
          ],
          fontSize: 13,
          minHeight: 37,
          borderWidth: 1.2,
          inactiveBgColor: whiteColor,
          initialLabelIndex: 0,
          totalSwitches: 2,
          activeBgColor: [primaryColor, primaryColor.withOpacity(0.5)],
          labels: ['Domestic'.tr, 'International'.tr],
          onToggle: (index) {},
        ),
        const SizedBox(
          height: 20,
        ),
        CustomFormFiled(
          select: _controller.muhafazaNameFrom.text.isEmpty
              ? null
              : _controller.muhafazaNameFrom.text,
          text: 'Muhafaza'.tr,
          onSaved: (val) {
            _controller.muhafazaVal1(val);
            return null;
          },
          validator: (val) => val == null ? 'please select muhafaza' : null,
          hint: 'SelectMuhafaza'.tr,
          items:
              _controller.muhafazaList.map((element) => element!.name).toList(),
        ),
        CustomFormFiled(
          select:
              _controller.cWFrom.text.isEmpty ? null : _controller.cWFrom.text,
          text: 'Wilaya'.tr,
          onSaved: (val) {
            _controller.waliaVal1(val);
            return null;
          },
          validator: (val) => val == null ? 'please select wilaya' : null,
          hint: 'wilayaregion'.tr,
          items: _controller.wilayaListFrom
              .map((element) => element!.name)
              .toList(),
        ),
        CustomFormFiled(
          text: 'Region'.tr,
          select:
              _controller.cRFrom.text.isEmpty ? null : _controller.cRFrom.text,
          onSaved: (val) {
            _controller.regionVal1(val);
            return null;
          },
          validator: (val) => val == null ? 'please select region' : null,
          hint: 'selectregion'.tr,
          items: _controller.regionListFrom
              .map((element) => element!.name)
              .toList(),
        ),
      ],
    );
  }

  Widget _buildScandPage(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: CustomText(
            text: 'ShippingType'.tr,
            fontWeight: FontWeight.w400,
            size: 13,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ToggleSwitch(
          minWidth: 140,
          borderColor: [
            primaryColor.withOpacity(0.2),
            primaryColor.withOpacity(0.2)
          ],
          fontSize: 13,
          minHeight: 37,
          borderWidth: 1.2,
          inactiveBgColor: whiteColor,
          initialLabelIndex: 0,
          totalSwitches: 2,
          activeBgColor: [primaryColor, primaryColor.withOpacity(0.5)],
          labels: ['Domestic'.tr, 'International'.tr],
          onToggle: (index) {},
        ),
        const SizedBox(
          height: 20,
        ),
        CustomFormFiled(
          select: _controller.muhafazaNameTo.text.isEmpty
              ? null
              : _controller.muhafazaNameTo.text,
          text: 'Muhafaza'.tr,
          onSaved: (val) {
            _controller.muhafazaVal2(val);
            return null;
          },
          validator: (val) => val == null ? 'please select muhafaza' : null,
          hint: 'SelectMuhafaza'.tr,
          items:
              _controller.muhafazaList.map((element) => element!.name).toList(),
        ),
        CustomFormFiled(
          text: 'Wilaya'.tr,
          select: _controller.cWTo.text.isEmpty ? null : _controller.cWTo.text,
          onSaved: (val) {
            _controller.waliaVal2(val);
            return null;
          },
          validator: (val) => val == null ? 'please select wilaya' : null,
          hint: 'wilayaregion'.tr,
          items:
              _controller.wilayaListTo.map((element) => element!.name).toList(),
        ),
        CustomFormFiled(
          select: _controller.cRTO.text.isEmpty ? null : _controller.cRTO.text,
          text: 'Region'.tr,
          onSaved: (val) {
            _controller.regionVal2(val);
            return null;
          },
          validator: (val) => val == null ? 'please select region' : null,
          hint: 'selectregion'.tr,
          items:
              _controller.regionListTo.map((element) => element!.name).toList(),
        ),
      ],
    );
  }

  // Widget _buildFirstPageInter(BuildContext context) {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 5),
  //         child: CustomText(
  //           text: 'Shipping Type',
  //           fontWeight: FontWeight.w400,
  //           size: 13,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       ToggleSwitch(
  //         minWidth: 140,
  //         borderColor: [
  //           primaryColorithOpacity(0.2),
  //           primaryColorithOpacity(0.2)
  //         ],
  //         fontSize: 13,
  //         minHeight: 37,
  //         borderWidth: 1.2,
  //         inactiveBgColor: whiteColor,
  //         initialLabelIndex: 0,
  //         totalSwitches: 2,
  //         activeBgColor: [primaryColor, primaryColorithOpacity(0.5)],
  //         labels: const ['Domestic', 'International'],
  //         onToggle: (index) {},
  //       ),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       CustomFormFiled(
  //         text: 'Country',
  //         onSaved: (val) {},
  //         validator: (val) => val == null ? 'please select Country' : null,
  //         hint: 'Select Country',
  //         items: ['xxxx', 'xxxx'],
  //       ),
  //       CustomFormFiled(
  //         text: 'City',
  //         onSaved: (val) {},
  //         validator: (val) => val == null ? 'please select City' : null,
  //         hint: 'select City',
  //         items: ['xxxx', 'xxxx'],
  //       ),
  //       CustomFormFiled(
  //         text: 'State',
  //         onSaved: (val) {},
  //         validator: (val) => val == null ? 'please select State' : null,
  //         hint: 'select State',
  //         items: ['xxx', 'xxxx'],
  //       ),
  //       CustomFormFiledWithTitle(
  //         keyboardType: TextInputType.number,
  //         text: 'Home Number',
  //         hintText: 'Enter Home Number',
  //         validator: (c) {},
  //       ),
  //       SizedBox(
  //         height: 15,
  //       ),
  //       CustomFormFiledWithTitle(
  //         keyboardType: TextInputType.number,
  //         text: 'Street Number',
  //         hintText: 'Enter Street Number',
  //         validator: (c) {},
  //       ),
  //     ],
  //   );
  // }

  Widget _buildThierdPage(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: CustomText(
            text: 'ShippingType'.tr,
            fontWeight: FontWeight.w400,
            size: 13,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ToggleSwitch(
          minWidth: MediaQuery.of(context).size.width / 2.5,
          borderColor: [
            primaryColor.withOpacity(0.2),
            primaryColor.withOpacity(0.2)
          ],
          fontSize: 13,
          minHeight: 37,
          borderWidth: 1.2,
          inactiveBgColor: whiteColor,
          initialLabelIndex: 0,
          totalSwitches: 2,
          activeBgColor: [primaryColor, primaryColor.withOpacity(0.5)],
          labels: ['Domestic'.tr, 'International'.tr],
          onToggle: (index) {},
        ),
        const SizedBox(
          height: 25,
        ),
        CustomFormFiledWithTitle(
          read: _controller.isLoadingPrice.value ? true : false,
          keyboardType: TextInputType.phone,
          text: 'NewWeight'.tr,
          hintText: 'EnterShipmentWeight'.tr,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/images/kg.png',
              fit: BoxFit.fill,
              height: 5,
              width: 5,
            ),
          ),
          onChanged: (c) {},
          validator: (val) => val!.isEmpty
              ? "please enter shipment weight"
              : val.length > 5
                  ? "you exceeded the maximum weight"
                  : null,
          controller: _controller.wighetController,
        ),
      ],
    );
  }
}

class ComplatedScreen extends StatelessWidget {
  const ComplatedScreen({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalculateController>(builder: (_model) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 0.2,
                      color: primaryColor.withOpacity(0.2))
                ]),
            child: Column(
              children: [
                _myListtile('assets/images/in.png', 'ShippingFrom'.tr,
                    ' ${_model.muhafazaNameFrom.text},  ${_model.cWFrom.text},  ${_model.cRFrom.text}',
                    () {
                  _model.first();
                }),
                _myListtile('assets/images/out.png', 'ShippingTo'.tr,
                    ' ${_model.muhafazaNameTo.text}, ${_model.cWTo.text}, ${_model.cRTO.text}',
                    () {
                  _model.second();
                  // _model.update();
                }),
                _myListtile('assets/images/kg.png', 'Weight'.tr,
                    '${_model.wighetController.text} KG', () {
                  _model.thired();
                  // _model.update();
                }),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: textRedColor,
                  size: 17,
                ),
                SizedBox(width: 5),
                CustomText(
                  text: 'RateIsbased'.tr,
                  color: textRedColor,
                  size: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 170,
            height: 150,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 0.2,
                      color: primaryColor.withOpacity(0.2))
                ]),
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/trauk.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: Get.put(HelperController()).getCurrencyInFormat(text),
                  fontWeight: FontWeight.bold,
                  size: 16,
                  color: primaryColor,
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: '4-5 ' + 'Days'.tr,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  size: 14,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text: 'WithDalilee'.tr,
            fontWeight: FontWeight.w500,
            size: 12,
            color: primaryColor,
            alignment: Alignment.center,
          ),
          const Spacer(),
          SizedBox(
            width: 200,
            child: CustomButtom(text: 'Proceed'.tr, onPressed: () {}),
          ),
          const Spacer(),
        ],
      );
    });
  }

  Widget _myListtile(
      String image, String title, String subtitle, void Function()? onTap) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 20,
        height: 20,
        color: Colors.grey.shade800,
      ),
      title: CustomText(
        text: title,
        color: Colors.black,
        size: 12,
        fontWeight: FontWeight.bold,
      ),
      subtitle: CustomText(
        text: subtitle,
        size: 9,
      ),
      trailing: InkWell(onTap: onTap, child: _changeWithIcon()),
    );
  }

  Widget _changeWithIcon() {
    return SizedBox(
      width: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            text: 'Change'.tr,
            alignment: Alignment.centerLeft,
            color: textRedColor,
            size: 10,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.border_color_outlined,
            color: textRedColor,
            size: 15,
          ),
        ],
      ),
    );
  }
}
