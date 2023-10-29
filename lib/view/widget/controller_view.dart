import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/home_controller.dart';
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
                  buildItem(
                    'assets/images/tobedelivered.png',
                    activeIcon: Icon(
                      Icons.add,
                      color: primaryColor,
                      size: 25,
                    ),
                    nonActiveIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
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

  TabItem<dynamic> buildItem(String image,
      {Icon? nonActiveIcon, Icon? activeIcon}) {
    return TabItem(
      activeIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: activeIcon ??
            Image.asset(
              image,
              color: primaryColor,
            ),
      ),
      icon: nonActiveIcon ??
          Image.asset(
            image,
            color: whiteColor,
          ),
    );
  }
}
