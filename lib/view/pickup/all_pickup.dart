import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/pickup_controller.dart';
import 'package:dalile_customer/view/tam-oman-special/items/pickup_item.dart';
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
                        return PickUpItem(
                            refernce: controllerClass.allPickup[i]!);
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
