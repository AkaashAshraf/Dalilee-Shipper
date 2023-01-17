import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/branch_view_model.dart';
import 'package:dalile_customer/view/offices_view.dart/map.dart';
import 'package:dalile_customer/view/offices_view.dart/offices_list_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficesView extends StatelessWidget {
  OfficesView({Key? key}) : super(key: key);
  final BranchController _model = Get.put(BranchController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: CustomText(
            text: 'BRANCHES'.tr,
            color: whiteColor,
            alignment: Alignment.center,
            size: 18,
            fontWeight: FontWeight.w400,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: DefaultTabController(
          animationDuration: Duration(milliseconds: 1700),
          length: 2,
          child: GetBuilder<BranchController>(
              init: BranchController(),
              builder: (_data) {
                return NestedScrollView(
                  headerSliverBuilder: (context, headerSliverBuilder) => [
                    _data.isMapOpen == false
                        ? SliverAppBar(
                            toolbarHeight: 10,
                            elevation: 0,
                            backgroundColor: whiteColor,
                            bottom: _tabBarIndicatorShape(),
                          )
                        : SliverAppBar(
                            elevation: 0,
                            backgroundColor: whiteColor,
                            title: WaiteImage(),
                            // bottom: _tabBarIndicatorShape(),
                          ),
                  ],
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      OficesListView(
                        controller: _model,
                      ),
                      MapsOffices(
                        model: _model,
                      ),
                    ],
                  ),
                );
              }),
        ));
  }

  _tabBarIndicatorShape() => TabBar(
        physics: NeverScrollableScrollPhysics(),
        labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        indicatorSize: TabBarIndicatorSize.tab,
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
        onTap: (x) {
          _model.duringMap();
        },
      );

  List<Widget> _tabTwoParameters() => [
        Tab(
          height: 20,
          text: 'ListView'.tr,
        ),
        Tab(
          height: 20,
          text: 'MapView'.tr,
        ),
      ];
}
