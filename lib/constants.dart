import 'package:flutter/material.dart';

bool isTesEnvironment = false;
double omrToAedRate = 9.47;
const int iosVersionLocal = 16; //07/september/2023 //exchange pickup
const int androidVersionLocal = 16; //07/september/2023 //exchange pickup
Color primaryColor = Color(isTesEnvironment ? 0xFF0D7297 : 0xFF7272CF);

const whiteColor = Color(0xFFFFFFFF);
const bgColor = Color(0xFFF8F8F8);
const bgColorDark = Color.fromARGB(255, 236, 236, 236);

const text1Color = Color(0xFF61656A);
Color textBlueColor = Color(isTesEnvironment ? 0xFF0D7297 : 0xFF7272CF);
const textRedColor = Color(0xFFD32F2F);
const cardColor = Color(0xFFF6F6F6);
const dashboardItemColor1 = Color.fromARGB(255, 234, 238, 217);
const dashboardItemColor2 = Color.fromARGB(255, 246, 221, 234);
const dashboardItemColor3 = Color.fromARGB(255, 225, 221, 244);
const dashboardItemColor4 = Color.fromARGB(255, 217, 230, 240);
const dashboardTabsBackgroudColor = Color.fromARGB(255, 232, 241, 243);

// String like = "https://shaheen-test2.dalilee.om/api/v1/store";test 2
// String image = "https://shaheen-test2.dalilee.om/storage/uploads/branches/";test 2

// String domain = "https://shaheen-oman.dalilee.om"; // live

String domain = isTesEnvironment
    ? "https://stgshom.amaanom.com"
    : "https://shaheenom.com"; //

String base_url = "$domain/api"; // live
String terms_url = "$domain/terms"; // live

String like = '$base_url/v1/store'; //live
String image = "$domain/storage/uploads/branches/"; // live

String dalileeOldBaseUrl =
    "https://api.dalilee.net/test/public/api/shaheen-api";

String thawaniPaymentLink =
    "https://api.dalilee.net/test/public/thawanipage?order_no=";

String crmBaseUrl = "https://dalileegate.com/crm/public/api";
