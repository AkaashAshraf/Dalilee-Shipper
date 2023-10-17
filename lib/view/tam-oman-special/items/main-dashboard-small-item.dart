import 'package:dalile_customer/config/text_sizes.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class MainDashboardSmallItem extends StatelessWidget {
  const MainDashboardSmallItem({
    Key? key,
    required this.image,
    required this.title,
    required this.value,
    required this.onClick,
    required this.color,
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
        height: getDashbordItemSize(context).mainDashboardSmallItemHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (image.isNotEmpty)
                    Row(
                      children: [
                        Image.asset(
                          image,
                          color: Colors.black,
                          fit: BoxFit.contain,
                          width: getDashbordItemSize(context)
                              .mainDashboardItmeSmallIconSize,
                        ),
                      ],
                    )
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth(context) * 0.2,
                        child: CustomText(
                          text: value,
                          color: Colors.black,
                          size: screenWidth(context) * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
