import 'dart:io';

import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/profile_controller.dart';
import 'package:dalile_customer/view/menu/profiles/location_picker.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _controller = Get.put(ProfileController());

  @override
  void dispose() {
    // var _controller = Get.put(ProfileController());
    _controller.isEditinig.value = false;
    _controller.profileLoading.value = false;
    _controller.profile.value.storeName = _controller.name;
    _controller.profile.value.storeMobile = _controller.mobile;
    _controller.profile.value.storeEmail = _controller.email;
    _controller.image.value = XFile('');

    super.dispose();
  }

  @override
  void initState() {
    _controller.newInstLink("");
    _controller.newLat("");
    _controller.newLong("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        title: CustomText(
          text: 'Profile'.tr,
          color: whiteColor,
          size: 18,
          alignment: Alignment.center,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: GetX<ProfileController>(builder: (controller) {
        return Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                color: bgColor,
                // borderRadius:
                //     BorderRadius.only(topLeft: Radius.circular(50)
                //     )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: controller.isEditinig.value,
                          onChanged: (value) {
                            controller.isEditinig.value =
                                value == true ? true : false;
                          },
                        ), //Che

                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "enableEditing".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15)),
                            ]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormFiledWithTitle(
                      read: !controller.isEditinig.value,
                      hintText: 'storeName'.tr,
                      text: 'storeName'.tr,
                      controller: new TextEditingController(
                          text: controller.profile.value.storeName),
                      prefix: const Icon(
                        Icons.storefront_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onChanged: (val) {
                        controller.profile.value.storeName = val;
                      },
                      suffixIcon: controller.isEditinig.value == false
                          ? null
                          : Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Image.asset(
                                'assets/images/edits.png',
                                height: 10,
                                width: 10,
                                color: Colors.grey,
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormFiledWithTitle(
                      text: 'Email'.tr,
                      controller: new TextEditingController(
                          text: controller.profile.value.storeEmail),
                      hintText: 'abc@gmail.com',
                      onChanged: (val) {
                        controller.profile.value.storeEmail = val;
                      },
                      read: !controller.isEditinig.value,
                      prefix: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: controller.isEditinig.value == false
                            ? null
                            : Image.asset(
                                'assets/images/edits.png',
                                height: 10,
                                width: 10,
                                color: Colors.grey,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormFiledWithTitle(
                      limitCharacters: 8,
                      read: !controller.isEditinig.value,
                      onChanged: (val) {
                        controller.profile.value.storeMobile = val;
                      },
                      text: 'mobile'.tr,
                      controller: new TextEditingController(
                        text: controller.profile.value.storeMobile,
                      ),

                      // initialValue: controller.profile.value.storeMobile,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: controller.isEditinig.value == false
                            ? null
                            : Image.asset(
                                'assets/images/edits.png',
                                height: 10,
                                width: 10,
                                color: Colors.grey,
                                fit: BoxFit.fill,
                              ),
                      ),
                      hintText: '+968 9xxx xxxx',
                      prefix: const Icon(
                        Icons.phone_iphone_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormFiledWithTitle(
                      read: !controller.isEditinig.value,
                      onChanged: (val) {
                        controller.profile.value.instagramLink = val;
                        controller.newInstLink.value = val;
                      },
                      text: 'instagramLink'.tr,
                      controller: new TextEditingController(
                        text: controller.profile.value.instagramLink,
                      ),

                      // initialValue: controller.profile.value.storeMobile,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: controller.isEditinig.value == false
                            ? null
                            : Image.asset(
                                'assets/images/edits.png',
                                height: 10,
                                width: 10,
                                color: Colors.grey,
                                fit: BoxFit.fill,
                              ),
                      ),
                      hintText: '',
                      prefix: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "Location".tr,
                          color: text1Color,
                          alignment: "ENORAR".tr == "ar"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (controller.isEditinig.value)
                            Get.to(const LocationPicker());
                          else {}
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          // height: 50,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.locationCrosshairs,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                FutureBuilder<String>(
                                  future: controller.getLocationNameByLatLong(),
                                  builder: (
                                    BuildContext context,
                                    AsyncSnapshot<String> snapshot,
                                  ) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("");
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return const Text('');
                                      } else if (snapshot.hasData) {
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            (snapshot.data ?? ""),
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      } else {
                                        return const Text('');
                                      }
                                    } else {
                                      return Text(
                                          'State: ${snapshot.connectionState}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(height: 20),
                    CustomFormFiledWithTitle(
                      text: 'joinDate'.tr,
                      hintText: 'joinDate'.tr,
                      read: true,
                      controller: new TextEditingController(
                          text: controller.profile.value.createdAt),
                      prefix: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(11.0), child: null),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormFiledWithTitle(
                      text: 'accountType'.tr,
                      hintText: ''.tr,
                      read: true,
                      controller: new TextEditingController(
                          text: controller.profile.value.payable == true
                              ? "Payable".tr
                              : "Recievable".tr),
                      prefix: const Icon(
                        Icons.account_balance,
                        color: Colors.grey,
                        size: 20,
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(11.0), child: null),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (!controller.isEditinig.value) return;
                            final ImagePicker _picker = ImagePicker();
                            // Pick an image
                            final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 500,
                              maxHeight: 500,
                            );
                            controller.image.value = image!;
                            // setState(() {
                            //   file = image;
                            // });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 10, top: 0, bottom: 10),
                                  child: Text(
                                    "Logo".tr,
                                    style: TextStyle(
                                        fontSize: 12, color: text1Color),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Container(
                                height: (controller.image.value.path == '' &&
                                        controller.profile.value.storeImage ==
                                            null)
                                    ? 0
                                    : MediaQuery.of(context).size.width * .6,
                                width: (controller.image.value.path == '' &&
                                        controller.profile.value.storeImage ==
                                            null)
                                    ? 0
                                    : MediaQuery.of(context).size.width * .8,
                                child: controller.image.value.path == ''
                                    ? controller.profile.value.storeImage !=
                                            null
                                        ? Image.network(
                                            controller.profile.value.storeImage
                                                .toString(),
                                            // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                                            fit: BoxFit.cover,
                                          )
                                        : null
                                    : Image.file(
                                        File(controller.image.value.path),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (controller.isEditinig.value)
                                Text(
                                  "chooseLogo".tr,
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 18),
                                )
                            ],
                          ),
                        ),
                        if (controller.image.value.path != '')
                          Positioned(
                              top: 0,
                              right: 10,
                              child: GestureDetector(
                                  onTap: () {
                                    controller.image.value = XFile('');
                                  },
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 25,
                                  ))),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (controller.isEditinig.value)
                      CustomButtom(
                        text: 'Save'.tr,
                        onPressed: () {
                          // print(controller.mobile);
                          // return;
                          if (controller.profile.value.storeMobile !=
                              controller.mobile) {
                            controller.sendOTP(context);
                            // otp_modal(context).show();
                          } else {
                            controller.updateProfile();
                          }
                          // print(controller.profile.value.storeMobile);
                        },
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            if (controller.profileLoading.value)
              Positioned.fill(
                  // top: MediaQuery.of(context).size.height * 0.4,
                  // right: MediaQuery.of(context).size.width * 0.35,
                  child: const WaiteImage()),
          ],
        );
      }),
    );
  }
}
