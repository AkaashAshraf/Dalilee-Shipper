import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/finance_controller.dart';
import 'package:dalile_customer/view/menu/finances/closeed.dart';
import 'package:dalile_customer/view/menu/finances/open.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceView extends GetWidget<FinanceController> {
  FinanceView({Key? key}) : super(key: key);
  final FinanceController _controll =
      Get.put(FinanceController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'Finance'.tr.toUpperCase(),
            color: primaryColor,
            alignment: Alignment.center,
            size: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, headerSliverBuilder) => [
            SliverAppBar(
              toolbarHeight: 8,
              elevation: 0,
              backgroundColor: dashboardTabsBackgroudColor,
              bottom: _tabBarIndicatorShape(),
            ),
          ],
          body: TabBarView(
            physics: const CustomTabBarViewScrollPhysics(),
            children: [
              OpendedView(c: _controll),
              ColusedView(c: _controll),
            ],
          ),
        ),
      ),
    );
  }

  _tabBarIndicatorShape() => TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
        labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        unselectedLabelColor: primaryColor,
        physics: const CustomTabBarViewScrollPhysics(),
        indicatorWeight: 0.0,
        tabs: [
          Tab(
            text: 'Opened'.tr,
          ),
          Tab(
            text: 'Closed'.tr,
          ),
        ],
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(25)),
          gradient: SweepGradient(
            colors: [
              primaryColor,
              primaryColor,
            ],
          ),
        ),
        onTap: (value) {
          print('$value');
        },
      );
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
