
import 'package:dalile_customer/core/server/auth.dart';
import 'package:dalile_customer/view/login/login_view.dart';
import 'package:dalile_customer/view/widget/controller_view.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool status = false;
  @override
  void initState() {
    loginControlfff();
    super.initState();
  
    
  }

  loginControlfff() async {
     await AuthController.isLoginUser().whenComplete(() {
    
    if (AuthController.isL == false) {
      
  setState(() {
      status = false;
  });
    
    } else{
 setState(() {
       status = true;
     });
    }
    
      }); 
   
    

  }

  @override
  Widget build(BuildContext context) {
         print(status.toString());
    return AnimatedSplashScreen(
        splashIconSize: 250,
        splash: Image.asset(
           "assets/images/dalilees.png",
          height: 300,
          width: 250,
        ),
        nextScreen:status? ControllerView():LoginView(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white);
  }
}
