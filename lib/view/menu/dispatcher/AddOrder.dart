import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/DispatcherController.dart';
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
                  controller.addList.add(new Order());
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
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: GetX<DispatcherController>(builder: (controller) {
          return Container(
            padding: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      itemCount: controller.addList.length,
                      itemBuilder: (context, i) => AddOrderCard(
                        controller: controller,
                        order: controller.addList[i],
                        onCancelClick: () {
                          // print(controller.addList[i].name);
                          // final List<Order> tempArr = [];
                          // Order? deletedIndex;
                          // for (var index = 0;
                          //     index < controller.addList.length;
                          //     index++) {
                          //   if (index != controller.addList.length - 1)
                          //     tempArr.add(controller.addList[index]);
                          //   else
                          //     deletedIndex = controller.addList[index];
                          // }
                          // // print(deletedIndex?.name);

                          // controller.addList.value = tempArr;
                          controller.addList
                              .removeAt(controller.addList.length - 1);
                          if (controller.addList.length == 0) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                          // Navigator.pop(context);
                        },
                        index: i,
                      ),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                    ),
                  ),
                ),
                if (controller.loading.value == false)
                  Positioned(
                    right: 80,
                    bottom: 30,
                    left: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomButtom(
                        text: 'Add'.tr,
                        onPressed: () async {
                          final isValid = await _checkValidtion();
                          if (isValid) controller.handleAddOrders(context);
                          // print(checkValidation);
                          // Get.back();
                        },
                      ),
                    ),
                  ),
                if (controller.loading.value == true)
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.center, child: WaiteImage())),
              ],
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
