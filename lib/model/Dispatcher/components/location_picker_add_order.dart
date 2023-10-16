import 'dart:async';

import 'package:dalile_customer/components/common/simple_button.dart';
import 'package:dalile_customer/controllers/dispatcher_controller.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_picker/map_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerAddOrder extends StatefulWidget {
  LocationPickerAddOrder({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<LocationPickerAddOrder> createState() => _LocationPickerAddOrderState();
  int index;
}

class _LocationPickerAddOrderState extends State<LocationPickerAddOrder> {
  final Completer<GoogleMapController> _completer = Completer();

  final Set<Marker> _markers = {};
  static CameraPosition myplace =
      const CameraPosition(target: LatLng(23.614328, 58.545284), zoom: 16);
  Future<Position> _determinePosition() async {
    bool serviceEnabled = false;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  bool iswithing = false;
  String lat = "";
  String long = "";

  loadData() async {
    try {
      setState(() {
        iswithing = true;
      });
      _determinePosition().then((value) async {
        setState(() {
          lat = value.latitude.toString();
          long = value.longitude.toString();
        });

        _markers.add(Marker(
            rotation: 0,
            markerId: const MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(title: 'Pick')));

        CameraPosition cameraPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 18,
            bearing: 45);

        final GoogleMapController controller = await _completer.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          cameraPosition,
        ));
      }).whenComplete(() => setState(() {
            iswithing = false;
          }));
    } catch (e) {
    } finally {
      setState(() {
        iswithing = false;
      });
    }
  }

  MapPickerController mapPickerController = MapPickerController();
  DispatcherController dispatcherController = Get.find<DispatcherController>();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 200), () {
      loadData();
    });
  }

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              loadData();
              setState(() {});
            },
            child: const Icon(
              Icons.refresh,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MapPicker(
              iconWidget: Image.asset(
                "assets/images/dalilee1.png",
                height: 40,
              ),
              mapPickerController: mapPickerController,
              child: GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  // hide location button
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  //  camera position
                  initialCameraPosition: myplace,
                  onMapCreated: (GoogleMapController controller) {
                    _completer.complete(controller);
                  },
                  onCameraMoveStarted: () {
                    // notify map is moving
                    mapPickerController.mapMoving!();
                    textController.text = "checking ...";
                  },
                  onCameraMove: (cameraPosition) {
                    myplace = cameraPosition;
                  },
                  onCameraIdle: () async {
                    mapPickerController.mapFinishedMoving!();
                    setState(() {
                      lat = myplace.target.latitude.toString();
                      long = myplace.target.longitude.toString();
                    });
                  }),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(90)),
                      child: const Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 30,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: iswithing
                      ? const WaiteImage()
                      : SimpleButton(
                          title: "Pick Location".tr,
                          onPress: () async {
                            // dispatcherController
                            //     .addList[widget.index].latitude = lat;

                            // dispatcherController
                            //     .addList[widget.index].longitude = long;

                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                              double.tryParse(lat) ?? 0,
                              double.tryParse(long) ?? 0,
                            );

                            // update the ui with the address
                            String address =
                                '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                            // dispatcherController
                            //     .addList[widget.index].locationName = address;

                            dispatcherController.updatePickupLocationOfOrder(
                                latitude: lat,
                                longitude: long,
                                loctaionName: address,
                                index: widget.index);
                            Get.back();
                          })),
            )
          ],
        ));
  }
}
