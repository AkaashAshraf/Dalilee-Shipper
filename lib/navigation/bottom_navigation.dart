// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/home/home_view.dart';
import 'package:dalile_customer/view/menu/finances/finance.dart';
import 'package:dalile_customer/view/menu/menu_screen.dart';
import 'package:dalile_customer/view/pickup/pickup_view.dart';
import 'package:dalile_customer/view/shipments/shipments_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _page = 2;

  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Map<String, Widget>> _pages = [
    {
      'page': PickupView(),
    },
    {
      'page': ShipmentView(),
    },
    {
      'page': HomeView(),
    },
    {
      'page': FinanceView(),
    },
    {
      'page': MenuScreen(),
    }
  ];

  int _activePage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: 75.0,

          items: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: _activePage == 0 ? 22 : 22,
                  bottom: _activePage == 0 ? 8 : 0,
                  left: _activePage == 0 ? 8 : 0,
                  right: _activePage == 0 ? 8 : 0),
              child: Column(
                children: [
                  // Icon(Icons.home,
                  //     size: 30,
                  //     color: _activePage == 0 ? Colors.white : Colors.grey),
                  new Image.asset(
                    'assets/images/bottom_1.png',
                    height: 26,
                    width: 26,
                    color: _activePage == 0 ? whiteColor : bottomIconColors,
                  ),

                  Text(
                    _activePage == 0 ? '' : 'Pickup'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: bottomIconColors,
                        fontSize: 13),
                  ).paddingOnly(top: 3)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _activePage == 1 ? 22 : 22,
                  bottom: _activePage == 1 ? 8 : 0,
                  left: _activePage == 1 ? 8 : 0,
                  right: _activePage == 1 ? 8 : 0),
              child: Column(
                children: [
                  new Image.asset(
                    'assets/images/bottom_2.png',
                    height: 26,
                    width: 26,
                    color: _activePage == 1 ? whiteColor : bottomIconColors,
                  ),
                  Text(
                    _activePage == 1 ? '' : 'Shipments'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: bottomIconColors,
                        fontSize: 13),
                  ).paddingOnly(top: 3),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _activePage == 2 ? 22 : 22,
                  bottom: _activePage == 2 ? 8 : 0,
                  left: _activePage == 2 ? 8 : 0,
                  right: _activePage == 2 ? 8 : 0),
              child: Column(
                children: [
                  new Image.asset(
                    'assets/images/bottom_3.png',
                    height: 26,
                    width: 26,
                    color: _activePage == 2 ? whiteColor : bottomIconColors,
                  ),
                  Text(
                    _activePage == 2 ? '' : 'Home'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: bottomIconColors,
                        fontSize: 13),
                  ).paddingOnly(top: 3)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _activePage == 3 ? 22 : 22,
                  bottom: _activePage == 3 ? 8 : 0,
                  left: _activePage == 3 ? 8 : 0,
                  right: _activePage == 3 ? 8 : 0),
              child: Column(
                children: [
                  new Image.asset(
                    'assets/images/bottom_4.png',
                    height: 26,
                    width: 26,
                    color: _activePage == 3 ? whiteColor : bottomIconColors,
                  ),
                  Text(
                    _activePage == 3 ? '' : 'Finance'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: bottomIconColors,
                        fontSize: 13),
                  ).paddingOnly(top: 3)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _activePage == 4 ? 22 : 22,
                  bottom: _activePage == 4 ? 8 : 0,
                  left: _activePage == 4 ? 8 : 0,
                  right: _activePage == 4 ? 8 : 0),
              child: Column(
                children: [
                  new Image.asset(
                    'assets/images/bottom_5.png',
                    height: 26,
                    width: 26,
                    color: _activePage == 4 ? whiteColor : bottomIconColors,
                  ),
                  Text(
                    _activePage == 4 ? '' : 'More'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: bottomIconColors,
                        fontSize: 13),
                  ).paddingOnly(top: 3)
                ],
              ),
            ),
          ],

          // color:Color.,
          buttonBackgroundColor: primaryColor,
          // buttonBackgroundColor: appcolour,
          backgroundColor: whiteColor,
          color: bgColor,
          // animationCurve: Curves.easeInOut,

          animationDuration: Duration(milliseconds: 500),
          onTap: (index) async {
            setState(() {
              _activePage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        // body: containerBottom());
        body: _pages[_activePage]['page']);
  }
}

Container containerBottom() {
  return Container(
    color: Colors.blueAccent,
    child: Center(
      child: Column(
        children: <Widget>[
          Text('Go To Page of index  nmnm'),
          ElevatedButton(
            child: Text('Go To Page of index   m m m'),
            onPressed: () {
              AlertDialog(title: Text("Sample Alert Dialog"));
            },
          )
        ],
      ),
    ),
  );
}
