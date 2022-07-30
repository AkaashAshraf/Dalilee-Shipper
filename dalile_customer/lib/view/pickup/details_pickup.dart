import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/pickup/image_libar.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupDetails extends StatelessWidget {
  PickupDetails({Key? key, required this.ref, required this.date})
      : super(key: key);
  final String ref, date;
  final controllerClass = Get.put(PickupController(), permanent: true);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: CustomText(
          text: 'Details Pickup',
          color: whiteColor,
          size: 20,
          fontWeight: FontWeight.w500,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(
              top: 25,
              left: 15,
              right: 15,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: 'Ref : $ref',
                    size: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: 'Date : $date',
                    size: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Divider(),
              Obx(() {
                if (controllerClass.isLoadingToday.value) return WaiteImage();
                return controllerClass.pickupDetailsList.isEmpty?SizedBox(): Expanded(
                    child: ListView.builder(
                        itemCount: controllerClass.pickupDetailsList.length,
                        itemBuilder: (_, i) => Card(
                              elevation: 5,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shadowColor: primaryColor.withOpacity(0.3),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => ImageLib(
                                                galleryItems: controllerClass
                                                    .pickupDetailsList,
                                                    idex: i,
                                              ));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child:
                                            
                                            CachedNetworkImage(
                            fadeOutDuration: Duration(seconds: 2),
                            imageUrl: controllerClass.pickupDetailsList[i].image.toString(),
                            height: 70,
                            width: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Image.asset('assets/images/dalilee.png'),
                                ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.black12,
                              child: Icon(
                                Icons.error,
                                color: Colors.red[200],
                              ),
                            ),
                          ),
                                            
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        children: [
                                          CustomText(
                                            text: '${controllerClass.pickupDetailsList[i].orderId??"Pxxx"}',
                                            fontWeight: FontWeight.bold,
                                            size: 16,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          CustomText(
                                            text: 'Weight : ${controllerClass.pickupDetailsList[i].weight??0} Kg',
                                            fontWeight: FontWeight.w400,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          CustomText(
                                            text: 'Shipping : ${controllerClass.pickupDetailsList[i].shipping??0}',
                                            fontWeight: FontWeight.w400,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          CustomText(
                                            text: 'Phone : ${controllerClass.pickupDetailsList[i].phone??00968}',
                                            fontWeight: FontWeight.w400,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ), 
                                          CustomText(
                                            text: 'Location : ${controllerClass.pickupDetailsList[i].location??""}',
                                            fontWeight: FontWeight.w400,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )));
              })
            ]),
          ),
        ),
      ]),
    );
  }
}
