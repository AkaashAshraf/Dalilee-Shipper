import 'package:dalile_customer/components/popups/exportModal.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/dashbordController.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/view/home/finaince_dashboard.dart';
import 'package:dalile_customer/view/home/main_dash.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put(DashbordController());
  final downloadController = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
          title: CustomText(
            text: '14'.tr,
            color: whiteColor,
            size: 18,
            alignment: Alignment.center,
          ),
          centerTitle: true,
        ),
        floatingActionButton: SpeedDial(
          
            animatedIcon: AnimatedIcons.menu_close,
            elevation: 8,
            backgroundColor: primaryColor,
            overlayOpacity: 0.1,
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: primaryColor,
                ),
                label: '15'.tr,
                labelStyle: TextStyle(color: primaryColor),
                onTap: () {
                  downloadController.selectedOrderType.value =
                      OrderTypes("", "");

                  exportModal(context, 'pdf').show();
                },
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.table_rows_outlined,
                  color: primaryColor,
                ),
                label: '16'.tr,
                labelStyle: TextStyle(color: primaryColor),
                onTap: () {
                  downloadController.selectedOrderType.value =
                      OrderTypes("", "");

                  exportModal(context, 'csv').show();
                },
              ),
            ]), //
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
              children: [
                MainDash(
                  controller: controller,
                ),
                FinanceDash(controller: controller)
                // const RequestPickup()
              ],
            ),
          ),
        ));
  }

  _tabBarIndicatorShape() => TabBar(
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
  List<Widget> _tabTwoParameters() => [
        Tab(
          text: "17".tr,
        ),
        Tab(
          text: "18".tr,
        ),
        // Tab(
        //   text: "Request Pickup",
        // ),
      ];
}
