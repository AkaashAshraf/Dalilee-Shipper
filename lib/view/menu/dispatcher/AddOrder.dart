import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/model/Dispatcher/Orders.dart';
import 'package:dalile_customer/view/menu/dispatcher/AddOrderCard.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrder extends StatefulWidget {
  AddOrder({
    Key? key,
  }) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrder();
}

class _AddOrder extends State<AddOrder> {
  final _controller = Get.put(DispatcherController());

  @override
  void initState() {
    super.initState();
    _controller.addList.value = [new Order()];
  }

  @override
  void dispose() {
    super.dispose();
  }

  _checkValidtion() async {
    bool isValid = true;
    Order order;
    List<Order> tempList = [];
    for (int i = 0; i < _controller.addList.length; i++) {
      order = _controller.addList[i];
      order.checkValidtion = true;
      tempList.add(order);
      if (order.phone == "" ||
          order.name == "" ||
          order.willayaID == 0 ||
          order.regionID == 0) isValid = false;
    }
    _controller.addList.value = tempList;
    return isValid;
  }

  String subTitle = '';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DispatcherController());
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: _buildAppBar(),
        floatingActionButton: controller.loading.value == false
            ? FloatingActionButton(
                onPressed: () {
                  controller.addList
                      .add(new Order(id: controller.addList.length + 1));
                  // print(controller.addList);
                },
                child: controller.loading.value == false
                    ? Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      )
                    : null,
                backgroundColor: primaryColor,
                elevation: 8,
                splashColor: Colors.grey,
              ).paddingOnly(bottom: 80)
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: GetX<DispatcherController>(builder: (controller) {
          return Container(
            padding: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.75,
                    // width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      itemCount: controller.addList.length,
                      itemBuilder: (context, i) => AddOrderCard(
                        controller: controller,
                        order: controller.addList[i],
                        onCancelClick: () {
                          controller.addList
                              .removeAt(controller.addList.length - 1);

                          // Navigator.pop(context);
                        },
                        index: i,
                      ),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                    ),
                  ),
                  if (controller.loading.value == false &&
                      controller.addList.isNotEmpty)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButtom(
                        text: 'Add'.tr,
                        onPressed: () async {
                          final isValid = await _checkValidtion();
                          if (isValid) {
                            await controller.handleAddOrders(context);
                          }
                          // print(checkValidation);
                          // Get.back();
                        },
                      ),
                    ).paddingOnly(bottom: 30, left: 30, right: 30),
                  if (controller.loading.value == true) WaiteImage(),
                ],
              ),
            ),
          );
        }));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      title: CustomText(
          text: 'AddOrder'.tr,
          color: whiteColor,
          size: 18,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center),
      centerTitle: true,
    );
  }
}
