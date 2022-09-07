import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/waiting.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return NoDataView(label: label);
  }
}
