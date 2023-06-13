import 'dart:async';

import 'package:dalile_customer/components/popups/confirm_assign_store.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/add_store_controller.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddStoreView extends StatefulWidget {
  const AddStoreView({Key? key}) : super(key: key);

  @override
  State<AddStoreView> createState() => _AddStoreViewState();
}

class _AddStoreViewState extends State<AddStoreView> {
  String searchText = "";
  AddStoreController controller = Get.put(AddStoreController());
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  void _refresh() async {
    await controller.searchData(searchText: searchText, isRefresh: true);
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
          title: CustomText(
              text: 'addStore'.tr.toUpperCase(),
              color: whiteColor,
              size: 18,
              alignment: Alignment.center),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // height: 50,
                    child: TextField(
                      // controller: TextEditingController(text: searchText),
                      onChanged: (val) {
                        setState(() {
                          searchText = val;
                        });
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          // if (searchText.isEmpty)
                          //   controller.shipments.value = [];
                          // else
                          refreshController.requestRefresh();

                          // do something with query
                        });
                      },
                      textCapitalization: TextCapitalization.characters,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: primaryColor)),
                        hintText: 'Search'.tr,
                        // helperText: 'write_order_number'.tr,
                        labelText: 'search_store'.tr,
                        prefixIcon: Icon(
                          Icons.search,
                          color: primaryColor,
                        ),
                        prefixText: ' ',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GetX<AddStoreController>(builder: (controller) {
                    return SmartRefresher(
                        header: WaterDropHeader(
                          waterDropColor: primaryColor,
                        ),
                        controller: refreshController,
                        onRefresh: () async {
                          _refresh();
                        },
                        child: controller.stores.isEmpty
                            ? controller.loading.value
                                ? WaiteImage()
                                : NoDataView(label: "NoData".tr)
                            : ListView.separated(
                                // shrinkWrap: false,

                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 15),
                                itemCount: controller.stores.length,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                itemBuilder: (context, i) {
                                  return GetBuilder<AddStoreController>(
                                      builder: (x) => Container(
                                            child: Card(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("name:".tr),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(controller
                                                          .stores[i].name),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("phone:".tr),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text((controller.stores[i]
                                                                      .branchId !=
                                                                  19
                                                              ? "968"
                                                              : "971") +
                                                          controller.stores[i]
                                                              .mobile),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("branch:".tr),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(controller
                                                          .stores[i].branch),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.9,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (!controller
                                                            .assignLoading
                                                            .value) {
                                                          confirmAssignStore(
                                                                  context,
                                                                  store: controller
                                                                      .stores[i])
                                                              .show();
                                                        }
                                                      },
                                                      child: controller
                                                              .assignLoading
                                                              .value
                                                          ? WaiteImage()
                                                          : Text("assign".tr),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(controller
                                                                          .assignLoading
                                                                          .value
                                                                      ? Colors
                                                                          .grey
                                                                      : primaryColor)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                          ));
                                },
                              ));
                  }),
                ),
              ],
            )));
  }
}
