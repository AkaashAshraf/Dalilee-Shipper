import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/complain_view_model.dart';
import 'package:dalile_customer/view/menu/complains/complains_opened_view.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainView extends GetWidget<ComplainController> {
  ComplainView({Key? key}) : super(key: key);
  final ComplainController _controller =
      Get.put(ComplainController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const CustomText(
            text: 'TICKET',
            color: whiteColor,
            alignment: Alignment.center,
            size: 18,
            fontWeight: FontWeight.w400,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: GetBuilder<ComplainController>(
            builder: (_model) {
            return FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                _model.fetchTypeComplainData();
                _model.typeID.clear();
                _model.typeName.clear();
                _model.orderID.clear();
                _model.showD(context);
                
              },
              child: const Icon(
                Icons.add,
                color: whiteColor,
              ),
            );
          }),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, headerSliverBuilder) => [
            SliverAppBar(
              
              toolbarHeight: 8,
              elevation: 0,
              backgroundColor: whiteColor,
              bottom: _tabBarIndicatorShape(),
            ),
          ],
          body: TabBarView(
            
            children: [
              ComplainOpendView(
                text: 'Opened',
                color1: textRedColor,
                color2: textRedColor.withOpacity(0.6),
                controller: _controller,
                listData: _controller.comOpenData,
                  onPressed: () {
                  _controller.fetchOpenComplainData();
                },
              ),
              ComplainOpendView(
                text: 'Closed',
                controller: _controller,
                color1: primaryColor,
                color2: primaryColor.withOpacity(0.5),
                listData: _controller.comCloseData,
                onPressed: () {
                  _controller.fetchComplainData();
                },
              ),
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
        indicatorWeight: 0.0,
        tabs: _tabTwoParameters(),
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

  List<Widget> _tabTwoParameters() => [
        const Tab(
          text: 'Opened',
        ),
        const Tab(
          text: 'Closed',
        ),
      ];
}
