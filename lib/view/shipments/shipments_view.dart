import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/shipment_view_model.dart';
import 'package:dalile_customer/view/shipments/in_view.dart';
import 'package:dalile_customer/view/shipments/out_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';

class ShipmentView extends StatelessWidget {
  const ShipmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text("SHIPMENTS"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetBuilder<ShipmentViewModel>(
          init: ShipmentViewModel(),
          builder: (data) => data.isSDown
              ? InkWell(
                  onTap: () {
                    data.controller.animateTo(
                      data.controller.position.minScrollExtent,
                      duration: Duration(milliseconds: 150),
                      curve: Curves.easeInCirc,
                    );

                    print(data.isSDown.toString());
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 5,
                              blurRadius: 5)
                        ]),
                    child: Icon(
                      Icons.expand_less,
                      size: 35,
                      color: primaryColor,
                    ),
                  ),
                )
              : SizedBox()),
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
              OutShipments(),
              InShipments(),
            ],
          ),
        ),
      ),
    );
  }

  _tabBarIndicatorShape() => TabBar(
        labelPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        unselectedLabelColor: primaryColor,
        physics: const CustomTabBarViewScrollPhysics(),
        indicatorWeight: 0.0,
        tabs: _tabTwoParameters(),
        padding: const EdgeInsets.all(5),
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(25)),
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
        onTap: (value) {
          print('$value');
        },
      );

  List<Widget> _tabTwoParameters() => const [
        Tab(
          height: 20,
          text: 'OUT',
        ),
        Tab(
          height: 20,
          text: 'IN',
        ),
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
