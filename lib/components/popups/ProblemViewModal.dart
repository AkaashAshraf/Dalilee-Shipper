import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/components/popups/ImagesViewModal.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';

Alert problemViewModal(
    BuildContext context, List<OrderImages> images, String orderNo,
    {required Shipment shipment}) {
  return modal(
    context,
    Column(
      children: [
        GetX<DownloadController>(builder: (controller) {
          return Stack(
            children: [
              Column(children: [
                Text(
                  "$orderNo",
                  style: TextStyle(
                      color: shipment.isProblem ? Colors.red : primaryColor),
                ),
                SizedBox(height: 10),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DottedLine(
                      dashColor: Colors.red,
                    )),
                Text(
                  shipment.problemText,
                  style: TextStyle(
                      fontSize: 14,
                      color: shipment.isProblem ? Colors.red : primaryColor),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DottedLine(
                      dashColor: Colors.red,
                    )),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.width * 0.75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: images.length == 0
                      ? new NoDataView(label: "NoData".tr)
                      : CarouselSlider(
                          items: [shipment.problemImage]
                              .reversed
                              .map((subItem) => Stack(children: [
                                    Center(
                                        child: CachedNetworkImage(
                                      imageUrl: subItem.toString(),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.75,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Text(''),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // controller.startDownloadingImage(
                                            //     subItem.toString(),
                                            //     isGoBack: false);
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Solve".tr,
                                                    style: TextStyle(
                                                        color: primaryColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  // SizedBox(width: 10),
                                                  // const Icon(
                                                  //   Icons.download_outlined,
                                                  //   color: Colors.red,
                                                  //   size: 25,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  ]))
                              .toList(),
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {},
                            scrollDirection: Axis.horizontal,
                          )),
                )
              ]),
              if (controller.isDownloading.value)
                Positioned.fill(child: const WaiteImage()),
            ],
          );
        })
      ],
    ),
  );
}
