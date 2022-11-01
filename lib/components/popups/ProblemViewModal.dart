import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/components/popups/ProblemResolveViewModal.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/model/Shipments/ShipmentListingModel.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';

Alert problemViewModal(BuildContext context, String orderNo,
    {required Shipment shipment}) {
  List<String> images = [];
  if (shipment.orderUndeliverImage != "")
    images.add(shipment.orderUndeliverImage!);

  if (shipment.orderUndeliverImage2 != "")
    images.add(shipment.orderUndeliverImage2!);
  if (shipment.orderUndeliverImage3 != "")
    images.add(shipment.orderUndeliverImage3!);
  print(images);
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
                  style: TextStyle(color: primaryColor),
                ),
                SizedBox(height: 10),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DottedLine(
                      dashColor: primaryColor,
                    )),
                SizedBox(height: 5),
                Text(
                  shipment.problemReasons,
                  style: TextStyle(
                      fontSize: 14,
                      color: shipment.isProblem ? Colors.red : primaryColor),
                ),
                SizedBox(height: 5),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DottedLine(
                      dashColor: primaryColor,
                    )),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.width * 0.75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: images.length == 0
                      ? new NoDataView(label: "NoData".tr)
                      : CarouselSlider(
                          items: images.reversed
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
                                        child: Container(
                                          color: Colors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                controller.comments.value = "";

                                                Navigator.pop(context);
                                                problemResolveViewModal(
                                                        context, orderNo,
                                                        shipment: shipment)
                                                    .show();
                                              },
                                              child: Text(
                                                "Solve".tr,
                                                style: TextStyle(
                                                    color: whiteColor),
                                                textAlign: TextAlign.center,
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
