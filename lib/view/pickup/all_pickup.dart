import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/widget/all_pickup_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllListPickup extends StatefulWidget {
  AllListPickup({Key? key}) : super(key: key);

  @override
  State<AllListPickup> createState() => _AllListPickupState();
}

class _AllListPickupState extends State<AllListPickup> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;
  final controllerClass = Get.put(PickupController(), permanent: true);
  _loadMore() {
    if (controllerClass.loadMoreAllPickup.value) return;

    if (controllerClass.totalAllPickup.value >
            controllerClass.allPickup.length &&
        scrollController!.position.extentAfter < 10.0) {
      controllerClass.loadMoreAllPickup.value = true;
      controllerClass.fetchAllPickupData(isRefresh: false);
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        _loadMore();
      });
  }

  @override
  void dispose() {
    scrollController!.removeListener(() {
      _loadMore();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (controllerClass.isLoadingAll.value) {
      //   return const WaiteImage();
      // }

      if (controllerClass.allPickup.isNotEmpty) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 14,
                  child: SmartRefresher(
                    header: WaterDropHeader(
                      waterDropColor: primaryColor,
                    ),
                    controller: refreshController,
                    // scrollController: scrollController,
                    onRefresh: () async {
                      await controllerClass.fetchAllPickupData(isRefresh: true);

                      refreshController.refreshCompleted();
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 16),
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
                            controllerClass.makePhoneCall(
                                "${controllerClass.allPickup[i]!.driverMobile ?? ""}");
                          },
                          status: controllerClass.allPickup[i]!.status ?? '',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (controllerClass.loadMoreAllPickup.value)
              bottomLoadingIndicator()
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmptyState(
              label: 'NoData'.tr,
            ),
            MaterialButton(
              onPressed: () {
                controllerClass.fetchAllPickupData();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'Updateddata'.tr,
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
