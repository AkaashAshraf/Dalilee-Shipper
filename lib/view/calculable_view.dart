import 'package:dalile_customer/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPageView extends StatelessWidget {
  const MenuPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (_model) => _model.screenMenu);
  }
}
