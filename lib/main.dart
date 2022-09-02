import 'package:dalile_customer/core/view_model/profileController.dart';
import 'package:dalile_customer/myapp.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  final controller = Get.put(ProfileController());
}
