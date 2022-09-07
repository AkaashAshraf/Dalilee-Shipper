import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Alert exportModal(BuildContext context, String type) {
  return modal(
    context,
    Column(
      children: [
        GetX<DownloadController>(builder: (controller) {
          return Stack(
            children: [
              Column(children: [
                Text(
                  type == 'pdf' ? "Export PDF" : "Export Excell",
                  style: TextStyle(color: primaryColor),
                ),
                SizedBox(height: 10),
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: DottedLine(
                      dashColor: primaryColor,
                    )),
                SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.range,
                      maxDate: DateTime.now(),
                      minDate: new DateTime(DateTime.now().year,
                          DateTime.now().month - 3, DateTime.now().day),
                      onSelectionChanged: (val) {
                        // print(val.value.startDate);
                        try {
                          if (val.value != Null)
                            controller.startDate.value =
                                DateFormat('yyyy-MM-dd')
                                    .format(val.value.startDate);
                          if (val.value != Null)
                            controller.endDate.value = DateFormat('yyyy-MM-dd')
                                .format(val.value.endDate);
                        } catch (e) {}
                        // print('start date:' + controller.startDate.value);
                        // print('end date:' + controller.endDate.value);
                      },
                    )),
                DropdownButton(
                  hint: controller.selectedOrderType.value.key == ""
                      ? Text('Select Type')
                      : Text(
                          controller.selectedOrderType.value.label,
                          style: TextStyle(color: Colors.blue),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: controller.orderTypes.map(
                    (val) {
                      return DropdownMenuItem<OrderTypes>(
                        value: val,
                        child: Text(val.label),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    controller.selectedOrderType.value = val as OrderTypes;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: controller.isEmail.value,
                      onChanged: (value) {
                        controller.isEmail.value = value == true ? true : false;
                      },
                    ), //Che

                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Send file to email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15)),
                        ]),
                      ),
                    )
                  ],
                ),
                CustomButtom(
                  backgroundColor: controller.selectedOrderType.value.key == ""
                      ? Colors.grey
                      : controller.startDate.value == ""
                          ? Colors.grey
                          : controller.isDownloading.value
                              ? Colors.white
                              : primaryColor,
                  text: 'Export',
                  onPressed: controller.selectedOrderType.value.key == ""
                      ? null
                      : controller.startDate.value == ""
                          ? null
                          : controller.isDownloading.value
                              ? null
                              : () async {
                                  controller.startDownloadingList(type);
                                },
                ),
              ]),
              if (controller.isDownloading.value)
                Positioned.fill(child: const WaiteImage()),
            ],
          );
        })
      ],
    ),
  );
}
