import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalile_customer/components/generalModel.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/downloadController.dart';
import 'package:dalile_customer/model/shaheen_aws/shipment.dart';
import 'package:dalile_customer/view/pickup/image_libar.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:get/get.dart';

Alert imagesViewModal(BuildContext context, String orderNo,
    {required Shipment shipment}) {
  List<OrderImages> images = [];
  if (shipment.pickupImage != "")
    images.add(OrderImages(shipment.pickupImage, 'pickupImage'.tr));
  if (shipment.orderImage != "")
    images.add(OrderImages(shipment.orderImage, 'deliveredImage'.tr));
  if (shipment.undeliverImage != "")
    images.add(OrderImages(shipment.undeliverImage, 'undeliverImage'.tr));
  if (shipment.undeliverImage2 != "")
    images.add(OrderImages(shipment.undeliverImage2, 'undeliverImage'.tr));
  if (shipment.undeliverImage3 != "")
    images.add(OrderImages(shipment.undeliverImage3, 'undeliverImage'.tr));
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
                    width: MediaQuery.of(context).size.width * 0.7,
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
                                        child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => ImageLib(
                                              galleryItems: [
                                                ...images.reversed,
                                              ],
                                              idex: images.indexOf(subItem),
                                            ));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: subItem.image.toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Text(''),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            controller.startDownloadingImage(
                                                subItem.image.toString(),
                                                isGoBack: false);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                subItem.type.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(width: 10),
                                              const Icon(
                                                Icons.download_outlined,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ],
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

class OrderImages {
  String? image;
  String? type;
  OrderImages(this.image, this.type);
}
