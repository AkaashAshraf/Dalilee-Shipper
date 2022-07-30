import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/widget/all_pickup_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayListPickup extends StatelessWidget {
  TodayListPickup({Key? key}) : super(key: key);
  final controllerClass = Get.put(PickupController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controllerClass.isLoadingToday.value) {
        return const WaiteImage();
      }
      if (controllerClass.today.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  controllerClass.fetchAllPickupData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CustomText(
                      text: 'Updated data ',
                      color: Colors.grey,
                      alignment: Alignment.center,
                      size: 12,
                    ),
                    Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 14,
              child: ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 5),
                  itemBuilder: (context, i) {
                    return AllPickupBody(
                        cod: controllerClass.today[i]!.cop??0,
                    name: controllerClass.today[i]!.driverName??"",
                    qty: controllerClass.today[i]!.totalOrders??"",
                    date: controllerClass.today[i]!.collectionDate??"",
                    id: controllerClass.today[i]!.id??'',
                      onPressed: () {  print("--------------->${controllerClass.allPickup[i]!.driveMobile??"71793854"}");
                        controllerClass.makePhoneCall(
                            "${controllerClass.today[i]!.driveMobile??"71793854"}");
                      },
                      status:controllerClass.today[i]!.status??'' ,
                    );
                  },
                  separatorBuilder: (context, i) => const SizedBox(height: 16),
                  itemCount: controllerClass.today.length),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyState(
              label: 'no Data ',
            ),
            MaterialButton(
              onPressed: () {
                controllerClass.fetchTodayPickupData();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CustomText(
                    text: 'Updated data ',
                    color: Colors.grey,
                    alignment: Alignment.center,
                    size: 12,
                  ),
                  Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
