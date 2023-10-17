import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class FinanceDashboardLandscapeItem extends StatelessWidget {
  const FinanceDashboardLandscapeItem({
    Key? key,
    required this.image,
    required this.title,
    required this.value,
    required this.value2,
    required this.onClick,
    required this.color,
  }) : super(key: key);

  final String image;
  final String title;
  final String value;
  final String value2;

  final Color color;
  final dynamic onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: getDashbordItemSize(context).financeDashboardLandscapeItemWidth,
        height:
            getDashbordItemSize(context).financeDashboardLandscapeItemHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth(context) * 0.35,
                              child: CustomText(
                                text: title,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth(context) * 0.3,
                              child: CustomText(
                                text: value,
                                color: Colors.black,
                                size: screenWidth(context) * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth(context) * 0.3,
                              child: CustomText(
                                text: value2,
                                color: Colors.black,
                                size: screenWidth(context) * 0.038,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                image,
                color: Colors.black,
                fit: BoxFit.contain,
                width: getDashbordItemSize(context)
                    .financeDashboardItmeLandscapeIconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
