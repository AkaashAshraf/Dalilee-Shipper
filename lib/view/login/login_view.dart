import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/login_view_model.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:dalile_customer/view/widget/my_input.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const CustomText(
                    text: 'WELCOME TO DALILEE SHIPPER',
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
                        padding: const EdgeInsets.only(left: 20),
                        child:
                            Text('Login with', style: TextStyle(fontSize: 18)),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                      value: 0,
                                      groupValue:
                                          _controller.isLoginWithEmail.value,
                                      title: Text("Mobile No"),
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
                                      groupValue:
                                          _controller.isLoginWithEmail.value,
                                      title: Text("Email"),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: MyInput(
                            controller: _controller.phoneNumber.value,
                            validator: (x) => _controller.mobileVild(x),
                            keyboardType: TextInputType.number,
                            limitCharacters: 8,
                            onChanged: (val) {
                              _controller.enteredEmail.value = val;
                            },
                            hintText: 'Enter your mobile number',
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 5.0, top: 15),
                              child: Text('+968'),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: MyInput(
                            controller: _controller.email.value,
                            validator: (x) => _controller.emailVild(x),
                            keyboardType: TextInputType.emailAddress,
                            limitCharacters: 100,
                            hintText: 'Enter your email',
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
                                if (await canLaunch(terms_url))
                                  await launch(terms_url);
                              },
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "by clicking login I am agree with",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15)),
                                  TextSpan(
                                      text: " terms & conditions",
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
                            text: 'login',
                            backgroundColor: _controller.isAgree.value
                                ? primaryColor
                                : Colors.grey,
                            onPressed: _controller.isAgree.value
                                ? () async {
                                    _controller.getDeviceDetails();
                                    _controller.valid();
                                  }
                                : null),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
