import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class MainDashboardLargeItem1 extends StatelessWidget {
  const MainDashboardLargeItem1({
    Key? key,
    required this.image,
    required this.title,
    required this.value,
    required this.color,
    required this.onClick,
  }) : super(key: key);

  final String image;
  final String title;
  final String value;
  final Color color;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: getDashbordItemSize(context).mainDashboardSmallItemWidth,
        height: getDashbordItemSize(context).mainDashboardLargeItemHeight,
        decoration: BoxDecoration(
          color: dashboardItemColor2,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth(context) * 0.2,
                        child: CustomText(
                          text: title,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth(context) * 0.2,
                        child: CustomText(
                          text: value,
                          color: Colors.black,
                          size: screenWidth(context) * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (image.isNotEmpty)
                Row(
                  children: [
                    Image.asset(
                      image,
                      color: Colors.black,
                      fit: BoxFit.contain,
                      width: getDashbordItemSize(context)
                          .mainDashboardItmeLargeIconSize,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
