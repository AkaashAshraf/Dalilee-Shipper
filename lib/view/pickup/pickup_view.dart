import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/qrcode_model_view.dart';
import 'package:dalile_customer/view/pickup/all_pickup.dart';
import 'package:dalile_customer/view/pickup/location_view.dart';
import 'package:dalile_customer/view/pickup/tody_pickup.dart';
import 'package:dalile_customer/view/pickup/what3words_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PickupView extends StatelessWidget {
  PickupView({Key? key}) : super(key: key);

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
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
//backgroundColor: primaryColor,
                child: Icon(
                  Icons.location_on_outlined,
                  color: primaryColor,
                  size: 30,
                ),
                label: 'Pick by Location',
                onTap: () {
                  Get.to(() => GMap(),
                      transition: Transition.downToUp,
                      duration: Duration(milliseconds: 500));
                }),
            SpeedDialChild(
                //   backgroundColor: primaryColor,
                child: Icon(
                  Icons.qr_code,
                  color: primaryColor,
                ),
                label: 'Pick by QRcode',
                onTap: () {
                  Get.put(QrCodeController()).scanQR(context);
                }),
            SpeedDialChild(
                //   backgroundColor: primaryColor,
                child: CustomText(
                  text: '///',
                  alignment: Alignment.center,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
                label: 'Pick by what3words',
                onTap: () {
                  Get.dialog(What3WordsView(),
                      barrierColor: Colors.transparent);
                }),
          ]),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text("PICKUP"),
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
              side: const BorderSide(color: primaryColor),
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
          text: "Today",
        ),
        Tab(
          text: "All   ",
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
