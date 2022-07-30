import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaiteImage extends StatelessWidget {
  const WaiteImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPumpingHeart(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            'assets/images/dalilee.png',
            height: 50,
            width: 50,
          );
        },
      ),
    );
  }
}
