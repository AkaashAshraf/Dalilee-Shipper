import 'package:flutter/material.dart';

// const primaryColor = Colors.green;
bool isTesEnvironment = false;
double omrToAedRate = 9.47;
const int iosVersionLocal = 10; //13/june/2023   assign store to me
const int androidVersionLocal = 10; //13/june/2023   assign store to me

Color primaryColor = Color(isTesEnvironment ? 0xFF76529c : 0xFF00A1E1);

const whiteColor = Color(0xFFFFFFFF);
const bgColor = Color(0xFFF8F8F8);
const text1Color = Color(0xFF61656A);
Color textBlueColor = Color(isTesEnvironment ? 0xFF76529c : 0xFF00A1E1);
const textRedColor = Color(0xFFD32F2F);
const cardColor = Color(0xFFF6F6F6);

// String like = "https://shaheen-test2.dalilee.om/api/v1/store";test 2
// String image = "https://shaheen-test2.dalilee.om/storage/uploads/branches/";test 2

// String domain = "https://shaheen-oman.dalilee.om"; // live

String domain = isTesEnvironment
    ? "https://staging.shaheenom.com"
    : "https://shaheenom.com"; //

String base_url = "$domain/api"; // live
String terms_url = "$domain/terms"; // live

String like = '$base_url/v1/store'; //live
String accountManagerBaseUrl = '$base_url/v1/account-manager'; //live
String image = "$domain/storage/uploads/branches/"; // live

String dalileeOldBaseUrl =
    "https://api.dalilee.net/test/public/api/shaheen-api";

String thawaniPaymentLink =
    "https://api.dalilee.net/test/public/thawanipage?order_no=";

String crmBaseUrl = "https://dalileegate.com/crm/public/api";
