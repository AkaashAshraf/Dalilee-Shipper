import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/core/view_model/my_lang_controller.dart';
import 'package:dalile_customer/view/menu/profiles/edit_profile.dart';
import 'package:dalile_customer/view/menu/profiles/terms_Conditions_view.dart';
import 'package:dalile_customer/view/widget/custom_button.dart';
import 'package:dalile_customer/view/widget/custom_form_filed.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        title: const CustomText(
            text: 'SETTINGS',
            color: whiteColor,
            size: 18,
            alignment: Alignment.center),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            _buildRows("Profile", Icons.account_circle_outlined, () {
              Get.to(() => const EditProfile());
            }),

            // const SizedBox(
            //   height: 20,
            // ),
            // _buildRows("Manage Address", Icons.location_on_outlined, () {
            //   Get.to(() => const ManageAddressView());
            // }),
            const SizedBox(
              height: 20,
            ),
            _buildRows("About The App", Icons.phone_iphone_outlined, () {}),
            const SizedBox(
              height: 20,
            ),
            _buildRows("Terms & Conditions", Icons.summarize_outlined, () {
              Get.to(() => const TermsConditions());
            }),
            const SizedBox(
              height: 20,
            ),
            _buildRows("Rating", Icons.star_outlined, () {
              LaunchReview.launch(
                  androidAppId: "thiqatech.dalilee.shipper_app",
                  iOSAppId: "1633078775");
              // showDialog(
              //   context: context,
              //   builder: (_) => AlertDialog(
              //     scrollable: true,
              //     shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(5.0),
              //       ),
              //     ),
              //     content: Builder(builder: (context) {
              //       return Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               const CustomText(
              //                 text: 'Rate The App',
              //                 alignment: Alignment.topLeft,
              //                 color: primaryColor,
              //                 size: 15,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.only(left: 10.0),
              //                 child: IconButton(
              //                   onPressed: () {
              //                     Get.back();
              //                   },
              //                   icon: const Icon(
              //                     Icons.clear_outlined,
              //                     size: 22,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           const CustomText(
              //             text: "Do you like Dalilee Customer App ?",
              //             alignment: Alignment.topCenter,
              //             size: 10,
              //             fontWeight: FontWeight.bold,
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           const CustomText(
              //             text: "Rate your experience",
              //             alignment: Alignment.topCenter,
              //             size: 14,
              //             color: primaryColor,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           const SizedBox(
              //             height: 5,
              //           ),
              //           StarRating(
              //             color: Colors.orangeAccent,
              //             starCount: 5,
              //             rating: 3.5,
              //             onRatingChanged: (c) {},
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           const CustomFormFiledAreaWithTitle(
              //               text: 'Leave us your comment',
              //               hintText: 'Please leave your comment heres'),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           CustomButtom(
              //             text: 'Submit',
              //             onPressed: () {},
              //           ),
              //         ],
              //       );
              //     }),
              //   ),
              // );
            }),
            const SizedBox(
              height: 20,
            ),
            _buildRows("Language", Icons.language, () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  scrollable: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  content: Builder(builder: (context) {
                    return  _Showlung();
                  }),
                ),
              );
            }),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildRows(String title, IconData icon, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: text1Color.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1)
            ]),
        child: ListTile(
          leading: Icon(
            icon,
            color: primaryColor,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(
            Icons.chevron_right_outlined,
            color: primaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _Showlung extends StatelessWidget {
  _Showlung({
    Key? key,
  }) : super(key: key);
  MyLang controller = Get.put(MyLang());
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Language",
                alignment: Alignment.topRight,
                color: primaryColor,
                size: 15,
                fontWeight: FontWeight.w500,
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.clear_outlined,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomFormFiled(
            select: "",
            hint: 'English',
            text: 'Select Language',
            onSaved: (val) {
              if (val == "Arabic") {
                controller.changeLang("ar");
              } else {
                controller.changeLang("en");
              }
              print("$val");
              return null;
            },
            validator: (val) => val == null
                ? 'please enter your account number'
                : val.length > 20
                    ? "max number 20"
                    : null,
            items: const ["English", "Arabic"],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButtom(
            text: 'Save',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  const StarRating(
      {Key? key,
      this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.color})
      : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
      );
    }
    return InkResponse(
      onTap:
          // ignore: unnecessary_null_comparison
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
