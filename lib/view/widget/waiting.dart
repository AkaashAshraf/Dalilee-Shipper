import 'package:dalile_customer/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_indicator/loading_indicator.dart';

class WaiteImage extends StatelessWidget {
  const WaiteImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45,
        child: LoadingIndicator(
          indicatorType: Indicator.lineSpinFadeLoader,
          colors: [primaryColor],
          strokeWidth: 1,
        ),
      ),
    );
  }
}

class bottomLoadingIndicator extends StatelessWidget {
  const bottomLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        colors: [primaryColor],
        strokeWidth: 1,
      ),
    );
  }
}

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            color: primaryColor,
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: primaryColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
