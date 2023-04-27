import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/controllers/login_controller.dart';
import 'package:dalile_customer/model/countries.dart';
import 'package:dalile_customer/view/home/search/search_screen.dart';
import 'package:dalile_customer/view/login/terms_conditions.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _controller = Get.put(LoginController());
  String countryCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: 70,
      //   backgroundColor: primaryColor,
      //   foregroundColor: whiteColor,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Get.to(SearchScreen());
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10),
      //       child: Icon(
      //         Icons.search,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      //   title: CustomText(
      //     text: ''.tr,
      //     color: whiteColor,
      //     size: 18,
      //     alignment: Alignment.center,
      //   ),
      //   centerTitle: true,
      // ),

      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Obx(() {
          return Form(
            key: _controller.globalKey,
            child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset(
                      "assets/images/dalilees.png",
                      fit: BoxFit.contain,
                      height: 220,
                      width: 220,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      text: 'WELCOMETODALILEE'.tr,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      size: 15,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 20),
                          child: Row(
                            children: [
                              Text('Loginby'.tr + " " + "WhatsappNo".tr,
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        // _customDropDownExampleMultiSelection(
                        //     context, controller.countries),

                        Container(
                          child: Column(
                            children: <Widget>[
                              if (false)
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                          value: 0,
                                          groupValue: _controller
                                              .isLoginWithEmail.value,
                                          title: Text("MobileNo".tr),
                                          onChanged: (newValue) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();

                                            setState(() => _controller
                                                .isLoginWithEmail
                                                .value = newValue as int);
                                            selected:
                                            false;
                                          }),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                          value: 1,
                                          groupValue: _controller
                                              .isLoginWithEmail.value,
                                          title: Text("Email".tr),
                                          onChanged: (newValue) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();

                                            setState(() => _controller
                                                .isLoginWithEmail
                                                .value = newValue as int);
                                            activeColor:
                                            primaryColor;
                                            selected:
                                            false;
                                          }),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _controller.isLoginWithEmail.value == 0
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: MyInput(
                              controller: _controller.phoneNumber.value,
                              validator: (x) => _controller.mobileVild(x),
                              keyboardType: TextInputType.number,
                              // limitCharacters: 8,
                              onChanged: (val) {
                                _controller.enteredEmail.value = val;
                              },
                              hintText: 'Entermobile'.tr,
                              prefix: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10),
                                child: SizedBox(
                                    height: 60,
                                    width: 90,
                                    child: DropdownSearch<Country?>(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: InputBorder.none),

                                      dropdownBuilder:
                                          (context, selectedItem) => Center(
                                              child: Image.network(
                                        selectedItem!.flag,
                                        fit: BoxFit.contain,
                                      )),
                                      // Text(selectedItem!.countryCode),
                                      items: _controller.countries,
                                      // maxHeight: 20,
                                      mode: Mode.BOTTOM_SHEET,
                                      selectedItem:
                                          _controller.countries.length > 0
                                              ? _controller.countries[0]
                                              : Country(),
                                      onChanged: (country) {
                                        Get.put(LoginController())
                                            .selectedCountryCode
                                            .value = country!.countryCode;
                                        setState(() {
                                          countryCode = country.countryCode;
                                        });
                                      },
                                      popupTitle: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Select Country",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      popupItemBuilder:
                                          (context, country, bool) => ListTile(
                                        title: Text(
                                            Get.locale.toString() == "en"
                                                ? country!.nameEn
                                                : country!.nameAr),
                                        subtitle: Text(country.countryCode),
                                        leading: Container(
                                            height: 40,
                                            width: 40,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                country.flag,
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      ),
                                      // popupItemBuilder: (context, item, isSelected) =>
                                      //     {},
                                      // selectedItem: "968",
                                    )),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: MyInput(
                              controller: _controller.email.value,
                              validator: (x) => _controller.emailVild(x),
                              keyboardType: TextInputType.emailAddress,
                              limitCharacters: 100,
                              hintText: 'Enteryouremail'.tr,
                              // prefix: Text(''),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: _controller.isAgree.value,
                          onChanged: (value) {
                            _controller.isAgree.value = value!;
                          },
                        ), //Che

                        // const Text(
                        //   'By clicking login I am agree with terms & conditions ',
                        //   textAlign: TextAlign.left,
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        //   maxLines: 4,
                        // ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  Get.to(TermsCondition());
                                  // if (await canLaunch(terms_url))
                                  //   await launch(terms_url);
                                },
                                child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: "clickingAgree".tr,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15)),
                                    TextSpan(
                                        text: "terms&conditions".tr,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                                ),
                              ),
                              // new Text('By clicking login I am agree with',
                              //     textAlign: TextAlign.left),
                              // new Text(' terms & conditions',
                              //     textAlign: TextAlign.left)
                            ],
                          ),
                        )
                        // Text('',
                        //     style: TextStyle(
                        //         fontStyle: FontStyle.italic,
                        //         fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: _controller.isLoading.value
                          ? const WaiteImage()
                          : CustomButtom(
                              text: 'Signin'.tr,
                              backgroundColor: _controller.isAgree.value
                                  ? primaryColor
                                  : Colors.grey,
                              onPressed: _controller.isAgree.value
                                  ? () async {
                                      _controller.getDeviceDetails();
                                      _controller.valid(
                                          countryCode: countryCode);
                                    }
                                  : null),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomButtom(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            // size: 30.0,
                          ),
                          text: 'SearchOrder'.tr,
                          backgroundColor: primaryColor,
                          onPressed: (() => {Get.to(SearchScreen())})),
                    ),
                  ],
                )),
          );
        }),
      ),
    );
  }
}
