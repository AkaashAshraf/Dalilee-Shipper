import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/home_view_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ControllerView extends StatelessWidget {
  const ControllerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (_data) {
          return Scaffold(
            bottomNavigationBar: ConvexAppBar(
                disableDefaultTabController: true,
                items: [
                  buildItem('assets/images/Vector.png'),
                  buildItem('assets/images/icon-park-outline_delivery.png'),
                  buildItem('assets/images/carbon_delivery-parcel.png'),
                  buildItem('assets/images/ll.png'),
                ],
                backgroundColor: primaryColor,
                color: whiteColor,
                activeColor: whiteColor,
                style: TabStyle.reactCircle,
                onTap: (i) {
                  _data.onSelectItem(i, context);
                }),
            body: _data.screen,
          );
        });
  }

  TabItem<dynamic> buildItem(String image) {
    return TabItem(
      activeIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(
          image,
          color: primaryColor,
        ),
      ),
      icon: Image.asset(
        image,
        color: whiteColor,
      ),
    );
  }
}
