import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/enquiry_view_model.dart';
import 'package:dalile_customer/view/menu/finances/finance_enquiry_details.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FinanceEnquiry extends StatelessWidget {
  FinanceEnquiry({Key? key}) : super(key: key);
  final EnquiryFinanceController controller =
      Get.put(EnquiryFinanceController(), permanent: true);

  final now = DateTime.now();
  final berlinWallFell = DateTime.utc(1989, 11, 9);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: primaryColor,
          appBar: _buildAppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              controller.subcatListId.clear();
              controller.subcatListName.clear();
              controller.catListId.clear();
              controller.catListName.clear();
              controller.subcatListData.clear();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  content: Builder(builder: (context) {
                    return const _AlrtAddEnquryBody();
                  }),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: controller.isLoading.value
                ? const WaiteImage()
                : controller.enquriyData.isNotEmpty
                    ? Center(
                        child: Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                controller.fetchEnquiryFinanceData();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CustomText(
                                    text: 'Updated data ',
                                    color: Colors.grey,
                                    alignment: Alignment.center,
                                    size: 10,
                                  ),
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                                child: ListView.separated(
                              separatorBuilder: (context, i) =>
                                  const SizedBox(height: 10),
                              itemCount: controller.enquriyData.length,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 5),
                              itemBuilder: (context, i) {
                                final _date = DateFormat('dd/MM/yy').format(
                                    controller.enquriyData[i].updatedAt!);

                                return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            color: Colors.grey.shade300,
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text:
                                                  'Inquiry No : ${controller.enquriyData[i].inquiryNo}',
                                              color: primaryColor,
                                              size: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    () => FinanceEnquiryDetails(
                                                          isOpen: controller
                                                              .enquriyData[i]
                                                              .updateStatus
                                                              .toString(),
                                                          createAt: _date,
                                                        ),
                                                    transition:
                                                        Transition.cupertino,
                                                    duration: const Duration(
                                                        milliseconds: 700));
                                              },
                                              child: Image.asset(
                                                'assets/images/visbilty.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 3,
                                          indent: 0,
                                          endIndent: 0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: CustomText(
                                                text:
                                                    'Created At : $_date',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const CustomText(
                                                  text: 'Status :',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: 30,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        controller.enquriyData[i]
                                                                    .updateStatus ==
                                                                "Closed"
                                                            ? primaryColor
                                                            : textRedColor,
                                                        controller
                                                                    .enquriyData[
                                                                        i]
                                                                    .updateStatus ==
                                                                "Closed"
                                                            ? primaryColor
                                                                .withOpacity(
                                                                    0.5)
                                                            : textRedColor
                                                                .withOpacity(
                                                                    0.5)
                                                      ],
                                                      stops: const [0.3, 2],
                                                      end: Alignment
                                                          .bottomCenter,
                                                      begin:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                  //alignment: Alignment.center,
                                                  child: CustomText(
                                                    text: controller
                                                                .enquriyData[i]
                                                                .updateStatus ==
                                                            "Closed"
                                                        ? "Closed"
                                                        : 'Opened',
                                                    color: whiteColor,
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ));
                              },
                            )),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const EmptyState(
                            label: 'No Data ',
                          ),
                          MaterialButton(
                            onPressed: () {
                              controller.fetchEnquiryFinanceData();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CustomText(
                                  text: 'Updated data ',
                                  color: Colors.grey,
                                  alignment: Alignment.center,
                                  size: 12,
                                ),
                                Icon(
                                  Icons.refresh,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: const CustomText(
          text: 'FINANCE INQUIRY',
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w600,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}

class _AlrtAddEnquryBody extends StatelessWidget {
  const _AlrtAddEnquryBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnquiryFinanceController>(builder: (_data) {
      return SizedBox(
        height: 520,
        child: Form(
          key: _data.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Request Inquiry',
                      alignment: Alignment.topLeft,
                      color: primaryColor,
                      size: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
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
                  hint: 'category Type',
                  // select: controller.bankName.text,
                  text: 'Select category Type',
                  onSaved: (val) {
                    for (int i = 0; i < _data.catListData.length; i++) {
                      if (_data.catListData[i].name == val) {
                        _data.catListId.text =
                            _data.catListData[i].id.toString();
                        _data.catListName.text =
                            _data.catListData[i].name.toString();

                        print(_data.catListId.text.toString());
                        if (_data.catListId.text.isEmpty) return null;
                      }
                    }
                    _data.subcatListId.clear();
                    _data.subcatListName.clear();
                    _data.subcatListData.clear();
                    _data.fetchSubCatListData();
                    print("----->" + _data.subcatListName.text);
                    _data.update();
                    return null;
                  },
                  validator: (val) => val == null ? 'select category' : null,
                  items: List.generate(_data.catListData.length,
                      (index) => _data.catListData[index].name),
                ),
                CustomFormFiled(
                  select: _data.subcatListName.text.isEmpty
                      ? null
                      : _data.subcatListName.text,
                  items: List.generate(_data.subcatListData.length,
                      (index) => _data.subcatListData[index].name),

                  hint: 'sub category Type',
                  // select: controller.bankName.text,
                  text: 'Select sub category',
                  onSaved: (val) {
                    for (int i = 0; i < _data.subcatListData.length; i++) {
                      if (_data.subcatListData[i].name == val) {
                        _data.subcatListId.text =
                            _data.subcatListData[i].id.toString();
                        _data.subcatListName.text =
                            _data.subcatListData[i].name.toString();

                        print(_data.catListId.text.toString());
                      }
                    }
                    _data.update();
                    return null;
                  },
                  validator: (val) =>
                      val == null ? 'select sub category' : null,
                ),
                CustomFormFiledAreaWithTitle(
                    validator: (val) =>
                        val!.isEmpty ? "please explain your Inquiry" : null,
                    onChanged: (z) {
                      _data.decConteroller = z;
                    },
                    text: 'Explain your Inquiry',
                    hintText: 'please explain your Inquiry here'),
                const SizedBox(
                  height: 70,
                ),
                _data.isAddwiting
                    ? WaiteImage()
                    : CustomButtom(
                        text: 'Create Inquiry',
                        onPressed: () {
                          _data.checkval(context);
                        },
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
