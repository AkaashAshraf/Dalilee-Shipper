import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/model/Dispatcher/components/location_picker_add_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPickerInputForAddOrder extends StatefulWidget {
  const LocationPickerInputForAddOrder({
    Key? key,
    required this.title,
    this.validate = false,
    required this.index,
  }) : super(key: key);

  final String title;
  final int index;

  final bool validate;
  @override
  State<LocationPickerInputForAddOrder> createState() =>
      _LocationPickerInputForAddOrderState();
}

class _LocationPickerInputForAddOrderState
    extends State<LocationPickerInputForAddOrder> {
  bool isObscure_ = true;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GetX<DispatcherController>(builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(LocationPickerAddOrder(
              index: widget.index,
            ));
          },
          child: Column(
            children: [
              Container(
                // height: height * 0.1,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.validate &&
                              controller.addList[widget.index].latitude.isEmpty
                          ? Colors.red
                          : Colors.grey,
                      width: 0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          style: const TextStyle(
                              color: text1Color,
                              fontFamily: "primary",
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                          width: width,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: screenHeight(context) * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller
                                    .addList[widget.index].locationName),
                                Icon(
                                  Icons.location_on_sharp,
                                  color: widget.validate &&
                                          controller.addList[widget.index]
                                              .latitude.isEmpty
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ).paddingOnly(top: 5, bottom: 20),
              ),
              SizedBox(
                width: width,
                child: Text(
                  (widget.validate &&
                          controller.addList[widget.index].latitude.isEmpty)
                      ? "required"
                      : "",
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.red, fontFamily: "primary", fontSize: 15),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
