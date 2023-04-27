import 'package:dalile_customer/components/popups/exportModal.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/dashbord_controller.dart';
import 'package:dalile_customer/controllers/download_controller.dart';
import 'package:dalile_customer/controllers/notification_controller.dart';
import 'package:dalile_customer/view/home/finaince_dashboard.dart';
import 'package:dalile_customer/view/home/main_dash.dart';
import 'package:dalile_customer/view/home/notifications/notifications_list.dart';
import 'package:dalile_customer/view/home/search/search_screen.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put(DashbordController());
  final downloadController = Get.put(DownloadController());
  final notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
          leading: GestureDetector(
            onTap: () {
              Get.to(SearchScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(NotificationList());
              },
              child: GetX<NotificationController>(builder: (controller) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        new Icon(Icons.notifications, size: 25),
                        new Positioned(
                          right: 0,
                          child: controller.unreadNotification.value == 0
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 13,
                                    minHeight: 13,
                                  ),
                                  child: Center(
                                    child: new Text(
                                      controller.unreadNotification.value
                                          .toString(),
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
          title: CustomText(
            text: 'DASHBOARD'.tr,
            color: whiteColor,
            size: 18,
            alignment: Alignment.center,
          ),
          centerTitle: true,
        ),
        floatingActionButtonLocation: 'ENORAR'.tr == "en"
            ? FloatingActionButtonLocation.endFloat
            : FloatingActionButtonLocation.startFloat,
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            elevation: 5,
            backgroundColor: primaryColor,
            overlayOpacity: 0.1,
            direction: SpeedDialDirection.up,
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: primaryColor,
                ),
                label: 'ExportPdf'.tr,
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
                label: 'ExportExcell'.tr,
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
  List<Widget> _tabTwoParameters() => [
        Tab(
          text: "MainDashboard".tr,
        ),
        Tab(
          text: "FinancesDashboard".tr,
        ),
        // Tab(
        //   text: "Request Pickup",
        // ),
      ];
}
