import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/widget/all_pickup_body.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/empty.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TodayListPickup extends StatefulWidget {
  TodayListPickup({Key? key}) : super(key: key);

  @override
  State<TodayListPickup> createState() => _TodayListPickupState();
}

class _TodayListPickupState extends State<TodayListPickup> {
  final controllerClass = Get.put(PickupController(), permanent: true);
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController? scrollController;
  _loadMore() {
    if (controllerClass.loadMoreTodayPickup.value) return;

    if (controllerClass.totalTodayPickup.value > controllerClass.today.length &&
        scrollController!.position.extentAfter < 10.0) {
      controllerClass.loadMoreTodayPickup.value = true;
      controllerClass.fetchTodayPickupData(isRefresh: false);
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

    // controllerClass.fetchTodayPickupData(isRefresh: true);
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
      if (controllerClass.isLoadingToday.value) {
        return const WaiteImage();
      }
      if (controllerClass.today.isNotEmpty) {
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
                      await controllerClass.fetchTodayPickupData(
                          isRefresh: true);

                      refreshController.refreshCompleted();
                    },
                    child: ListView.separated(
                        // physics: const NeverScrollableScrollPhysics(),
                        controller: scrollController,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 5),
                        itemBuilder: (context, i) {
                          return AllPickupBody(
                            cod: controllerClass.today[i]!.cop ?? 0,
                            name: controllerClass.today[i]!.driverName ?? "",
                            qty: controllerClass.today[i]!.totalOrders ?? "",
                            date:
                                controllerClass.today[i]!.collectionDate ?? "",
                            id: controllerClass.today[i]!.id ?? '',
                            onPressed: () {
                              controllerClass.makePhoneCall(
                                  "${controllerClass.today[i]!.driverMobile ?? "71793854"}");
                            },
                            status: controllerClass.today[i]!.status ?? '',
                          );
                        },
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 16),
                        itemCount: controllerClass.today.length),
                  ),
                ),
              ],
            ),
            if (controllerClass.loadMoreTodayPickup.value)
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
                controllerClass.fetchTodayPickupData();
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
