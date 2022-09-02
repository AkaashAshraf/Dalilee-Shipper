import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/widget/all_pickup_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllListPickup extends StatelessWidget {
  AllListPickup({Key? key}) : super(key: key);
  final controllerClass = Get.put(PickupController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controllerClass.isLoadingAll.value) {
        return const WaiteImage();
      }

      if (controllerClass.allPickup.isNotEmpty) {
        return Column(
          children: [
            MaterialButton(
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
            Expanded(
              flex: 14,
              child: ListView.separated(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 5),
                separatorBuilder: (context, i) => const SizedBox(height: 16),
                itemCount: controllerClass.allPickup.length,
                itemBuilder: (context, i) {
                  return AllPickupBody(
                    cod: controllerClass.allPickup[i]!.cop ?? 0,
                    name: controllerClass.allPickup[i]!.driverName ?? "",
                    qty: controllerClass.allPickup[i]!.totalOrders ?? "0",
                    date: controllerClass.allPickup[i]!.collectionDate ??
                        "dd-mm-yyyy",
                    id: controllerClass.allPickup[i]!.id ?? '',
                    onPressed: () {
                      print(
                          "--------------->${controllerClass.allPickup[i]!.driveMobile}");
                      controllerClass.makePhoneCall(
                          "${controllerClass.allPickup[i]!.driveMobile ?? "71793854"}");
                    },
                    status: controllerClass.allPickup[i]!.status ?? '',
                  );
                },
              ),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyState(
              label: 'No Data ',
            ),
            MaterialButton(
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
          ],
        );
      }
    });
  }
}
