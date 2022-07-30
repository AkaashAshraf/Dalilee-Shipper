import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class ManageAddressView extends StatelessWidget {
  const ManageAddressView({Key? key}) : super(key: key);

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
            text: 'Manage Address',
            color: whiteColor,
            size: 18,
            alignment: Alignment.center,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children:const [
                         CustomText(
                          text: 'Updated data ',
                          color: Colors.grey,
                          alignment: Alignment.center,
                          size: 10,
                        ),
                         Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 13,
                    child: ListView.separated(
                      separatorBuilder: (context, i) => const SizedBox(height: 13),
                      itemCount: 5,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      itemBuilder: (context, i) {
                        return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: primaryColor.withOpacity(0.1),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: 'Main Address',
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      size: 16,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        'assets/images/edits.png',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomText(
                                  text: 'Muhafaza : Muscat',
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const CustomText(
                                  text: 'Wilaya : Seeb',
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const CustomText(
                                  text: 'Region : Mabela',
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ));
                      },
                    )),
              ],
            )));
  }
}
