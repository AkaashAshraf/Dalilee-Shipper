import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/ticket_details_controller.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class ComplainDetails extends StatelessWidget {
  ComplainDetails({Key? key, required this.id}) : super(key: key);
  final String id;
  final TicketDetailsController _controller =
      Get.put(TicketDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: CustomText(
          text: 'Ticket Details',
          color: whiteColor,
          size: 20,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: Material(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: MaterialButton(
            onPressed: () {
              Get.bottomSheet(_ReplyBody(),
                  backgroundColor: whiteColor,
                  enableDrag: false,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.reply_outlined,
                  color: whiteColor,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomText(
                  text: 'Reply',
                  color: whiteColor,
                  size: 18,
                  fontWeight: FontWeight.w500,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading1.value) {
          return WaiteImage();
        }

        if (_controller.ticketDetailsData.value.comments!.isNotEmpty) {
          final _date = DateFormat('dd/MM/yy')
              .format(_controller.ticketDetailsData.value.updatedAt!);
          return Stack(children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                  ),

                  //  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.18,
                  ),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5)
                      ]),
                  child: Column(
                    children: [
                      _buildRowTob("Ticket No",
                          "${_controller.ticketDetailsData.value.ticketId ?? 0}"),
                      _buildRowTob("Subject",
                          "${_controller.ticketDetailsData.value.subject ?? 0}"),
                      _buildRowTob("Description",
                          "${_controller.ticketDetailsData.value.description ?? 0}"),
                      _buildRowTob("Attachment", "N/A"),
                      _buildRowTob("Created at", "$_date"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5)
                        ]),
                    child: Scrollbar(
                      thumbVisibility: true,
                      interactive: true,
                      thickness: 8,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: ListView.builder(
                            itemCount: _controller
                                .ticketDetailsData.value.comments!.length,
                            itemBuilder: (_, i) {
                              return Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.expand_more,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          text: _controller
                                                  .ticketDetailsData
                                                  .value
                                                  .comments![i]
                                                  .user!
                                                  .name ??
                                              "",
                                          fontWeight: FontWeight.bold,
                                          size: 16,
                                          color: text1Color,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        CustomText(
                                          text: _controller.ticketDetailsData
                                              .value.comments![i].createdAt
                                              .toString(),
                                          fontWeight: FontWeight.w500,
                                          size: 11,
                                          color: Colors.grey.shade500,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomText(
                                      text: _controller.ticketDetailsData.value
                                          .comments![i].body,
                                      fontWeight: FontWeight.w500,
                                      size: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomText(
                                      text: 'Message Attachments :',
                                      fontWeight: FontWeight.w500,
                                      size: 16,
                                      color: text1Color,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    for (int x = 0;
                                        x <
                                            _controller.ticketDetailsData.value
                                                .comments![i].files!.length;
                                        x++)
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.description_outlined,
                                            color: Colors.grey.shade400,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 200),
                                            child: Text(
                                              _controller.ticketDetailsData
                                                  .value.comments![i].files[x]
                                                  .split('/')
                                                  .last
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              print("------------");
                                              final url =
                                                  "$domain/${_controller.ticketDetailsData.value.comments![i].files[x]}";
                                              await launch(url);
                                            },
                                            child: CustomText(
                                              text: 'Download',
                                              fontWeight: FontWeight.w500,
                                              size: 14,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]);
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EmptyState(
                label: 'no Data ',
              ),
              MaterialButton(
                onPressed: () {
                  _controller.fetchTicketDatilsData(id.toString());
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
          );
        }
      }),
    );
  }

  Widget _buildRowTob(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        children: [
          CustomText(
            text: '$title :',
            size: 15,
            color: text1Color,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            text: '  $subtitle',
            size: 14,
            color: text1Color,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

class _ReplyBody extends StatelessWidget {
  _ReplyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, right: 15, left: 15),
      child: SingleChildScrollView(
        child: GetBuilder<TicketDetailsController>(
          builder: (_controller) => Column(children: [
            CustomText(
              text: 'Reply',
              color: text1Color,
              size: 18,
              fontWeight: FontWeight.bold,
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              // width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                autofocus: false,
                controller: _controller.bodytext,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                  fontSize: 12,
                ),
                maxLines: 15,
                minLines: 12,
                maxLength: 3000,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "writing ...",
                  labelStyle: const TextStyle(color: text1Color, fontSize: 12),
                  hintStyle: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.3)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.2)),
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
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _controller.selectImage();
              },
              child: CustomText(
                text: 'Attach File',
                color: primaryColor,
                size: 18,
                fontWeight: FontWeight.bold,
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            for (int i = 0; i < _controller.itemsImages.length; i++)
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: Colors.grey.shade400,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: _controller.itemsImages[i].name.toString(),
                    fontWeight: FontWeight.w500,
                    size: 12,
                    color: Colors.grey.shade500,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.itemsImages.removeAt(i);
                      _controller.update();
                    },
                    child: Icon(
                      Icons.highlight_off_outlined,
                      color: textRedColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: primaryColor),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: "Cancel",
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                _controller.isLoadingCreate
                    ? WaiteImage()
                    : TextButton(
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: CustomText(
                          text: "Reply",
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                        ),
                        onPressed: () {
                          _controller.fetchCreateComplinData(context);
                        }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
