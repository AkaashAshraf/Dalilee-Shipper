import 'dart:async';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/branch_view_model.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapsOffices extends StatefulWidget {
  MapsOffices({Key? key, required this.model}) : super(key: key);
  final BranchController model;

  @override
  State<MapsOffices> createState() => _MapsOfficesState();
}

class _MapsOfficesState extends State<MapsOffices> {
  double zoomVal = 10.0;
  @override
  void dispose() {
    _disp();
    super.dispose();
  }
  final Completer<GoogleMapController> controller = Completer();
  Future<void> _disp() async {
    final GoogleMapController controller1 = await controller.future;
    controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              // hide location button
              myLocationButtonEnabled: false,

              //  camera position

              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(widget.model.lat.value, widget.model.lng.value),
                  zoom: 14),
              onMapCreated: (GoogleMapController controller1) {
             controller.complete(controller1);
              },
              markers: widget.model.markers,
            ),
          ),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      );
    });
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: const Icon(FontAwesomeIcons.magnifyingGlassMinus,
              color: primaryColor),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: const Icon(FontAwesomeIcons.magnifyingGlassPlus,
              color: primaryColor),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller1 = await controller.future;
    controller1.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(widget.model.lat.value, widget.model.lng.value),
        zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller1 = await controller.future;
    controller1.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(widget.model.lat.value, widget.model.lng.value),
        zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.model.branchListData.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: _boxes(
                "$image${widget.model.branchListData[index].image}",
                double.parse(widget.model.branchListData[index].lat.toString()),
                double.parse(widget.model.branchListData[index].lng.toString()),
                widget.model.branchListData[index].name.toString(),
                context),
          ),
        ),
      ),
    );
  }

  Widget _boxes(
      String _image, double lat, double long, String restaurantName, context) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
        widget.model.lat.value = lat;
        widget.model.lng.value = long;
      },
      child: FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: primaryColor.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 190,
                    height: 210,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 370,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          CustomText(
                              text: restaurantName,
                              color: primaryColor,
                              size: 18.0,
                              alignment: Alignment.topCenter,
                              fontWeight: FontWeight.bold),
                          
                          const SizedBox(height:7.0),
                          const CustomText(
                            text: "Working Hours",
                            color: primaryColor,
                            size: 16.0,
                            alignment: Alignment.topCenter,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5.0),
                          _buildRowDays("Sunday".tr, "08:00 am-10:00 pm"),
                          _buildRowDays("Monday".tr, "08:00 am-10:00 pm"),
                          _buildRowDays("Tuesday".tr, "08:00 am-10:00 pm"),
                          _buildRowDays("WenDay".tr, "08:00 am-10:00 pm"),
                          _buildRowDays("Thursday".tr, "08:00 am-10:00 pm"),
                          _buildRowDays("Friday".tr, "Closed"),
                          _buildRowDays("Saturday".tr, "08:00 am-10:00 pm"),
                          const SizedBox(height: 20.0),
                          MaterialButton(
                            onPressed: () {
                              Get.bottomSheet(
                                _buttonSheetBody(lat, long, "$_image",
                                    "$restaurantName", context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: 'ShowMore'.tr,
                                  color: textRedColor,
                                  size: 18,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: textRedColor,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Container _buttonSheetBody(double lat, double long, _image, name, context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: whiteColor,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: textRedColor,
              size: 24,
            ),
            SizedBox(
              width: double.infinity,
              height: 120,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 5,
                      ),
                  itemBuilder: (context, i) {
                    return SizedBox(
                      width: 180,
                      height: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(_image),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "$name Branch",
                    color: primaryColor,
                    size: 14,
                    alignment: Alignment.topCenter,
                    fontWeight: FontWeight.w500),
                
                Row(
                 
                  children: [
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Googlemap'.tr,
                            titlePadding: const EdgeInsets.all(15),
                            contentPadding: const EdgeInsets.all(5),
                            middleText: 'OpenGoooleMap'.tr,
                            textCancel: 'Cancel'.tr,
                            textConfirm: 'Ok'.tr,
                            buttonColor: primaryColor,
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            radius: 10,
                            backgroundColor: whiteColor,
                            onConfirm: () {
                              Get.back();
                              MapUtils.openMap(double.parse(lat.toString()),
                                  double.parse(long.toString()));
                            });
                      },
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'GoLocation'.tr,
                            color: primaryColor,
                          ),
                          Icon(
                            Icons.near_me,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Whatsapp'.tr,
                            titlePadding: const EdgeInsets.all(15),
                            contentPadding: const EdgeInsets.all(5),
                            middleText: 'AreWhatsapp'.tr,
                            textCancel: 'Cancel'.tr,
                            textConfirm: 'Ok'.tr,
                            buttonColor: primaryColor,
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            radius: 10,
                            backgroundColor: whiteColor,
                            onConfirm: () {
                              widget.model.launchWhatsapp(
                                  "${widget.model.branchListData.first.phone}");
                            });
                      },
                      child: Image.asset(
                        'assets/images/what.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                   const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Call'.tr,
                            titlePadding: const EdgeInsets.all(15),
                            contentPadding: const EdgeInsets.all(5),
                            middleText: 'AreCall'.tr,
                            textCancel: 'Cancel'.tr,
                            textConfirm: 'Ok'.tr,
                            buttonColor: primaryColor,
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            radius: 10,
                            backgroundColor: whiteColor,
                            onConfirm: () {
                              widget.model.makePhoneCall(
                                  "${widget.model.branchListData.first.phone}");
                            });
                      },
                      child: Image.asset(
                        'assets/images/call.png',
                        height: 19,
                        width: 19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 7),
             CustomText(
              text: "WorkingHours".tr,
              color: primaryColor,
              size: 12.0,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 5.0),
            _buildRowDays("Sunday".tr, "08:00 am-10:00 pm"),
             const SizedBox(height: 5.0),
            _buildRowDays("Monday".tr, "08:00 am-10:00 pm"),
             const SizedBox(height: 5.0),
            _buildRowDays("Tuesday".tr, "08:00 am-10:00 pm"),
             const SizedBox(height: 5.0),
            _buildRowDays("WenDay".tr, "08:00 am-10:00 pm"), const SizedBox(height: 5.0),
            _buildRowDays("Thursday".tr, "08:00 am-10:00 pm"), const SizedBox(height: 5.0),
            _buildRowDays("Friday".tr, "Closed".tr), const SizedBox(height: 5.0),
            _buildRowDays("Saturday".tr, "08:00 am-10:00 pm"),
          ],
        ));
  }

  _buildRowDays(String name, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: name,
          color: text1Color,
          size: 12.0,
        ),
        CustomText(
          text: date,
          color: text1Color,
          size: 12.0,
        ),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller1 = await controller.future;
    controller1.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
