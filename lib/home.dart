import 'package:dalile_customer/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HHH extends StatefulWidget {
  const HHH({Key? key}) : super(key: key);

  @override
  State<HHH> createState() => _HHHState();
}

class _HHHState extends State<HHH> {
  @override
  void initState() {
    Get.put(HomeViewModel()).buildProdAlrt(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('cccccc'),
    );
  }
}
