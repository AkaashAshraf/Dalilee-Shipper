import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/OrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyShop extends StatelessWidget {
  Future<void> _loadData() async {}

  @override
  Widget build(BuildContext context) {
    _loadData();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        elevation: 0,
        /*title: Text(AppConstants.APP_NAME, maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoMedium.copyWith(
          color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_DEFAULT,
        )),*/
        title: Text(
          'MyShop'.tr,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: GetX<ShopController>(builder: (controller) {
        return DefaultTabController(
          length: 4,
          child: SingleChildScrollView(
            child: Container(
              height: height,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 3,
                        color: primaryColor,
                        child: SizedBox(
                            width: width,
                            height: height * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    children: [
                                      titleText(height, "Today"),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Container(
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Icon(
                                              Icons.wallet,
                                              color: whiteColor,
                                              size: height * 0.07,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            amountText(height, "2.2"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: height * 0.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 12,
                                              ),
                                              titleText(height, "This Week"),
                                              amountText(height, "5.4")
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "|",
                                                style: TextStyle(
                                                    fontSize: 50,
                                                    fontWeight: FontWeight.w100,
                                                    color: whiteColor),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 12,
                                              ),
                                              titleText(height, "This Month"),
                                              amountText(height, "5.4")
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))),
                  ),
                  ButtonsTabBar(
                    backgroundColor: primaryColor,
                    unselectedBackgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    unselectedLabelStyle: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                    borderWidth: 0.3,
                    unselectedBorderColor: Colors.black,
                    radius: 5,
                    tabs: [
                      Tab(
                        icon: Container(),
                        text:
                            "Pending ${controller.orders.where((p0) => false).length}",
                      ),
                      Tab(
                        text: "Accepted",
                      ),
                      Tab(
                        text: "In Process",
                      ),
                      Tab(
                        text: "Completed",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Container(
                        height: height,
                        child: Card(
                          child: ListTile(
                              title: Text("Order ID: #  100050"),
                              subtitle: Text("27-Nov-2022 01:32 PM "),
                              // trailing: Text("Delivery"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ) // for Left

                              ),
                        ),
                      ),
                      Text("Confirmed"),
                      Text("In Process"),
                      Text("pending")
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Text amountText(double height, String amount) {
    return Text("$amount      ${'ر. ع'}",
        style: TextStyle(
          fontSize: height * 0.025,
          color: whiteColor,
          fontWeight: FontWeight.w500,
        ));
  }

  Widget titleText(double height, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: TextStyle(
            fontSize: height * 0.015,
            color: whiteColor,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
