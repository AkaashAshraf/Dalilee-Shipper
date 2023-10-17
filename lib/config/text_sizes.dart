import 'package:flutter/material.dart';

class Sizes {
  double mainDashboardSmallItemHeight;
  double mainDashboardLargeItemHeight;
  double mainDashboardSmallItemWidth;
  double financeDashboardSmallItemWidth;
  double financeDashboardSmallItemHeight;
  double financeDashboardLandscapeItemWidth;
  double financeDashboardLandscapeItemHeight;
  double financeDashboardPortraitItemWidth;
  double financeDashboardPortraitItemHeight;

  double mainDashboardItmeLargeIconSize;

  double financeDashboardItmePortraitIconSize;
  double financeDashboardItmeLandscapeIconSize;

  double mainDashboardItmeSmallIconSize;

  Sizes({
    required this.mainDashboardLargeItemHeight,
    required this.mainDashboardSmallItemHeight,
    required this.mainDashboardSmallItemWidth,
    required this.mainDashboardItmeSmallIconSize,
    required this.mainDashboardItmeLargeIconSize,
    required this.financeDashboardSmallItemWidth,
    required this.financeDashboardSmallItemHeight,
    required this.financeDashboardLandscapeItemWidth,
    required this.financeDashboardLandscapeItemHeight,
    required this.financeDashboardPortraitItemWidth,
    required this.financeDashboardPortraitItemHeight,
    required this.financeDashboardItmePortraitIconSize,
    required this.financeDashboardItmeLandscapeIconSize,
  });
}

Sizes getDashbordItemSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final sizes = Sizes(
    mainDashboardLargeItemHeight: height * 0.32,
    mainDashboardSmallItemHeight: height * 0.155,
    mainDashboardSmallItemWidth: width * 0.44,
    mainDashboardItmeSmallIconSize: width * 0.08,
    mainDashboardItmeLargeIconSize: width * 0.23,
    financeDashboardItmeLandscapeIconSize: width * 0.17,
    financeDashboardSmallItemWidth: width * 0.44,
    financeDashboardSmallItemHeight: height * 0.125,
    financeDashboardLandscapeItemHeight: height * 0.135,
    financeDashboardLandscapeItemWidth: width,
    financeDashboardPortraitItemHeight: height * 0.26,
    financeDashboardPortraitItemWidth: width * 0.44,
    financeDashboardItmePortraitIconSize: width * 0.16,
  );
  return sizes;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
