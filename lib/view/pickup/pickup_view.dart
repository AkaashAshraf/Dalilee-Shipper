import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/pickup_api.dart';
import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/view/pickup/all_pickup.dart';
import 'package:dalile_customer/view/pickup/location_view.dart';
import 'package:dalile_customer/view/pickup/tody_pickup.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PickupView extends StatelessWidget {
  PickupView({Key? key}) : super(key: key);

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: 'ENORAR'.tr == "en"
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.startFloat,
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          openCloseDial: isDialOpen,
          backgroundColor: primaryColor,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: false,
          // curve: Curves.bounceIn,

          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.rotate_left,
                  color: primaryColor,
                  size: 30,
                ),
                label: 'DailyPickup'.tr,
                onTap: () {
                  // Navigator.of(context).push(showPicker(
                  //   context: context,
                  //   value: TimeOfDay(hour: 12, minute: 40),
                  //   onChange: (value) {},
                  // ));
                  Get.put(PickupController()).fetchAutoPickupStatus();

                  modal(
                      context,
                      Column(
                        children: [
                          GetX<PickupController>(builder: (controller) {
                            return Stack(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "AutoCreatePickup".tr,
                                      style: TextStyle(
                                          fontSize: 20, color: primaryColor),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Text(
                                        "Note".tr,
                                        style: TextStyle(fontSize: 18),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "DailyPickupNote".tr,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "PickupTime".tr,
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: GestureDetector(
                                        onTap: (() async {
                                          var time = await showTimePicker(
                                            initialTime: TimeOfDay.fromDateTime(
                                                new DateTime(
                                                    2022,
                                                    1,
                                                    1,
                                                    int.tryParse(controller
                                                            .pickupTime
                                                            .split(":")[0]) ??
                                                        8,
                                                    int.tryParse(controller
                                                            .pickupTime
                                                            .split(":")[1]) ??
                                                        0)),
                                            context: context,
                                          );
                                          controller.pickupTime.value =
                                              "${time!.hour < 10 ? "0" : time.hour == 0 ? "00" : ""}${time.hour.toString()}:${time.minute < 10 ? "0" : ""}${time.minute.toString()}";
                                          // print(time);
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    5.0) //                 <--- border radius here
                                                ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              controller.pickupTime.value,
                                              style: TextStyle(fontSize: 16),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          // fillColor: MaterialStateProperty.resolveWith(primaryColor),
                                          value: controller
                                              .isAutoDailyPickup.value,
                                          onChanged: (bool? value) {
                                            controller.isAutoDailyPickup.value =
                                                value ?? false;
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "DailyPickup".tr,
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: controller
                                                  .autoPickupLoading.value ==
                                              true
                                          ? WaiteImage()
                                          : ElevatedButton(
                                              onPressed: () async {
                                                if (controller
                                                    .isAutoDailyPickup.value) {
                                                  Navigator.pop(context);
                                                  Get.to(
                                                      () => GMap(
                                                            isDailyPickup: true,
                                                          ),
                                                      transition:
                                                          Transition.downToUp,
                                                      duration: Duration(
                                                          milliseconds: 500));
                                                } else {
                                                  try {
                                                    controller.autoPickupLoading
                                                        .value = true;
                                                    await PickupApi.fetchlocationData(
                                                            "", "",
                                                            url:
                                                                "/pickup/create-pickup-auto",
                                                            isAutoDailyPickup:
                                                                true,
                                                            time: controller
                                                                .pickupTime
                                                                .value,
                                                            context: context)
                                                        .then((value) {
                                                      if (value) {
                                                        // Get.to(PickupView());
                                                        Navigator.pop(context);
                                                        Get.snackbar(
                                                            'Successful',
                                                            "${PickupApi.success}",
                                                            colorText:
                                                                whiteColor,
                                                            backgroundColor:
                                                                primaryColor
                                                                    .withOpacity(
                                                                        0.7));
                                                      } else {
                                                        Get.snackbar('Failed',
                                                            "${PickupApi.mass}",
                                                            colorText:
                                                                whiteColor,
                                                            backgroundColor:
                                                                Colors
                                                                    .red[800]);
                                                      }
                                                    });
                                                  } finally {
                                                    controller
                                                        .autoPickupLoading(
                                                            false);
                                                  }
                                                }
                                              },
                                              child: Text(
                                                "Proceed".tr,
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 14),
                                              )),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      )).show();

                  //   Get.to(() => GMap(),
                  //       transition: Transition.downToUp,
                  //       duration: Duration(milliseconds: 500));
                }),
            // SpeedDialChild(
            //     //   backgroundColor: primaryColor,
            //     child: Icon(
            //       Icons.qr_code,
            //       color: primaryColor,
            //     ),
            //     label: 'PickbyQRcode'.tr,
            //     onTap: () {
            //       Get.put(QrCodeController()).scanQR(context);
            //     }),
            // SpeedDialChild(
            //     //   backgroundColor: primaryColor,
            //     child: CustomText(
            //       text: '///',
            //       alignment: Alignment.center,
            //       color: primaryColor,
            //       fontWeight: FontWeight.bold,
            //       size: 16,
            //     ),
            //     label: 'Pick by what3words',
            //     onTap: () {
            //       Get.dialog(What3WordsView(),
            //           barrierColor: Colors.transparent);
            //     }),
            SpeedDialChild(
                child: Icon(
                  Icons.location_on_outlined,
                  color: primaryColor,
                  size: 30,
                ),
                label: 'PickbyLocation'.tr,
                onTap: () {
                  Get.to(
                      () => GMap(
                            isDailyPickup: false,
                          ),
                      transition: Transition.downToUp,
                      duration: Duration(milliseconds: 500));
                }),
          ]),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text("PICKUP".tr),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, headerSliverBuilder) => [
            SliverAppBar(
              toolbarHeight: 10,
              elevation: 0,
              backgroundColor: whiteColor,
              bottom: _tabBarIndicatorShape(),
            ),
          ],
          body: TabBarView(
            physics: const CustomTabBarViewScrollPhysics(),
            children: [
              TodayListPickup(),
              AllListPickup(),
              // const RequestPickup()
            ],
          ),
        ),
      ),
    );
  }

  _tabBarIndicatorShape() => TabBar(
        physics: const CustomTabBarViewScrollPhysics(),
        // isScrollable: true,
        indicatorWeight: 0.0,
        tabs: _tabTwoParameters(),
        labelColor: whiteColor,

        padding: const EdgeInsets.all(5),
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        unselectedLabelColor: primaryColor,
        unselectedLabelStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(30)),
          gradient: SweepGradient(
            colors: [
              primaryColor.withOpacity(0.75),
              primaryColor.withOpacity(0.85),
              primaryColor.withOpacity(0.9),
              primaryColor,
              primaryColor,
              primaryColor.withOpacity(0.9),
              primaryColor.withOpacity(0.85),
              primaryColor.withOpacity(0.75),
            ],
          ),
        ),
      );
  // var controller = Get.put(PickupController());
  List<Widget> _tabTwoParameters() => [
        Tab(
          text: "Today".tr,
        ),
        Tab(
          text: "All".tr,
        ),
        // Tab(
        //   text: "Request Pickup",
        // ),
      ];
}

class CustomTabBarViewScrollPhysics extends ScrollPhysics {
  const CustomTabBarViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomTabBarViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomTabBarViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 100,
        stiffness: 10,
        damping: 0.4,
      );
}
