import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dalile_customer/components/popups/askOtp.dart';
import 'package:dalile_customer/components/popups/w3WordsPopup.dart';
import 'package:dalile_customer/view/widget/custom_popup.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/server/pickup_api.dart';
import 'package:dalile_customer/core/view_model/pickup_view_model.dart';
import 'package:dalile_customer/view/pickup/pickup_view.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GMap extends StatefulWidget {
  const GMap({Key? key}) : super(key: key);

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  final Completer<GoogleMapController> _completer = Completer();

  Set<Marker> _markers = {};
  static CameraPosition myplace =
      CameraPosition(target: LatLng(23.614328, 58.545284), zoom: 16);
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
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();
  loadData() async {
    setState(() {
      iswithing = true;
    });
    _determinePosition().then((value) async {
      lat.text = value.latitude.toString();
      long.text = value.longitude.toString();

      _markers.add(Marker(
          rotation: 0,
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'Pick')));

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
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String word3 = '';
  Future what3WordApi(lang, lat) async {
    // var _url =
    //     "http://shaheen-test2.dalilee.om/api/w3w/convert-to-3wa/?lat=$lat&lng=$lang";

    var _url =
        "$base_url/w3w/convert-to-3wa/?lat=${double.tryParse(lat)!.toStringAsFixed(3)}&lng=${double.tryParse(lang)!.toStringAsFixed(3)}";
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      var response = await http.get(Uri.parse(_url), headers: {
        "Authorization": "Bearer $token",
      });
      final data = json.decode(response.body);

      if (data["status"] == "success") {
        setState(() {
          word3 = data["words"];
        });
      } else {}
    } catch (e) {
      word3 = "";
    }
  }

  _apiData() async {
    Get.dialog(
        Center(
            child: Container(
                margin: EdgeInsets.all(5),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(90)),
                child: const WaiteImage())),
        barrierColor: Colors.transparent,
        barrierDismissible: true);
    try {
      await PickupApi.fetchlocationData(
              lat.text.toString(), long.text.toString())
          .then((value) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        if (value) {
          // Get.to(PickupView());
          Get.snackbar('Successful', "${PickupApi.success}",
              colorText: whiteColor,
              backgroundColor: primaryColor.withOpacity(0.7));
        } else {
          Get.snackbar('Failed', "${PickupApi.mass}",
              colorText: whiteColor, backgroundColor: Colors.red[800]);
        }
      }).whenComplete(() async {
        var _controller = Get.put(PickupController(), permanent: false);
        _controller.fetchAllPickupData();
        _controller.fetchTodayPickupData();

        // var temp = Get.find<PickupController>;
        // Navigator.pop(context);

        // Get.put(PickupController()).fetchTodayPickupData();
        // Navigator.pop(context);
        // w3WordsPopup(context, "word3");

        await what3WordApi(
          long.text.toString(),
          lat.text.toString(),
        );
        // log("-----------lat===>${lat.text.toString()}");
        // log("-----------long===>${long.text.toString()}");
        Navigator.pop(context);

        w3WordsPopup(context, word3);

        // .whenComplete(() {
        //   if (word3.isNotEmpty) {
        //     w3WordsPopup(context, word3);

        //     // showDialog(
        //     //     useRootNavigator: true,
        //     //     barrierDismissible: true,
        //     //     barrierColor: Colors.transparent,
        //     //     context: context,
        //     //     builder: (BuildContext context) {
        //     //       return CustomDialogBoxAl(
        //     //         title: "What3Word",
        //     //         des: "3 word = $word3",
        //     //         icon: Icons.map,
        //     //       );
        //     //     });
        //   }
        // });

        // return true;
      });
    } finally {
      // what3WordApi(
      //   long.text.toString(),
      //   lat.text.toString(),
      // ).whenComplete(() {
      //   if (word3.isNotEmpty) {
      //     showDialog(
      //         barrierDismissible: true,
      //         barrierColor: Colors.transparent,
      //         context: context,
      //         builder: (BuildContext context) {
      //           return CustomDialogBoxAl(
      //             title: "What3Word",
      //             des: "3 word = $word3",
      //             icon: Icons.map,
      //           );
      //         });
      //   }
      // });
    }
  }

  MapPickerController mapPickerController = MapPickerController();

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          backgroundColor: whiteColor,
          onPressed: () {
            loadData();
            setState(() {});
          },
          child: Icon(
            Icons.refresh,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
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
                    lat.text = myplace.target.latitude.toString();
                    long.text = myplace.target.longitude.toString();
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
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(90)),
                      child: Icon(
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
                      ? WaiteImage()
                      : CustomButtom(
                          text: 'Pick Address',
                          onPressed: () {
                            _apiData();
                          },
                        )),
            )
          ],
        ),
      ),
    );
  }
}
